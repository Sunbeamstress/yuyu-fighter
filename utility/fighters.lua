game.fighter = {}

game.fighter.one = {}
game.fighter.one.health = 100
game.fighter.one.accuracy = 0 -- max of 100 (unless!)
game.fighter.one.poise = 0 -- max of 100
game.fighter.one.resource = 0
game.fighter.one.preparing = false
game.fighter.one.attacking = false
game.fighter.one.text = ""

game.fighter.two = {}
game.fighter.two.health = 100
game.fighter.two.accuracy = 0 -- max of 100 (unless!)
game.fighter.two.poise = 0 -- max of 100
game.fighter.two.resource = 0
game.fighter.two.preparing = false
game.fighter.two.attacking = false
game.fighter.two.text = ""

game.state = {}
game.state.accuracygen = 0

function draw_fighters()
    if game.fighter.one.preparing then
        love.graphics.draw(game.sprite.testguy.prepare, 0, 0)
        game.fighter.one.accuracy = math.clamp(game.fighter.one.accuracy + 1, 0, 100)
    end
    if game.fighter.two.preparing then
        love.graphics.draw(game.sprite.testguytwo.prepare, 600, 0, 0, -1, 1)
        game.fighter.two.accuracy = math.clamp(game.fighter.two.accuracy + 1, 0, 100)
    end

    if game.fighter.one.attacking then
        if game.fighter.one.accuracy <= game.state.accuracygen then
            game.fighter.one.text = "Missed!"
            love.graphics.draw(game.sprite.testguy.attack, 0, 0)
            love.graphics.draw(game.sprite.testguytwo.idle, 600, 0, 0, -1, 1)
            game.fighter.one.accuracy = 0
            game.fighter.two.accuracy = 0
        else
            game.fighter.one.text = "Hit!"
            love.graphics.draw(game.sprite.testguy.attack, 0, 0)
            love.graphics.draw(game.sprite.testguytwo.hurt, 600, 0, 0, -1, 1)
            game.fighter.one.accuracy = 0
            game.fighter.two.accuracy = 0
        end
    elseif game.fighter.two.attacking then
        if game.fighter.two.accuracy <= game.state.accuracygen then
            game.fighter.two.text = "Missed!"
            love.graphics.draw(game.sprite.testguytwo.attack, 600, 0, 0, -1, 1)
            love.graphics.draw(game.sprite.testguy.idle, 0, 0)
            game.fighter.one.accuracy = 0
            game.fighter.two.accuracy = 0
        else
            game.fighter.two.text = "Hit!"
            love.graphics.draw(game.sprite.testguytwo.attack, 600, 0, 0, -1, 1)
            love.graphics.draw(game.sprite.testguy.hurt, 0, 0)
            game.fighter.one.accuracy = 0
            game.fighter.two.accuracy = 0
        end
    else
        love.graphics.draw(game.sprite.testguy.idle, 0, 0)
        love.graphics.draw(game.sprite.testguytwo.idle, 600, 0, 0, -1, 1)
        game.fighter.one.text = ""
        game.fighter.two.text = ""
        game.state.accuracygen = math.random(0,100)
    end
end