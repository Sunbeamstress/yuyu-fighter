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
        if not game.attack_cd then
            game.fighter.one.preparing = true
        end
    end
    
    if key:lower() == "x" then
        if not game.attack_cd then
            game.fighter.two.preparing = true
        end
    end
end

function love.keyreleased(key, code, rep)
    if key:lower() == "z" then
        if not game.attack_cd then
            game.attack_cd = true
            game.fighter.one.preparing = false
            game.fighter.one.attacking = true
        end
    end
    
    if key:lower() == "x" then
        if not game.attack_cd then
            game.attack_cd = true
            game.fighter.two.preparing = false
            game.fighter.two.attacking = true
        end
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