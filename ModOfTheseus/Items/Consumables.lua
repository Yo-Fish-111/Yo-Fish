SMODS.Consumable({
    key = "whirlpool",
    set = "Spectral",
    atlas = "tarot",
    pos = {x = 5, y = 2},
    can_use = function(self, card)
        return #G.jokers.cards < G.jokers.config.card_limit
    end,
    use = function(self, card, area, copier)
        SMODS.add_card{
            set = "Joker",
            rarity = "mot_omega"
        }
    end
})