game = {}

game.window = {
    width = 640,
    height = 360,
    ratio = 2.0,
    x_offset = 0,
    y_offset = 0,
}



game.fonts = {}

function init_fonts()
    local font_file = "TerminusTTFWindows-4.49.3"
    local smallfont_file = "QuinqueFive"

    game.fonts.main = love.graphics.newFont("fonts/%s.ttf" % font_file, 12)
    game.fonts.small = love.graphics.newFont("fonts/%s.ttf" % smallfont_file, 5)
end



game.sound = {}

function init_sound()
    game.sound.miss = love.audio.newSource("sound/miss.wav", "static")
    game.sound.blow = love.audio.newSource("sound/blow.wav", "static")
    game.sound.blow_blocked = love.audio.newSource("sound/blow_blocked.wav", "static")
    game.sound.star_generation = love.audio.newSource("sound/star_generation.wav", "static")
    game.sound.ui_nope = love.audio.newSource("sound/ui_nope.wav", "static")
end



game.sprite = {}

function init_graphics()
    game.sprite.testguy = {}
    game.sprite.testguy.attack = love.graphics.newImage("gfx/testguy-attack.png")
    game.sprite.testguy.hurt =   love.graphics.newImage("gfx/testguy-hurt.png")
    game.sprite.testguy.idle =   love.graphics.newImage("gfx/testguy-idle.png")
    game.sprite.testguy.prepare =   love.graphics.newImage("gfx/testguy-prepare.png")
    game.sprite.testguy.block =   love.graphics.newImage("gfx/testguy-block.png")

    game.sprite.testguytwo = {}
    game.sprite.testguytwo.attack = love.graphics.newImage("gfx/testguy-attack.png")
    game.sprite.testguytwo.hurt =   love.graphics.newImage("gfx/testguy-hurt.png")
    game.sprite.testguytwo.idle =   love.graphics.newImage("gfx/testguy-idle.png")
    game.sprite.testguytwo.prepare =   love.graphics.newImage("gfx/testguy-prepare.png")
    game.sprite.testguytwo.block =   love.graphics.newImage("gfx/testguy-block.png")


    game.sprite.background = love.graphics.newImage("gfx/bg-testforest.png")
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

    init_fonts()
    init_sound()
    -- init_music()
    init_shader()
    init_graphics()

    game.canvas = love.graphics.newCanvas()
end