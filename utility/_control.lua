function love.keypressed(key, code, rep)
    if key:lower() == "q" then
        love.event.quit()
        return
    end

    if key:lower() == "r" then
        love.event.push("quit", "restart")
        return
    end

    if key:lower() == "z" then
        game.attack_cd = true
        game.fighter.one.attacking = true
    end
    
    if key:lower() == "x" then
        game.attack_cd = true
        game.fighter.two.attacking = true
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