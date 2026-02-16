game.fighter = {}

game.fighter.one = {}
game.fighter.one.health = 100
game.fighter.one.accuracy = 0 -- max of 100 (unless!)
game.fighter.one.poise = 0 -- max of 100
game.fighter.one.resource = 0
game.fighter.one.attacking = false

game.fighter.two = {}
game.fighter.two.health = 100
game.fighter.two.accuracy = 0 -- max of 100 (unless!)
game.fighter.two.poise = 0 -- max of 100
game.fighter.two.resource = 0


function draw_fighters()
    -- we draw the fighters to the screen here!
    if game.fighter.one.attacking then
        love.graphics.draw(game.sprite.testguy.attack, 0, 0)
        love.graphics.draw(game.sprite.testguytwo.hurt, 600, 0, 0, -1, 1)
    elseif game.fighter.two.attacking then
        love.graphics.draw(game.sprite.testguytwo.attack, 600, 0, 0, -1, 1)
        love.graphics.draw(game.sprite.testguy.hurt, 0, 0)
    else
        love.graphics.draw(game.sprite.testguy.idle, 0, 0)
        love.graphics.draw(game.sprite.testguytwo.idle, 600, 0, 0, -1, 1)
    end
end