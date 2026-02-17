game.background = {
    x = 0,                     -- fighter's base location on the x-axis. this never changes!
    y = 0,                     -- fighter's base location on the y-axis. this never changes!
    width = 303,               -- width of the fighter's sprite in px.
    height = 317,              -- height of the fighter's sprite in px.
    x_mod = 0,                 -- used by hurt states, impacts, etc. to determine shake value for the sprite
    y_mod = 0,                 -- used by hurt states, impacts, etc. to determine shake value for the sprite
    x_drift = 0,               -- how far the sprite has "wandered" in pixels on the x-axis
    y_drift = 0,               -- how far the sprite has "wandered" in pixels on the y-axis
    x_drift_dir = 1,           -- 1 for right, -1 for left
    y_drift_dir = 0,           -- 1 for up, -1 for down
    drift_rate = 1,            -- how often does this character shift direction when drifting?
}

function draw_stage_bg()
    local bgsprite = game.sprite.background
    local x, y = game.background.x, game.background.y
    local w, h = game.background.width, game.background.height
    local xmod, ymod = game.background.x_mod, game.background.y_mod
    local xdrift, ydrift = game.background.x_drift, game.background.y_drift

    love.graphics.draw(bgsprite, 0, 0, 0, 1, 1)
end