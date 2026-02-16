game.match = {}

-- how many lucky stars are currently up for grabs
game.match.free_luck = 0
-- how many seconds before stars begin to generate
game.match.star_delay = 3
-- how many stars do we release each tick?
game.match.star_release = 2
-- time in seconds between lucky stars
game.match.star_rate = 1
-- how many stars can be generated
game.match.star_max = 100
-- size, in pixels, of the starfield
game.match.star_range = 64



function release_lucky_stars(num)
    num = num or 2
    game.match.free_luck = math.clamp(game.match.free_luck + num, 0, game.match.star_max)

    if game.match.free_luck > #ui.stars then
        love.audio.play(game.sound.blow)
        for i = 1, num do
            table.insert(ui.stars, {x = math.random(game.match.star_range), y = math.random(game.match.star_range)})
        end
    end
end



function absorb_lucky_stars(ply, num)
    -- If no number is specified, we take ALL the stars.
    num = num or game.match.free_luck
    local diff = game.match.free_luck - num

    game.fighter[ply].stars = game.fighter[ply].stars + num

    game.match.free_luck = math.clamp(game.match.free_luck - num, 0, game.match.star_max)
    if game.match.free_luck == 0 then
        ui.stars = {}
    else
        for i = 1, diff do
            table.remove(ui.stars, i)
        end
    end
end



function update_stars(dt)
    last_star = last_star or 0
    next_star = next_star or game.match.star_delay

    if last_star > next_star then
        -- Every 3 seconds, we release a star
        release_lucky_stars(game.match.star_release)
        next_star = last_star + game.match.star_rate
    end


    
    for n, s_tbl in ipairs(ui.stars) do
        -- Should range vaguely from -1.0 to +1.0
        local speed = math.random(100) / 100
        local wiggle1 = (1 - (2 * (math.random(100) / 100))) * speed
        local wiggle2 = (1 - (2 * (math.random(100) / 100))) * speed

        ui.stars[n].x = math.clamp(s_tbl.x + wiggle1, 0, game.match.star_range)
        ui.stars[n].y = math.clamp(s_tbl.y + wiggle2, 0, game.match.star_range)
    end

    last_star = last_star + dt
end