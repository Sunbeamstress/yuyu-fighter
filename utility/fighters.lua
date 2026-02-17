game.fighterstate_idle = 0
game.fighterstate_preparing = 1
game.fighterstate_attacking = 2
game.fighterstate_hurt = 3

game.fighter = {}

game.fighter.one = {
    -- States and current fighter state
    health = 100,
    power = 0,
    speed = 1.0,
    poise = 0,
    resource = 0,
    stars = 0,
    text = "",
    state = game.fighterstate_idle,

    -- Physical/graphical properties
    x = 0,                     -- fighter's base location on the x-axis. this never changes!
    y = 0,                     -- fighter's base location on the y-axis. this never changes!
    width = 303,               -- width of the fighter's sprite in px.
    height = 317,              -- height of the fighter's sprite in px.
    x_mod = 0,                 -- used by hurt states, impacts, etc. to determine shake value for the sprite
    y_mod = 0,                 -- used by hurt states, impacts, etc. to determine shake value for the sprite
    x_drift = 0,               -- how far the sprite has "wandered" in pixels on the x-axis
    y_drift = 0,               -- how far the sprite has "wandered" in pixels on the y-axis
    x_drift_dir = 1,           -- 1 for right, -1 for left
    y_drift_dir = 0,           -- 1 for up, -1 for down
    drift_rate = 1,            -- how often does this character shift direction when drifting?
                               -- lower is faster, more frequent shifts
    stepping = false,          -- whether the fighter is taking a 'step'
    last_step = 0,
    last_dir_change = 0,
    wander_back = false,

    -- Attack tracking
    charging_attack = false,
    released_attack = false,
    attack_cooldown = false,
    attack_cooldown_progress = 0,
    attack_cooldown_time = 0,
}



game.fighter.two = table.deepcopy(game.fighter.one)
game.fighter.two.health = 90
game.fighter.two.speed = 1.2
game.fighter.two.x = game.window.width
game.fighter.two.drift_rate = 0.8
game.fighter.two.x_drift_dir = -1



function fighter_can_attack(ply)
    return not game.fighter[ply].attack_cooldown
    and (game.fighter[ply].state ~= game.fighterstate_hurt and game.fighter[ply].state ~= game.fighterstate_attacking)
end



function fighter_defeated(ply)
    game.fighter[ply].text = "K.O.!!"
end



function fighter_attack_cooldown(ply, time)
    -- Governs how long a fighter is stalled after releasing an attack.
    game.fighter[ply].attack_cooldown = true
    game.fighter[ply].attack_cooldown_progress = 0
    game.fighter[ply].attack_cooldown_time = time
    game.fighter[ply].power = 0
end



function fighter_attack_recover(ply)
    -- This fighter has recovered, and is actionable again.
    game.fighter[ply].attack_cooldown = false
    game.fighter[ply].attack_cooldown_progress = 0
    game.fighter[ply].attack_cooldown_time = 0

    game.fighter[ply].state = game.fighterstate_idle

    game.fighter[ply].text = ""
end



function fighter_attack_connected(ply)
    -- Assume p2 is the default target
    local tar = (ply == "two" and "one") or "two"

    game.fighter[ply].text = "Hit!"

    -- Calculate some damage. We'll let the attacks hit harder if they had more
    -- stars when they released.
    local dmg_base = 8 + (24 * (game.fighter[ply].stars / 100))
    local dmg = math.random(dmg_base, dmg_base + 5)

    fighter_attack_received(tar, dmg)
    game.fighter[ply].text = "%s Dealt %d damage." % {game.fighter[ply].text, dmg}
    fighter_attack_cooldown(ply, 0.5)

    absorb_lucky_stars(ply)

    love.audio.play(game.sound.blow)
end



function fighter_attack_received(ply, dmg)
    game.fighter[ply].state = game.fighterstate_hurt

    local new_h = game.fighter[ply].health - dmg
    if new_h < 0 then
        fighter_defeated(ply)
    end
    game.fighter[ply].health = math.clamp(new_h, 0, 100)

    fighter_attack_cooldown(ply, 0.35)
end



function fighter_attack_missed(ply)
    game.fighter[ply].text = "Missed."
    fighter_attack_cooldown(ply, 0.8)

    love.audio.play(game.sound.miss)
end



function fighter_attack_roll(ply, acc)
    game.fighter[ply].released_attack = false

    -- Roll the dice based on their power.
    local r = math.random(100)
    if r < acc then
        -- Attack hit.
        fighter_attack_connected(ply)
    else
        -- Attack missed.
        fighter_attack_missed(ply)
    end
end



