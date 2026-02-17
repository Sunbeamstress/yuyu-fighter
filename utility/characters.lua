game.character = {}



-- TEST GUY
-- Drawn in about 5 seconds by Nieve in Aseprite, Test Guy is an unpredictable
-- fighter who can do everything and also nothing!
game.character.testguy = {}
game.character.testguy.name = "Test Guy"
game.character.testguy.desc = "Tetsujiiiin!"
game.character.testguy.max_hp = 100
game.character.testguy.speed = 1.0
game.character.testguy.victory_lines_decisive = {
    "OMOE WA MOU SHINDEIRU",
    "rekt",
    "Thank you for coming to my Ted Beating.",
    "YOU WILL NEVER KNOW PEACE"
}
game.character.testguy.victory_lines_even = {
    "You must defeat Shen Long to stand a chance!",
    "Go home and be a family man!",
    "aww man bro are u ok i didnt mean to hit u that hard fuck",
    "I CAN DO ANYTHING"
}
game.character.testguy.victory_lines_clutch = {
    "!@#$ YOU",
    "oh no oh no oh no oh- hahahaha Bidge",
    "That's what we call a blood test!",
    "Good heavens, I appear to have finished that bout on low health."
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
game.character.pilot.victory_lines_decisive = {
    "i am not putting words in your gal's mouth",
    "",
    "",
    "",
}
game.character.pilot.victory_lines_even = {
    "We can rebuild the world without you.",
    "I must have imagined them...",
    "Another notch for Cherry Girl.",
    "Not gonna lie. I enjoyed doing that.",
}
game.character.pilot.victory_lines_clutch = {
    "hi love you deer doe please fill these out <3 <3 <3",
    "",
    "",
    "",
}

-- ANISE DIGATEAUX
-- Moth gal, witch, baker, alchemist, mom, she does it all!
-- Her potions are too strong for you.
game.character.anise = {}
game.character.anise.name = "Anise"
game.character.anise.desc = "Prodigal Alchemist and Witch"
game.character.anise.max_hp = 125
game.character.anise.speed = 0.8
game.character.anise.victory_lines_decisive = {
    "Wait, yer done already? I didn'ae even mix the good stuff yet...",
    "Won't tell anyone if you won't.",
    "Wouln'ae be too gauche if I yelled GET DUNKED ON, would it?",
    "...yeesh. Were ye even tryin'?"
}
game.character.anise.victory_lines_even = {
    "The power o' alchemy at work! That and me POWERFUL THIGHS.",
    "Didn't think I had it in me, did ye?",
    "That gives me an idea for a new brew...",
    "Ah, don't feel too bad. Drinks are on me!"
}
game.character.anise.victory_lines_clutch = {
    "...gonna feel that'n in the morning.",
    "Ach, my hair is ruined...",
    "Definitely gettin' too old for this.",
    "Ye had me worried fer a minute! ...well, several minutes."
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
game.character.stintz.victory_lines_decisive = {
    "You get mondo delirious with me again, I'll give you the ol' Detroit Overcoat!",
    "That's just how it is on this elephant's foot of an business district, kid.",
    "",
    ""
}
game.character.stintz.victory_lines_even = {
    "Sorry, kid... y'know what they say. Every dog shines on Orion.",
    "I ain't been in a scrap like that since the Great Cave War of 14800 BC. Nice.",
    "Back in the Business Tubes of Neo Baghdad, they called me the Babylon Screwdriver.",
    "Ain't nobody showed you the nick-nacks, kid... that's why your canary butt just got glitzed."
}
game.character.stintz.victory_lines_clutch = {
    "Jeez kid, calm your stickers. Ain't no need for a full frontal rushdown.",
    "Well ain't that a continential breakfast on Mercury...",
    "",
    ""
}
local stintz_names = {
    "Stintz", "Virgo Brainsick", "Maxwell Bogus", "Hugo Disgusting",
    "Moto Sickness", "Calvin Decline", "Big Government", "Gordon Bennett",
    "Nucc Fugget", "This !@#$ing Guy", "Jeff", "Sewage Fandango",
    "Low Clearance", "The Real Folk Schmooze", "Adrien Grody", "Hoe Malone",
    "Cyrus the Virus", "STRING FORMAT ERROR"
}
game.character.stintz.generate_name = function ()
    game.character.stintz.name = stintz_names[math.random(#stintz_names)]
end