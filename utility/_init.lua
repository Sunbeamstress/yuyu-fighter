game = {}

game.window = {
    width = 640,
    height = 360,
    ratio = 2.0,
    x_offset = 0,
    y_offset = 0,
}



game.sprite = {}



function init_graphics()
    game.sprite.testguy = {}
    game.sprite.testguy.attack = love.graphics.newImage("gfx/testguy-attack.png")
    game.sprite.testguy.hurt =   love.graphics.newImage("gfx/testguy-hurt.png")
    game.sprite.testguy.idle =   love.graphics.newImage("gfx/testguy-idle.png")
end



function love.load()
    love.graphics.setDefaultFilter("nearest", "nearest")
    love.window.setMode(
        game.window.width * 2, game.window.height * 2,
        {
            resizable = true,
            minwidth = 640,
            minheight = 360
        }
    )

    -- init_sound()
    -- init_music()
    -- init_shader()
    init_graphics()

    game.canvas = love.graphics.newCanvas()
end