function fighter_state(ply, state)
    if tostring(ply) then
        if ply == "1" then
            ply = "one"
        elseif ply == "2" then
            ply = "two"
        end
    elseif tonumber(ply) then
        if ply == 1 then
            ply = "one"
        elseif ply == 2 then
            ply = "two"
        else
            error("fighter_state(): invalid fighter, %s, passed" % {tostring(ply)})
        end
    else
        error("fighter_state(): invalid fighter type '%s' passed. must be string or number, and only either 1, 2, one, or two." % {type(ply)})
    end

    state = state:lower()

    local s = game["fighterstate_%s" % state] or -1

    return game.fighter[ply].state == s
end

function fighter_power_generation(fighter, dt)
    local new_pow = fighter.speed - dt
    if fighter.state == game.fighterstate_hurt or fighter.attack_cooldown then
        new_pow = 0 -- halt generation entirely
    elseif fighter.charging_attack then
        new_pow = new_pow * 0.55 -- full speed if we're charging up
    else
        new_pow = new_pow * 0.15 -- slow if we're idling
    end
    fighter.power = math.clamp(fighter.power + new_pow, 0, 100)
end

function update_fighters(dt)
    for _, ply in ipairs({"one", "two"}) do
        local fighter = game.fighter[ply]

        local acc = fighter.power
        local cd_time = fighter.attack_cooldown_time
        local drifting = false

        -- Is the fighter hurt? They should be shaking
        local x, y = fighter.x, fighter.y
        local xmod, ymod = 0, 0

        if fighter_state(ply, "hurt") then
            local dist = 4

            -- Adjust x/ymods
            local r = math.random(100)
            if math.random(2) == 2 then r = 0 - r end -- flip it to negative
            xmod = dist * (r / 100)

            r = math.random(50)
            if math.random(2) == 2 then r = 0 - r end -- flip it to negative
            ymod = dist * (r / 100)

            fighter.x_mod = xmod
            fighter.y_mod = ymod
        else
            fighter.x_mod = 0
            fighter.y_mod = 0
        end

        if fighter.attack_cooldown then
            -- 1. Has this fighter released an attack and is now cooling down?
            local new_p = fighter.attack_cooldown_progress + dt
            if new_p > cd_time then
                fighter_attack_recover(ply)
            else
                fighter.attack_cooldown_progress = new_p
            end
        elseif fighter.released_attack then
            -- 2. This fighter just released an attack!
            fighter.state = game.fighterstate_attacking
            fighter_attack_roll(ply, acc)

        elseif fighter.charging_attack then
            -- 3. This fighter is charging an attack, therefore they gain power faster.
            fighter.state = game.fighterstate_preparing

            --local new_acc = fighter.speed - dt
            --new_acc = new_acc * 0.55 -- slow down the power generation just a little

            --fighter.power = math.clamp(fighter.power + new_acc, 0, 100)
        else
            drifting = true
        end
        fighter_power_generation(fighter, dt)

        if drifting then
        end
    end
end



function draw_fighters()
    local x1, y1 = game.fighter.one.x, game.fighter.one.y
    local x2, y2 = game.fighter.two.x, game.fighter.two.y
    local w1, h1 = game.fighter.one.width, game.fighter.one.height
    local w2, h2 = game.fighter.two.width, game.fighter.two.height
    local xmod1, ymod1 = game.fighter.one.x_mod, game.fighter.one.y_mod
    local xmod2, ymod2 = game.fighter.two.x_mod, game.fighter.two.y_mod
    local xdrift1, ydrift1 = game.fighter.one.x_drift, game.fighter.one.y_drift
    local xdrift2, ydrift2 = game.fighter.two.x_drift, game.fighter.two.y_drift

    local sprite1 = game.sprite.testguy.idle
    local sprite2 = game.sprite.testguytwo.idle

    -- FIGHTER ONE -------------------------------------------------------------
    if game.fighter.one.state == game.fighterstate_preparing then
        sprite1 = game.sprite.testguy.prepare
    elseif game.fighter.one.state == game.fighterstate_attacking then
        sprite1 = game.sprite.testguy.attack
    elseif game.fighter.one.state == game.fighterstate_hurt then
        sprite1 = game.sprite.testguy.hurt
    end

    love.graphics.draw(sprite1, x1 + xmod1 + xdrift1, y1 + ymod1 + ydrift1)

    -- FIGHTER TWO -------------------------------------------------------------
    if game.fighter.two.state == game.fighterstate_preparing then
        sprite2 = game.sprite.testguytwo.prepare
    elseif game.fighter.two.state == game.fighterstate_attacking then
        sprite2 = game.sprite.testguytwo.attack
    elseif game.fighter.two.state == game.fighterstate_hurt then
        sprite2 = game.sprite.testguytwo.hurt
    end

    love.graphics.draw(sprite2, x2 + xmod2 + xdrift2, y2 + ymod2 + ydrift2, 0, -1, 1)
end