--[[
 * CommonJokers.lua
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
  key = "rekojJ",
  pos = { x = 0, y = 0 },
  rarity = 1,
  atlas = "CommonJ",
  config = { extra = { chips = 4 } },
  cost = 1,
  blueprint_compat = true,
  loc_vars = function(self, info_queue, card)
    return { vars = { card.ability.extra.chips } }
  end,
  calculate = function(self, card, context)
    if context.joker_main then
      return { chips = card.ability.extra.chips }
    end
  end,

  joker_display_def = function(JokerDisplay)
    ---@type JDJokerDefinition
    return {
      text = {
        { text = "+" },
        { ref_table = "card.ability.extra", ref_value = "chips", retrigger_type = "mult" },
      },
      text_config = { colour = G.C.CHIPS }
    }
  end

}


SMODS.Joker {
  key = "saladNumberJ",
  pos = { x = 0, y = 0 },
  rarity = 1,
  atlas = "PLH",
  config = { extra = { chips = 1 } },
  cost = 1,
  blueprint_compat = true,
  loc_vars = function(self, info_queue, card)
    return { vars = { card.ability.extra.chips } }
  end,
  calculate = function(self, card, context)
    if context.joker_main then
      return { chips = card.ability.extra.chips }
    end
  end,

  joker_display_def = function(JokerDisplay)
    ---@type JDJokerDefinition
    return {
      text = {
        { text = "+" },
        { ref_table = "card.ability.extra", ref_value = "chips", retrigger_type = "mult" },
      },
      text_config = { colour = G.C.CHIPS }
    }
  end


SMODS.Joker {
  key = "hashtagQookingJ",
  atlas = "PLH",
  rarity = 1,
  pos = { x = 0, y = 0 },
  config = { extra = { chips = 25, dumb_fucking_workaround = "#" } },
  cost = 4,
  pools = {
    ["Q"] = true,
    ["Food"] = true
  },
  blueprint_compat = true,
  loc_vars = function(self, info_queue, card)
    local food_jokers = 0

    for i = 1, (G.jokers and #G.jokers.cards or 0) do
      if G.jokers.cards[i]:is_food() then
        food_jokers = food_jokers + 1
      end
    end

    return { vars = { card.ability.extra.dumb_fucking_workaround, card.ability.extra.chips, card.ability.extra.chips * (food_jokers or 0) } }
  end,

  calculate = function(self, card, context)
    if context.joker_main then
      local food_jokers = 0

      for i = 1, (G.jokers and #G.jokers.cards or 0) do
        if G.jokers.cards[i]:is_food() then
          food_jokers = food_jokers + 1
        end
      end

      return {
        chips = card.ability.extra.chips * (food_jokers or 0)
      }
    end
  end,

  -- todo: add joker display compatibility @chore
}
