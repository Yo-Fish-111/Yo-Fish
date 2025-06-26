SMODS.Joker {
  key = "winningbigJ",
  atlas = "RareJ",
  rarity = 3,
  pos = { x = 0, y = 0 },
  config = { extra = { dollars = 1, money_mod = 1 } },
  cost = 10,
  blueprint_compat = false,
  loc_vars = function(self, info_queue, card)
    return { vars = { card.ability.extra.dollars, card.ability.extra.money_mod } }
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

SMODS.Joker({
  key = "medusaJ",
  -- TODO: add to a proper atlas file
  -- TODO: VVVVVVVVVVVVVVVVVVVVVVVVVV
  atlas = "MedusaJ",
  pos = { x = 0, y = 0 },
  rarity = 3,
  cost = 8,
  config = {
    extra = {
      mult = 100, x_mult = 2,
    }
  },
  loc_vars = function(_self, _info_queue, card)
    return {
      vars = {
        mult = card.ability.extra.mult,
        x_mult = card.ability.extra.x_mult,
      }
    }
  end,
  blueprint_compat = true,
  calculate = function(_self, card, context)
    if context.before and context.main_eval and not context.blueprint and context.scoring_hand then
      -- local faces = 0

      for _, scored_card in ipairs(context.scoring_hand) do
        if scored_card:is_face() then
          -- faces = faces + 1
          scored_card:set_ability("m_stone", nil, true)
          G.E_MANAGER:add_event(Event({
            func = function()
              scored_card:juice_up()
              return true
            end
          }))
        end
      end

      -- if faces > 0 then
      --   return {
      --     message = localize('k_plus_stone'),
      --     colour = G.C.GREY
      --   }
      -- end
    end




    if context.joker_main then
      local stone_tally = 0

      for _, scored_card in ipairs(context.scoring_hand) do
        if SMODS.has_enhancement(scored_card, "m_stone") then
          stone_tally = stone_tally + 1
        end
      end

      if stone_tally == #context.scoring_hand then
        return {
          mult = card.ability.extra.mult,
          x_mult = card.ability.extra.x_mult
        }
      end
    end
  end
})
