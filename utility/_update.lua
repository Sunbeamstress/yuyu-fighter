game.state = {}



function love.update(dt)
    update_stars(dt)
    update_shader(dt)
    update_fighters(dt)
end