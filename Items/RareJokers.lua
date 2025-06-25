SMODS.Joker{
    key = "winningbigJ",
    atlas = "RareJ",
    rarity = 3,
    pos = {x = 0, y = 0},
    config = {extra = {dollars = 1, money_mod = 1}},
    cost = 10,
    blueprint_compat = false,
    loc_vars = function(self, info_queue, card)
        return {vars = {card.ability.extra.dollars, card.ability.extra.money_mod}}
    end,
    
    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play and context.other_card.lucky_trigger and not context.blueprint then
            card.ability.extra.dollars = card.ability.extra.dollars + card.ability.extra.money_mod
            return {
                messsage = localize('k_upgrade_ex'),
                colour = G.C.MONEY
            }
        end
    end,

    calc_dollar_bonus = function(self, card)
        return card.ability.extra.dollars
    end
}