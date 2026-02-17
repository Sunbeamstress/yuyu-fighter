-- FOR DEBUGGING ---------------------------------------------------------------

function quit_game()
    love.event.quit()
end



function restart_game()
    love.event.push("quit", "restart")
end

--------------------------------------------------------------------------------



-- CORE CONTROLS ---------------------------------------------------------------

function start_attack(ply)
    if fighter_can_attack(ply) then
        change_stance(ply,false,game.fighter_stance_neutral)
        game.fighter[ply].charging_attack = true
    end
end



function end_attack(ply)
    game.fighter[ply].charging_attack = false

    if game.fighter[ply].power > 0 then
        game.fighter[ply].released_attack = true
    end
end



function change_stance(ply, voluntary, intended_stance)
    if voluntary == true then
        if game.fighter[ply].power < 10 then
            love.audio.play(game.sound.ui_nope)
            game.fighter[ply].text_timer = 30
            game.fighter[ply].text = "Need 10 power!"
            return
        end

        if game.fighter[ply].state ~= game.fighter_state_idle then
            love.audio.play(game.sound.ui_nope)
            game.fighter[ply].text_timer = 30
            game.fighter[ply].text = "Can't do that yet!"
            return
        end
    end

     if voluntary == true then
        fighter_power_reduction_flat(game.fighter[ply], 10) -- pay 10 to change stance if changing manually
     end

     game.fighter[ply].stance = intended_stance
end



function stance_swap(ply)
    if fighter_stance(ply, "defensive") then
        change_stance(ply,true,game.fighter_stance_neutral)
    else
        change_stance(ply,true,game.fighter_stance_defensive)
    end
end

--------------------------------------------------------------------------------