
-- Modify to display badges for credits and some gameset badges
local SMODS_create_mod_badges = SMODS.create_mod_badges
---@diagnostic disable-next-line: duplicate-set-field
function SMODS.create_mod_badges(card, badges)
	SMODS_create_mod_badges(card, badges)

    -- Cryptid.safe_get(G, "ACTIVE_MOD_UI", "id") == id
    local id = card and card.mod and card.mod.id
    -- if G and G.ACTIVE_MOD_UI and G.ACTIVE_MOD_UI.id == id then
    if not id == "Mod_of_Theseus" then return end
	if not card.mot_credits then return end


	local dynatext = nil

	if type(card.mot_credits) == "table" then
		local credits = {}
		for category, credit_table in pairs(card.mot_credits) do
			for _, name in ipairs(credit_table) do
				table.insert(credits, titlecase(category) .. ": " .. name)
			end
		end
		-- shuffle credits
		-- table.shuffle(credits)

		-- shuffle credits so the same name doesn't always get the spotlight before any other
		for i = #credits, 2, -1 do
			local j = math.random(i) -- doesn't need to be affected by the seed so we use the built-in random function
			credits[i], credits[j] = credits[j], credits[i]
		end
		table.insert(credits, 1, "Theseus")

		dynatext = DynaText({
			-- string = {"dynatext", "second text"},
			string = credits,
			-- colours = {G.C.RED, G.C.GREEN, G.C.BLUE},
			colours = {HEX("97572b")},
			-- colours = {HEX("97572b"), HEX("c57138")},
			silent = true,
			-- colours = {G.C.WHITE},
			-- shadow = true,
			-- rotate = true,
			-- bump = true,
			-- spacing =1,
			-- scale = 0.7,
			scale = 0.33 * 0.9,
			float = true,
			shadow = true,
			offset_y = -0.05,
			-- maxw = 4,
			-- pop_in = 0.5
		})

		
	elseif type(card.mot_credits) == "function" then
		dynatext = card.mot_credits()
	end


	local badge = create_dynatext_badge(dynatext, HEX("321d0e"))

	local function check_colors_equal(x, y)
		for i = 1, 4 do
			if x[i] ~= y[i] then
				return false
			end
		end
		return true
	end
	for i = 1, #badges do
		if check_colors_equal(badges[i].nodes[1].config.colour, HEX("321d0e")) then
			badges[i].nodes[1].nodes[2].config.object:remove()
			badges[i] = badge
			break
		end
	end

end

