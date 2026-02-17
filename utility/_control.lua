function love.keypressed(key, code, rep)
    if key:lower() == "q" then
        quit_game()
        return
    end

    if key:lower() == "r" then
        restart_game()
        return
    end

    if key:lower() == "z" then
        start_attack("one")
    end

    if key:lower() == "x" then
        start_attack("two")
    end

    if key:lower() == "a" then
        stance_swap("one")
    end

    if key:lower() == "s" then
        stance_swap("two")
    end
end



function love.keyreleased(key, code, rep)
    if key:lower() == "z" then
        end_attack("one")
    end
    
    if key:lower() == "x" then
        end_attack("two")
    end
end



-- function love.mousemoved(x, y, dx, dy)
-- end

-- function love.mousepressed(x, y, btn)
-- end

-- function love.mousereleased(x, y, btn)
-- end