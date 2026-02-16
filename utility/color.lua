function set_color(r, g, b, a)
    -- Quick lil helper function to save on typing
    if r and not g and not b then
        g = r
        b = r
    end

    a = a or 255
    love.graphics.setColor(r, g, b, a)
end



function reset_color()
    set_color(1.0, 1.0, 1.0, 1.0)
end