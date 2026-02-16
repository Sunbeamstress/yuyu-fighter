function draw_debug()
    set_color(1)
    love.graphics.print("Accuracy Gen: %s" % game.state.accuracygen, 200,108)
    reset_color()
end