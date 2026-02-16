function quit_game()
    love.event.quit()
end



function restart_game()
    love.event.push("quit", "restart")
end



function start_attack(ply)
    if fighter_can_attack(ply) then
        game.fighter[ply].charging_attack = true
    end
end



function end_attack(ply)
    game.fighter[ply].charging_attack = false

    if game.fighter[ply].accuracy > 0 then
        game.fighter[ply].released_attack = true
    end
end