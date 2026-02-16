local ui = {}

ui.panel_color = {0.15, 0.18, 0.24}

ui.left = {
    name = {
        x = 8,
        y = 2,
        color = {0.9, 0.9, 0.9},
        value = function ()
            return "Test Guy" -- this should derive from the character's name!
        end,
    },
    health = {
        x = 70,
        y = 4,
        w = 200,
        h = 12,
        value = function ()
            return 100 * (game.fighter.one.health / 100)
        end
    },
    accuracy = {
        x = 8,
        y = game.window.height - 50,
        w = 200,
        h = 10,
        color = {0.5, 0.5, 0.7},
        value = function ()
            return 100 * (game.fighter.one.accuracy / 100)
        end
    },
    text = {
        x = 8,
        y = game.window.height - 70,
        value = function ()
            return game.fighter.one.text
        end,
    },
}



ui.right = {
    name = {
        x = game.window.width - 64,
        y = 2,
        color = {0.9, 0.9, 0.9},
        value = function ()
            return "Test Guy" -- this should derive from the character's name!
        end,
    },
    health = {
        x = game.window.width - 270,
        y = 4,
        w = 200,
        h = 12,
        value = function ()
            return 100 * (game.fighter.two.health / 100)
        end
    },
    accuracy = {
        x = game.window.width - 208,
        y = game.window.height - 50,
        w = 200,
        h = 10,
        color = {0.5, 0.5, 0.7},
        value = function ()
            return 100 * (game.fighter.two.accuracy / 100)
        end
    },
    text = {
        x = game.window.width - 208,
        y = game.window.height - 70,
        value = function ()
            return game.fighter.two.text
        end,
    },
}




function draw_interface()
    local x, y, w, h, v, str, adj
    local panel_color = {0.15, 0.18, 0.24}



    -- TOP PANEL ---------------------------------------------------------------

    -- TOP PANEL: Background
    set_color(unpack(panel_color))
    love.graphics.rectangle("fill", 0, 0, game.window.width, 20)

    for _, dir in ipairs({"left", "right"}) do
        local d_tbl = ui[dir]

        -- TOP PANEL: Character Names
        set_color(unpack(d_tbl.name.color))
        x = d_tbl.name.x
        y = d_tbl.name.y
        str = d_tbl.name.value()
        love.graphics.print(str, x, y)

        -- TOP PANEL: Health Bars
        w = d_tbl.health.w
        h = d_tbl.health.h
        v = d_tbl.health.value()

        x = d_tbl.health.x
        y = d_tbl.health.y

        set_color(0) -- background
        love.graphics.rectangle("fill", x, y, w, h)

        adj = 200 * (v / 100)
        if dir == "right" then
            x = x + (w - adj)
        end
        w = adj
        set_color(0.8, 0.1, 0.1)
        love.graphics.rectangle("fill", x, y, w, h)
    end



    -- BOTTOM PANEL ------------------------------------------------------------

    -- BOTTOM PANEL: Background
    set_color(unpack(panel_color))
    love.graphics.rectangle("fill", 0, game.window.height - 60, game.window.width, 60)

    -- BOTTOM PANEL: Accuracy Bars
    x = 8
    y = game.window.height - 50
    w = 200
    h = 10

    for _, dir in ipairs({"left", "right"}) do
        local d_tbl = ui[dir]

        -- BOTTOM PANEL: Accuracy Bars
        x = d_tbl.accuracy.x
        y = d_tbl.accuracy.y
        w = d_tbl.accuracy.w
        h = d_tbl.accuracy.h
        v = d_tbl.accuracy.value()

        set_color(0) -- background
        love.graphics.rectangle("fill", x, y, w, h)

        set_color(unpack(d_tbl.accuracy.color)) -- foreground
        adj = 200 * (v / 100)
        if dir == "right" then
            x = x + (w - adj)
        end
        w = adj
        love.graphics.rectangle("fill", x, y, w, h)

        -- text indicators
        x = d_tbl.text.x
        y = d_tbl.text.y
        str = d_tbl.text.value()

        set_color(0.9, 0.8, 0.7)
        love.graphics.print(str, x, y + 4)
        love.graphics.print("%s player Accuracy: %d%%" % {dir:title(), v}, x, y + 32)
    end



    -- Finish up! --------------------------------------------------------------
    reset_color()
end