--[[
 * SuperbJokers.lua
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

SMODS.Joker{
  key = "reinforcedGlassJ",
  pos = { x = 0, y = 0 },
  rarity = "mot_superb",
  atlas = "SuperbJ",
  cost = 10,
  blueprint_compat = false,
  unlocked = true,
  mot_credits = {
    idea = {
      "Jinx",
    },
    art = {
      "Aduckted",
    },
    code = {
      "Jinx",
      "Mothball",
    },
  },
}

SMODS.Joker{ -- Cult Contract
  key = "cultContractJ",
  atlas = "SuperbJ",
  rarity = "mot_superb",
  pos = { x = 1, y = 0 },
  config = { extra = { repetitions = 2, suit = "Hearts" }, immutable = { max_repetitions = 25 } },
  cost = 8,
  blueprint_compat = true,

  mot_credits = {
    idea = {
      "Cooked Fish",
    },
    art = {
      "Cooked Fish",
    },
    code = {
      "Jinx",
    },
},

  loc_vars = function(self, info_queue, card)
    local suit = card.ability.extra.suit or "Hearts"
    return {
      vars = {
        math.min(card.ability.immutable.max_repetitions,
          card.ability.extra.repetitions),
        localize(suit, 'suits_singular'),
        colours = { G.C.SUITS[suit] },
      }
    }
  end,

  calculate = function(self, card, context)
    if context.repetition and context.cardarea == G.play and context.other_card:is_suit(card.ability.extra.suit) then
      return {
        repetitions = math.min(card.ability.immutable.max_repetitions,
          card.ability.extra.repetitions)
      }
    end

    if context.repetition and context.cardarea == G.hand and context.other_card:is_suit(card.ability.extra.suit) then
      return {
        repetitions = math.min(card.ability.immutable.max_repetitions, card.ability.extra.repetitions)
      }
    end
  end,

  update = function(self, card, dt)
    if G.hand and card.added_to_deck then
      for i, v in ipairs(G.hand.cards) do
        if not v:is_suit("Hearts") then
          v:set_debuff(true)
        end
      end
    end
  end
}

local function procrastination_xmult()
  -- Count days since June 23, 2025
  local target = os.time({year = 2025, month = 6, day = 23, hour = 0, min = 0, sec = 0})
  local now = os.time()
  local days_elapsed = math.floor((now - target) / 86400)

  -- Count jokers added by Mod of Theseus
  local mot_joker_count = 0
  for k, v in pairs(SMODS.Jokers) do
    if k:find("^j_") and v.mod and v.mod.id == "Mod_of_Theseus" then
      mot_joker_count = mot_joker_count + 1
    end
  end
  if mot_joker_count == 0 then mot_joker_count = 1 end

  return math.floor((days_elapsed / mot_joker_count) * 100) / 100
end

SMODS.Joker{ -- Procrastination
  key = "procrastinationJ",
  atlas = "PLH",
  rarity = "mot_superb",
  pos = { x = 0, y = 0 },
  cost = 25,
  blueprint_compat = true,
  mot_credits = {
    idea = {
      "Hoarfrost Trickle",
    },
    art = {
      --"None",
    },
    code = {
      "Hoarfrost Trickle",
    },
  },

  loc_vars = function(self, info_queue, card)
    return { vars = { procrastination_xmult() } }
  end,

  calculate = function(self, card, context)
    if context.joker_main then
      return { xmult = procrastination_xmult() }
    end
  end,

  joker_display_def = function(JokerDisplay)
    ---@type JDJokerDefinition
    return {
      text = {
        {
          border_nodes = {
            { text = "X" },
            { ref_table = "card.joker_display_values", ref_value = "xmult", retrigger_type = "exp" },
          }
        }
      },
      calc_function = function(card)
        card.joker_display_values.xmult = procrastination_xmult()
      end
    }
  end
}


SMODS.Joker {
    key = "voidJ",
    blueprint_compat = true,
    rarity = "mot_superb",
    atlas = "PLH",
    cost = 11,
    pos = { x = 0, y = 0 },
    loc_vars = function(self, info_queue, card)
        return { vars = { G.jokers and G.jokers.config.card_limit - #G.jokers.cards } }
    end,
    calculate = function(self, card, context)
        local empty_joker_slots = G.jokers.config.card_limit - #G.jokers.cards
        local target_joker = G.jokers.cards[#G.jokers.cards]

        if context.retrigger_joker_check and (not context.retrigger_joker) and (context.other_card ~= self) then
            if context.other_card == target_joker then
                return {
                    message = localize("k_again_ex"),
                    repetitions = empty_joker_slots,
                    card = card,
                }
            else
                return nil, true
            end
        end
    end,
    joker_display_def = function(JokerDisplay)
        ---@type JDJokerDefinition
        return {
           reminder_text = {
               { text = "(" },
               { ref_table = "card.joker_display_values", ref_value = "localized_text", colour = G.C.ORANGE },
               { text = ")" }
           },
           calc_function = function(card)
               local target_joker = G.jokers.cards[#G.jokers.cards]

               local localized_text = localize({ type = "name_text",
               key = target_joker.config.center.key, set = "Joker" }) or "-"
               if card == target_joker then
                   localized_text = "-"
               end
               card.joker_display_values.localized_text = localized_text
           end,
           retrigger_joker_function = function(card, retrigger_joker)
               if card == retrigger_joker then return 0 end
               local empty_joker_slots = G.jokers.config.card_limit - #G.jokers.cards
               local target_joker = G.jokers.cards[#G.jokers.cards]
               if card == target_joker then return empty_joker_slots end
               return 0
           end
        }
    end,
}
