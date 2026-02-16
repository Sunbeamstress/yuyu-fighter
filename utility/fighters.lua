game.fighterstate_idle = 0
game.fighterstate_preparing = 1
game.fighterstate_attacking = 2
game.fighterstate_hurt = 3

game.fighter = {}

game.fighter.one = {}
game.fighter.one.health = 100
game.fighter.one.accuracy = 0 -- max of 100 (unless!)
game.fighter.one.poise = 0 -- max of 100
game.fighter.one.resource = 0
game.fighter.one.text = ""
game.fighter.one.state = game.fighterstate_idle

game.fighter.two = {}
game.fighter.two.health = 100
game.fighter.two.accuracy = 0 -- max of 100 (unless!)
game.fighter.two.poise = 0 -- max of 100
game.fighter.two.resource = 0
game.fighter.two.text = ""
game.fighter.two.state = game.fighterstate_idle

function draw_fighters()
    if game.fighter.one.state == game.fighterstate_preparing then
        love.graphics.draw(game.sprite.testguy.prepare, 0, 0)
    elseif game.fighter.one.state == game.fighterstate_attacking then
            love.graphics.draw(game.sprite.testguy.attack, 0, 0)
    elseif game.fighter.one.state == game.fighterstate_hurt then
            love.graphics.draw(game.sprite.testguy.hurt, 0, 0)
    else
            love.graphics.draw(game.sprite.testguy.idle, 0, 0)
    end

    if game.fighter.two.state == game.fighterstate_preparing then
        love.graphics.draw(game.sprite.testguytwo.prepare, 600, 0, 0, -1, 1)
    elseif game.fighter.two.state == game.fighterstate_attacking then
            love.graphics.draw(game.sprite.testguytwo.attack, 600, 0, 0, -1, 1)
    elseif game.fighter.two.state == game.fighterstate_hurt then
            love.graphics.draw(game.sprite.testguytwo.hurt, 600, 0, 0, -1, 1)
    else
            love.graphics.draw(game.sprite.testguytwo.idle, 600, 0, 0, -1, 1)
    end
end