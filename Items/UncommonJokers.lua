--[[
 * UncommonJokers.lua
 * This file is part of Mod of Theseus
 *
 * Copyright (C) 2025 Mod of Theseus
 *
 * Mod of Theseus is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; either version 3 of the License, or
 * (at your option) any later version.
 *
 * Mod of Theseus is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with Mod of Theseus; if not, see <https://www.gnu.org/licenses/>.
]]
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
    if context.reroll_shop and not context.blueprint then
      card.ability.extra.X_mult = card.ability.extra.X_mult + card.ability.extra.mult_modRoll
      return {
        message = localize('k_upgrade_ex'),
        colour = G.C.MULT,
        message_card = card
      }
    end
    if context.selling_card and not context.blueprint then
      card.ability.extra.X_mult = card.ability.extra.X_mult + card.ability.extra.mult_modSell
      return {
        message = localize('k_upgrade_ex'),
        colour = G.C.MULT,
        message_card = card
      }
    end
    if context.joker_main then
      return { xmult = card.ability.extra.X_mult }
    end
  end,

  joker_display_def = function(JokerDisplay)
    ---@type JDJokerDefinition
    return {
      text = {
        {
          border_nodes = {
            { text = "X" },
            { ref_table = "card.ability.extra", ref_value = "X_mult", retrigger_type = "exp" },
          }
        }
      },
    }
  end

}

SMODS.Joker {
  key = "officeJobJ",
  pos = { x = 1, y = 0 },
  rarity = 2,
  atlas = "PLH",
  config = { extra = { dollars = 5, poker_hand = "Straight" } },
  cost = 6,
  blueprint_compat = true,
  loc_vars = function(self, info_queue, card)
    return { vars = { card.ability.extra.dollars } }
  end,
  calculate = function(self, card, context)
    if context.before
        and context.main_eval
        and context.scoring_name == card.ability.extra.poker_hand
        -- need to use the ModofTheseus version of get_highest for better typing
        -- i think :3
        and ModofTheseus.get_highest(context.scoring_hand):get_id() == 9
        and ModofTheseus.get_lowest(context.scoring_hand):get_id() == 5
    then
      G.GAME.dollar_buffer = (G.GAME.dollar_buffer or 0) + card.ability.extra.dollars
      -- print(ModofTheseus.get_highest(context.scoring_hand).base.id)
      -- print(ModofTheseus.get_lowest(context.scoring_hand).base.id)
      -- for _k, v in ipairs(context.scoring_hand) do
      --   print(v.base.id)
      -- end
      return {
        dollars = card.ability.extra.dollars,
        func = function() -- This is for timing purposes, it runs after the dollar manipulation
          G.E_MANAGER:add_event(Event({
            func = function()
              G.GAME.dollar_buffer = 0
              return true
            end
          }))
        end
      }
    end
  end,

  -- todo: add joker display compatibility @chore
}
