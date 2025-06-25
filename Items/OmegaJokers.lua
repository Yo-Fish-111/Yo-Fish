SMODS.Joker{
    key = "blobbyJ",
    pos = {x = 0, y = 0},
    soul_pos = {x = 1, y = 0},
    rarity = "mot_omega",
    atlas = "OmegaJ",
    config = {},
    cost = 50,
    blueprint_compat = true,
    loc_vars = function (self, info_queue, card)
        return {vars = {}}
    end,
    calculate = function (self, card, context)
        if context.individual and context.cardarea == G.hand and not context.end_of_round then
            if SMODS.has_enhancement(context.other_card, "m_steel") then
                return {emult = tonumber(string.format("%.2f", (math.random() + .5) + math.random(0, 2)))}
            end
        end
    end
}