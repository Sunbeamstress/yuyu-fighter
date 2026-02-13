function set_color(r, g, b, a)
    a = a or 255
    love.graphics.setColor(love.math.colorFromBytes(r, g, b, a))
end