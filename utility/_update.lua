game.state = {}
game.state.accuracygen = 0
game.state.accuracygenlocked = false

function love.update(dt)
    game.shader_timer = game.shader_timer + dt
    game.shader.vertigo_city:send("shader_timer", game.shader_timer)

    if game.state.accuracygenlocked == false then
        game.state.accuracygen = math.random(0,100)
    end

    if game.fighter.one.state == game.fighterstate_preparing then
        game.fighter.one.accuracy = math.clamp(game.fighter.one.accuracy + 1, 0, 100)
    end

    if game.fighter.two.state == game.fighterstate_preparing then
        game.fighter.two.accuracy = math.clamp(game.fighter.two.accuracy + 1, 0, 100)
    end

    if game.fighter.one.state == game.fighterstate_attacking then
        game.state.accuracygenlocked = true
        if game.fighter.one.accuracy <= game.state.accuracygen then
            game.fighter.one.text = "Missed!"
        else
            game.fighter.one.text = "Hit!"
            game.fighter.two.state = game.fighterstate_hurt
        end
        --game.fighter.two.accuracy = 0
    end

    if game.fighter.two.state == game.fighterstate_attacking then
        game.state.accuracygenlocked = true
        if game.fighter.two.accuracy <= game.state.accuracygen then
            game.fighter.two.text = "Missed!"
        else
            game.fighter.two.text = "Hit!"
            game.fighter.one.state = game.fighterstate_hurt 
        end
        --game.fighter.one.accuracy = 0
    end

    if game.attack_cd then
        game.state.accuracygenlocked = true
        game.attack_progress = game.attack_progress or 0
        game.attack_progress = game.attack_progress + dt

        if game.attack_progress >= 0.5 then
            -- If the character has been in an attack for 1 second or more, go back to neutral.
            if game.fighter.one.state == game.fighterstate_hurt or game.fighter.one.state == game.fighterstate_attacking then
                game.fighter.one.state = game.fighterstate_idle
                game.fighter.one.accuracy = 0
            end
            if game.fighter.two.state == game.fighterstate_hurt or game.fighter.two.state == game.fighterstate_attacking then
                game.fighter.two.state = game.fighterstate_idle
                game.fighter.two.accuracy = 0
            end
            game.fighter.one.text = ""
            game.fighter.two.text = ""
            game.state.accuracygenlocked = false
            game.attack_progress = nil
            game.attack_cd = nil
        end
    end
end