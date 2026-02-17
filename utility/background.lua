game.background = {
}

function draw_stage_bg()
    local bgsprite = game.sprite.background
    love.graphics.draw(bgsprite, 0, 0, 0, 1, 1)
end