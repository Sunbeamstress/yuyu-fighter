game.character = {}



-- TEST GUY
-- Drawn in about 5 seconds by Nieve in Aseprite, Test Guy is an unpredictable
-- fighter who can do everything and also nothing!
game.character.testguy = {}
game.character.testguy.name = "Test Guy"
game.character.testguy.desc = "Tetsujiiiin!"
game.character.testguy.max_hp = 100
game.character.testguy.speed = 1.0
game.character.testguy.victory_lines = {
    "You must defeat Shen Long to stand a chance!",
    "Go home and be a family man!",
    "aww man bro are u ok i didnt mean to hit u that hard fuck"
}



-- THE PILOT
-- The main character of IDOL. A lightning-fast rushdown who is most comfortable
-- getting up close and personal. Can create pressure at range with her gun
-- Cherry Girl, which deals fast chip damage without causing stun.
game.character.pilot = {}
game.character.pilot.name = "The Pilot"
game.character.pilot.desc = "The violent scion of the new world."
game.character.pilot.max_hp = 90
game.character.pilot.speed = 1.2
game.character.pilot.victory_lines = {
    "We can rebuild the world without you.",
    "I must have imagined them...",
    "Another notch for Cherry Girl.",
    "Not gonna lie. I enjoyed doing that.",
}



-- STINTZ
-- who invited this guy?
-- Stintz, aka Maxwell Bogus, aka Moto Sickness, aka Hugo Disgusting, seems to
-- show up wherever he's most unwelcome. Ever had a guy try to sell you drugs in
-- space? You probably just met Stintz.
game.character.stintz = {}
game.character.stintz.name = "Stintz"
game.character.stintz.desc = "Hey, kid."
game.character.stintz.max_hp = 100
game.character.stintz.speed = 1
game.character.stintz.victory_lines = {
    "Sorry, kid... y'know what they say. Every dog shines on Orion.",
    "I ain't been in a scrap like that since the Great Cave War of 14800 BC. Nice."
}
local stintz_names = {
    "Virgo Brainsick",
    "Maxwell Bogus",
    "Hugo Disgusting",
    "Moto Sickness",
}
game.character.stintz.generate_name = function ()
    game.character.stintz.name = stintz_names[math.random(#stintz_names)]
end