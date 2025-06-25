-- this file is an example of what is generally in a main lua file 

-- the SMODS functions such as SMODS.Joker are also case sensitive, so if you use SMODS.joker instead of SMODS.Joker the joker you coded will not appear in the game, the same goes for any other SMODS method

if not ModofTheseus then -- this is used to make sure that the mod is not loaded multiple times, and it is used to make sure that the mod is not loaded in a different order than it should be
    ModofTheseus = {}
end

ModofTheseus = {
    show_options_button = true,
}

ModofTheseus = SMODS.current_mod
ModofTheseus_config = ModofTheseus.config -- this is the config file that is used to store the mods settings, and it is used to make sure that the mods config is loaded correctly
ModofTheseus.enabled = copy_table(ModofTheseus_config) -- this is the current state of the mods settings, and it is used to make sure that the mods config settings are saved

-- to make your config actually register and work you will need to add the lines 3, 4, and 5 to your mod, and you can replace the ExampleMod with your mods name

-- When making a Sprite For Balatro you need to have a 1x and a 2x file, because the 1x is used for no pixel art smothing, and 2x is used for pixel art smothing
SMODS.Atlas({
    object_type = "Atlas",
    key = "PLH", -- this is what you put in your atlas in your joker, consumable, or any other modded item, an example of this can be found in Items/Jokers.lua on line 8
    path = "placeholders.png",-- this is the name of the file that your sprites will use from your assets folder
    px = 71,
    py = 95,-- the standard 1x size of any joker or consumable is 71x95
})
SMODS.Atlas({
    key = "tarot",
    path = "Tarots.png",
    px = 71,
    py = 95,
})

SMODS.Atlas({
    key = "CommonJ",
    path = "CommonJokers.png",
    px = 71,
    py = 95
})


SMODS.Atlas({
    key = "UncommonJ",
    path = "UncommonJokers.png",
    px = 71,
    py = 95
})

SMODS.Atlas({
    key = "RareJ",
    path = "RareJokers.png",
    px = 71,
    py = 95
})

SMODS.Atlas({
    key = "LegendJ",
    path = "LegendaryJokers.png",
    px = 71,
    py = 95,
})

SMODS.Atlas({
    key = "OmegaJ",
    path = "OmegaJokers.png",
    px = 71,
    py = 95,
})

SMODS.Rarity({
    key = "superb",
    pools = {["Joker"] = true},
    default_weight = 0.01,
    badge_colour = HEX('ffb0b5'),
})

SMODS.Rarity({
    key = "omega",
    pools = {["Joker"] = true},
    default_weight = 0,
    badge_colour = HEX('000000'),
})
-- do note that the key and path of an atlas is case sensitive, so make sure you are using the correct capitalization


-- this is where we will register other files from within this mods folder such as stuff from our Items folder, tho if you don't want to load that file you can comment it out by adding "--" aty the start of the line
-- when setting the files path you need to make sure that you are using the correct capitalization, because if you don't, your mod will crash on linux platforms
assert(SMODS.load_file("Items/LegendaryJokers.lua"))()
assert(SMODS.load_file("Items/RareJokers.lua"))()
assert(SMODS.load_file("Items/UncommonJokers.lua"))()
assert(SMODS.load_file("Items/CommonJokers.lua"))()
assert(SMODS.load_file("Items/OmegaJokers.lua"))()
assert(SMODS.load_file("Items/Consumables.lua"))() -- this is where you will find how you can make a custom consumable type or just create a consumable of a pre-existing type
assert(SMODS.load_file("Items/Editions.lua"))() -- this is where you will find how to make a custom edition type or just create a edition of a pre-existing type
assert(SMODS.load_file("Items/Misc.lua"))()
assert(SMODS.load_file("Items/Enhancements.lua"))() -- this is where you will find how to make a custom enhancement type or just create a enhancement of a pre-existing type
assert(SMODS.load_file("Items/Challenges.lua"))() 
assert(SMODS.load_file("Lib/Utility.lua"))() -- this is the file where we add the code to initialize the config menu and other utility functions