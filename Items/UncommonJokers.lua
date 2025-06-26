SMODS.Joker {
  key = "censoredJokerJ",
  pos = { x = 0, y = 0 },
  rarity = 2,
  atlas = "UncommonJ",
  config = { extra = { X_mult = 1, mult_modSell = .01, mult_modRoll = .05 } },
  cost = 8,
  blueprint_compat = true,
  loc_vars = function(self, info_queue, card)
    return { vars = { card.ability.extra.X_mult, card.ability.extra.mult_modSell, card.ability.extra.mult_modRoll } }
  end,
  calculate = function(self, card, context)
    if context.reroll_shop then
      card.ability.extra.X_mult = card.ability.extra.X_mult + card.ability.extra.mult_modRoll
      return {
        message = localize 'k_upgrade_ex',
        colour = G.C.MULT,
        message_card = card
      }
    end
    if context.selling_card then
      card.ability.extra.X_mult = card.ability.extra.X_mult + card.ability.extra.mult_modSell
      return {
        message = localize 'k_upgrade_ex',
        colour = G.C.MULT,
        message_card = card
      }
    end
    if context.joker_main then
      return { xmult = card.ability.extra.X_mult }
    end
  end
}

SMODS.Joker({
  key = "reinforcedGlassJ",
  pos = { x = 0, y = 0 },
  rarity = 2,
  -- TODO: add to a proper atlas file
  -- TODO: VVVVVVVVVVVVVVVVVVVVVVVVVV
  atlas = "ReinforcedGlassJoker",
  cost = 4,
  blueprint_compat = false,
  unlocked = true
})
