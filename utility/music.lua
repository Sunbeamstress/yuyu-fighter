game.music.playing = false
game.music.current_track = ""
game.music.track_length = 0
game.music.last_play = 0
game.music.loop_at = -1



function stop_music()
    game.music.playing = false
    game.music.current_track = ""
    game.music.track_length = 0
    game.music.loop_at = -1
end



function play_music(track)
    -- play_music() by itself just stops the track.
    if not track then
        stop_music()
        return
    end

    -- passing an invalid track to play_music()) does nothing
    if not game.music[track] then
        return
    end

    -- if the track passed is the one playing, we also do nothing
    if game.music.current_track == track then
        return
    end

    game.music.current_track = track
    game.music.playing = true
    game.music.track_length = game.music[track].length
    game.music.last_play = 0
    game.music.loop_at = game.music[track].length

    love.audio.play(game.music[game.music.current_track].source)
end



function loop_music(dt)
    if not game.music.playing then
        return
    end

    last_music_check = last_music_check or 0

    if last_music_check >= game.music.loop_at then
        -- Enough time has passed - play this song again!
        love.audio.play(game.music[game.music.current_track].source)
        game.music.loop_at = last_music_check + game.music.track_length
    end

    last_music_check = last_music_check + dt
end