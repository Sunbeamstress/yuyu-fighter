function love.keypressed(key, code, rep)
    if key:lower() == "q" then
        love.event.quit()
        return
    end

    if key:lower() == "r" then
        love.event.push("quit", "restart")
        return
    end
end



function love.textinput(t)

end



function love.mousemoved(x, y, dx, dy)

end



function love.mousepressed(x, y, btn)

end



function love.mousereleased(x, y, btn)

end