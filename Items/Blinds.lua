SMODS.Blind {
    key = 'angel',
    loc_txt = {
        name = "The Angel",
        text = {
            "Cards are debuffed",
            "until play",
        },
    },
    atlas = 'test_blinds',
    pos = {y = 2},
    discovered = true,
    boss = {min = 1},
    boss_colour = HEX('bbbbbb'),
    recalc_debuff = function(self, card, from_blind)
        return card.area == G.deck and not G.GAME.blind.disabled
    end,
    modify_hand = function(self, cards, poker_hands, text, mult, hand_chips)
        for k, v in ipairs(cards) do
            v:set_debuff(false)
        end
        return mult, hand_chips, false
    end,
}

SMODS.Blind {
    key = "demon",
    loc_txt = {
        name = "The Demon",
        text = {
            "Played cards have a",
            "1 in 2 chance to",
            "become debuffed",
        },
    },
    atlas = "test_blinds",
    pos = {y = 5},
    discovered = true,
    boss = {min = 3},
    boss_colour = HEX("ff553e"),
    modify_hand = function(self, cards, poker_hands, text, mult, hand_chips)
        for k, v in ipairs(cards) do
            if not G.GAME.blind.disabled and (pseudorandom(pseudoseed("demon")) < (G.GAME.probabilities.normal / 2)) then
                v:set_debuff(true)
            end
        end
        return mult, hand_chips, false
    end,
}

SMODS.Blind {
    key = "lapis_loupe",
    loc_txt = {
        name = "Lapis Loupe",
        text = {
            "Play only your best",
            "possible hand",
        },
    },
    atlas_table = "test_blinds_finisher",
    pos = {y = 2},
    discovered = true,
    mult = 5,
    boss = {showdown = true},
    boss_colour = HEX("0000FF"),
    set_blind = function(self)
        self.hands_sub = G.GAME.round_resets.hands - 1
        ease_hands_played(-self.hands_sub)
        ease_discard(#G.deck.cards-1)
    end,
    disable = function(self)
        ease_hands_played(self.hands_sub)
    end,
    press_play = function(self)
        ease_discard(-G.GAME.current_round.discards_left)
    end
}