SMODS.Joker{
    key = "rekojJ",
    pos = {x = 0, y = 0},
    rarity = 1,
    atlas = "CommonJ",
    config = {extra = {chips = 4}},
    cost = 1,
    blueprint_compat = true,
    loc_vars = function(self, info_queue, card)
        return {vars = {card.ability.extra.chips}}
    end,
    calculate = function(self, card, context)
        if context.joker_main then
            return {chips = card.ability.extra.chips}
        end
    end
}