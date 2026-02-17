-- echo(): Shortcut function for printing text to the screen.
-- A variant of love.graphics.printf() meant to assume as many arguments as
-- possible.
--
-- str: the string you wish to print to the screen.
-- col: table {r, g, b[, a]} representing the color of the string.
--      color ranges from 0.0 to 1.0
-- x, y: the position on screen, in pixels, where you will draw this text
-- wrap_to: how far the string is allowed to display before it wraps around
--          to the other side. by default, will be permitted to wrap all the
--          way to the window's edge.
-- align: left, center, right, or justified. do we have justified? does that
--        actually work? idk
-- font: only two choices for now: main, or small.
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



-- echo_small(): a shortcut for echoing small text. otherwise works identically
-- to echo().
function echo_small(str, col, x, y, wrap, align)
    echo(str, col, x, y, wrap, align, "small")
end



-- draw_rect(): shorthand to draw LOVE 2D boxes to the screen.
--
-- col: table {r, g, b[, a]} representing the color of the rectangle.
--      color ranges from 0.0 to 1.0
-- x, y: the position in pixels of where this rectangle begins on the screen.
--       its origin point is always its upper left corner!
-- w, h: the rectangle's width and height
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



-- draw_border(): just like draw_rect() above, but this one draws an unfilled
-- rectangle of varying thickness.
--
-- thickness: must be an integer. the thickness of the border, in pixels.
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



-- draw_circ(): like draw_rect() and draw_border() above, but for circles!
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