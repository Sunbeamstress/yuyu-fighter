function draw_interface()
    local x, y, w, h
    local panel_color = {0.15, 0.18, 0.24}



    -- TOP PANEL
    x = 0
    y = 0
    w = game.window.width
    h = 20

    -- TOP PANEL: Background
    set_color(unpack(panel_color))
    love.graphics.rectangle("fill", x, y, w, h)

    -- TOP PANEL: Character names
    set_color(0.9)
    love.graphics.print(game.character.testguy.name, 8, 2) -- P1
    set_color(0.9)
    love.graphics.print(game.character.testguy.name, game.window.width - 64, 2) -- P2

    -- TOP PANEL: Health Bars
    set_color(0)             -- background
    love.graphics.rectangle("fill", 70, 4, 200, 12) -- P1
    love.graphics.rectangle("fill", game.window.width - 270, 4, 200, 12) -- P2

    set_color(0.8, 0.1, 0.1) -- foreground
    w = 200 * (game.fighter.one.health / 100)
    x = 70
    love.graphics.rectangle("fill", x, 4, w, 12) -- P1
    w = 200 * (game.fighter.two.health / 100)
    x = (game.window.width - 270) + (200 - w)
    love.graphics.rectangle("fill", x, 4, w, 12) -- P2



    -- BOTTOM PANEL
    x = 0
    y = game.window.height - 60
    w = game.window.width
    h = 60

    -- BOTTOM PANEL: Background
    set_color(unpack(panel_color))
    love.graphics.rectangle("fill", x, y, w, h)

    -- BOTTOM PANEL: Accuracy Bars
    x = 8
    y = game.window.height - 50
    w = 200
    h = 10
    set_color(0)             -- background
    love.graphics.rectangle("fill", x, y, w, h) -- P1
    love.graphics.rectangle("fill", game.window.width - (208), y, w, h) -- P2
    w = 200 * (game.fighter.one.accuracy / 100)
    set_color(0.5, 0.5, 0.7) -- foreground
    love.graphics.rectangle("fill", x, y, w, h) -- P1
    w = 200 * (game.fighter.two.accuracy / 100)
    x = (game.window.width - 208) + (200 - w)
    love.graphics.rectangle("fill", x, y, w, h) -- P2



    -- Finish up
    reset_color()
end