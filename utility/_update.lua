function love.update(dt)
    if game.attack_cd then
        game.attack_progress = game.attack_progress or 0
        game.attack_progress = game.attack_progress + dt

        if game.attack_progress >= 0.2 then
            -- If the character has been in an attack for 1 second or more, go back to neutral.
            game.fighter.one.attacking = false
            game.fighter.two.attacking = false
            game.attack_progress = nil
        end
    end
end