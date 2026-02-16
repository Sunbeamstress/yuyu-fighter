function echo(str, col, x, y, wrap_to, align, font)
    col = col or {0.8, 0.8, 0.8}

    x = x or 0
    y = y or 0

    wrap_to = wrap_to or game.window.width - x
    align = align or "left"
    font = font or "main"

    set_color(unpack(col))
    love.graphics.printf(str, game.fonts[font], x, y, wrap_to, align)
    reset_color()
end



function echo_small(str, col, x, y, wrap, align)
    echo(str, col, x, y, wrap, align, "small")
end



function draw_rect(col, x, y, w, h)
    col = col or {0.8, 0.8, 0.8}

    x = x or 0
    y = y or 0
    w = w or 0
    h = h or 0

    set_color(unpack(col))
    love.graphics.rectangle("fill", x, y, w, h)
    reset_color()
end



function draw_border(col, thickness, x, y, w, h)
    col = col or {0.8, 0.8, 0.8}

    thickness = thickness or 1
    x = x or 0
    y = y or 0
    w = w or 0
    h = h or 0

    set_color(unpack(col))
    for i = 1, thickness do
        love.graphics.rectangle("line", x + (i - 1), y + (i - 1), w - ((i - 1) * 2), h - ((i - 1) * 2))
    end
    reset_color()
end



function draw_circ(col, x, y, w, h)
    col = col or {0.8, 0.8, 0.8}

    x = x or 0
    y = y or 0
    w = w or 0
    h = h or 0

    set_color(unpack(col))
    love.graphics.ellipse("fill", x, y, w, h)
    reset_color()
end