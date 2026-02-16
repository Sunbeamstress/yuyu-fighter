game.fighterstate_idle = 0
game.fighterstate_preparing = 1
game.fighterstate_attacking = 2
game.fighterstate_hurt = 3

game.fighter = {}



game.fighter.one = {
    health = 100,
    accuracy = 0,
    speed = 1.0,
    poise = 0,
    resource = 0,
    stars = 0,
    text = "",
    state = game.fighterstate_idle,
    x = 0,
    y = 0,
    charging_attack = false,
    released_attack = false,
    attack_cooldown = false,
    attack_cooldown_progress = 0,
    attack_cooldown_time = 0,
}

game.fighter.two = {
    health = 90,
    accuracy = 0,
    speed = 1.2,
    poise = 0,
    resource = 0,
    stars = 0,
    text = "",
    state = game.fighterstate_idle,
    x = 640,
    y = 0,
    charging_attack = false,
    released_attack = false,
    attack_cooldown = false,
    attack_cooldown_progress = 0,
    attack_cooldown_time = 0,
}



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
    game.fighter[ply].accuracy = 0
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

    -- Roll the dice based on their accuracy.
    local r = math.random(100)
    if r < acc then
        -- Attack hit.
        fighter_attack_connected(ply)
    else
        -- Attack missed.
        fighter_attack_missed(ply)
    end
end



function update_fighters(dt)
    for _, ply in ipairs({"one", "two"}) do
        local acc = game.fighter[ply].accuracy
        local cd_time = game.fighter[ply].attack_cooldown_time

        -- Has this fighter released an attack and is now cooling down?
        if game.fighter[ply].attack_cooldown then
            local new_p = game.fighter[ply].attack_cooldown_progress + dt
            if new_p > cd_time then
                fighter_attack_recover(ply)
            else
                game.fighter[ply].attack_cooldown_progress = new_p
            end

            return
        end

        -- Fighter is not on cooldown, entering the state machine.
        if game.fighter[ply].released_attack then
            -- 1. This fighter just released an attack!
            game.fighter[ply].state = game.fighterstate_attacking
            fighter_attack_roll(ply, acc)

        elseif game.fighter[ply].charging_attack then
            -- 2. This fighter is charging an attack, therefore they gain accuracy.
            game.fighter[ply].state = game.fighterstate_preparing

            local new_acc = game.fighter[ply].speed - dt
            new_acc = new_acc * 0.55 -- slow down the accuracy generation just a little

            game.fighter[ply].accuracy = math.clamp(game.fighter[ply].accuracy + new_acc, 0, 100)
        end
    end
end



function draw_fighters()
    local x1, y1 = game.fighter.one.x, game.fighter.one.y
    local x2, y2 = game.fighter.two.x, game.fighter.two.y

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

    love.graphics.draw(sprite1, x1, y1)

    -- FIGHTER TWO -------------------------------------------------------------
    if game.fighter.two.state == game.fighterstate_preparing then
        sprite2 = game.sprite.testguytwo.prepare
    elseif game.fighter.two.state == game.fighterstate_attacking then
        sprite2 = game.sprite.testguytwo.attack
    elseif game.fighter.two.state == game.fighterstate_hurt then
        sprite2 = game.sprite.testguytwo.hurt
    end

    love.graphics.draw(sprite2, x2, y2, 0, -1, 1)
end