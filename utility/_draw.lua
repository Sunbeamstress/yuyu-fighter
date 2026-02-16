function love.draw()
    love.graphics.setCanvas(game.canvas)
    love.graphics.clear()

    draw_stage_bg()
    draw_fighters()
    draw_interface()

    love.graphics.setCanvas()

    local ratio = game.window.ratio
    love.graphics.draw(game.canvas, game.window.x_offset, game.window.y_offset, 0, ratio, ratio)
end



function love.resize(w, h)
    last_width = last_width or w
    last_height = last_height or w

    local w_min, h_min = 640, 360

    -- get the individual ratios of width vs. height to see which has the smaller one
    -- smaller has to win!
    local check_w = math.clamp(w, w_min, 9999)
    local check_h = math.clamp(h, h_min, 9999)

    local w_ratio = check_w / w_min
    local h_ratio = check_h / h_min

    if w_ratio < h_ratio then
        game.window.ratio = w_ratio
    else
        game.window.ratio = h_ratio
    end

    local r = game.window.ratio

    local w_size = game.window.width * r
    local h_size = game.window.height * r
    game.window.x_offset = (w - w_size) / 2
    game.window.y_offset = (h - h_size) / 2

    last_width = w
    last_height = h
end