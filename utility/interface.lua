ui = {}

ui.panel_color = {0.15, 0.18, 0.24}
ui.stars = {}

ui.left = {
    name = {
        x = 8,
        y = 4,
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
        end,
        text_x = 214,
        text_y = 6,
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
    stars = {
        x = 8,
        y = game.window.height - 16,
        w = 200,
        h = 12,
        color = {0.85, 0.8, 0.1},
        value = function()
            return 100 * (game.fighter.one.stars / 100)
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
        y = 4,
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
        end,
        text_x = game.window.width - 266,
        text_y = 6,
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
    stars = {
        x = game.window.width - 208,
        y = game.window.height - 16,
        w = 200,
        h = 12,
        color = {0.85, 0.8, 0.1},
        value = function()
            return 100 * (game.fighter.two.stars / 100)
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
    draw_rect(panel_color, 0, 0, game.window.width, 20)

    for _, dir in ipairs({"left", "right"}) do
        local d_tbl = ui[dir]

        -- TOP PANEL: Character Names
        x = d_tbl.name.x
        y = d_tbl.name.y
        str = d_tbl.name.value()
        echo(str, d_tbl.name.color, x, y)

        -- TOP PANEL: Health Bars
        w = d_tbl.health.w
        h = d_tbl.health.h
        v = d_tbl.health.value()

        x = d_tbl.health.x
        y = d_tbl.health.y

        draw_rect({0, 0, 0}, x, y, w, h)

        adj = 200 * (v / 100)
        if dir == "right" then
            x = x + (w - adj)
        end
        w = adj
        draw_rect({0.8, 0.1, 0.1}, x, y, w, h)

        -- TOP PANEL: Health Text
        x = d_tbl.health.text_x
        y = d_tbl.health.text_y
        str = "%s / 100" % {tostring(math.round(v)):jright(3)}
        echo_small(str, {1.0, 0.5, 0.5}, x, y)
    end



    -- BOTTOM PANEL ------------------------------------------------------------

    -- BOTTOM PANEL: Background
    draw_rect(panel_color, 0, game.window.height - 60, game.window.width, 60)

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

        -- Background
        draw_rect({0, 0, 0}, x, y, w, h)

        adj = 200 * (v / 100)
        if dir == "right" then
            x = x + (w - adj)
        end
        w = adj
        -- Foreground
        draw_rect(d_tbl.accuracy.color, x, y, w, h)

        -- text indicators
        x = d_tbl.text.x
        y = d_tbl.text.y
        str = d_tbl.text.value()

        echo_small(str, {0.9, 0.8, 0.7}, x, y + 12)
        echo("%s player Accuracy: %d%%" % {dir:title(), v}, {0.9, 0.8, 0.7}, x, y + 32)

        -- BOTTOM PANEL: Star Meter
        x = d_tbl.stars.x
        y = d_tbl.stars.y
        w = d_tbl.stars.w
        h = d_tbl.stars.h
        v = d_tbl.stars.value()
        -- Background
        draw_rect({0, 0, 0}, x, y, w, h)
        -- Foreground
        adj = 200 * (v / 100)
        if dir == "right" then
            x = x + (w - adj)
        end
        w = adj
        draw_rect(d_tbl.stars.color, x, y, w, h)

        -- stars = {
        --     x = 8,
        --     y = game.window.height - 16,
        --     w = 200,
        --     h = 12,
        --     color = {0.85, 0.8, 0.1},
        --     value = function()
        --         return 100 * (game.fighter.two.stars / 100)
        --     end
        -- },
    end



    -- THE ALMIGHTY ORB --------------------------------------------------------
    w = 48
    h = 48
    x = ((game.window.width / 2) - (w / 2)) + (w / 2) -- to center it
    y = game.window.height - 64
    -- Background
    draw_circ({0, 0, 0}, x, y, w, h)
    local num_stars = game.match.free_luck

    for _, s_tbl in ipairs(ui.stars) do
        local sx = s_tbl.x + (x - (w - 16))
        local sy = s_tbl.y + (y - (w - 16))

        set_color(1.0, 1.0, 1.0)
        love.graphics.points(sx, sy)
        reset_color()
    end

    echo_small("%d stars!" % num_stars, {0.85, 0.8, 0.15}, x - 20, game.window.height - 12)


    -- Finish up! --------------------------------------------------------------
    reset_color()
end