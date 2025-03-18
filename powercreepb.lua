--- STEAMODDED HEADER
--- MOD_NAME: Power Creep Balanced
--- MOD_ID: powercreepb
--- MOD_AUTHOR: [dogwearingdurag]
--- MOD_DESCRIPTION: Slightly unbalanced mod
--- PREFIX: xmpl
----------------------------------------------
------------MOD CODE -------------------------

SMODS.Atlas{
    key = 'powercreepb', --atlas key
    path = 'Jokers.png', --atlas' path in (yourMod)/assets/1x or (yourMod)/assets/2x
    px = 71, --width of one card
    py = 95 -- height of one card
}
local event_added = false
SMODS.Joker{
    key = 'powercreepa',
    loc_txt = {
        name = 'Power Creep',
        text = {
            "{X:mult,C:white} X#1# {} Mult",
            "Beating a {C:attention}Boss Blind{} by triple",
            "the required chips creates",
            "a {C:blue}Negative{} Power Crept"
        }
    },
    atlas = 'powercreepb', -- atlas' key
    rarity = 3,
    cost = 10,
    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    pos = {x = 0, y = 0},
    config = {
        extra = {
            Xmult = 1.5
        }
    },
    loc_vars = function(self, info_queue, center)
        return {vars = {center.ability.extra.Xmult}}
    end,
    calculate = function(self, card, context)
        if context.joker_main then
            return {
                Xmult =1.5
            }
        end
        if context.setting_blind then
            event_added = false
        end
        local counter = #SMODS.find_card('j_powb_powercreepa')
        if not event_added and G.GAME.blind.boss and (G.GAME.chips / G.GAME.blind.chips >= 3) then
            for i = 1, counter do
                local new_card = create_card('powercrept', G.jokers, nil, nil, nil, nil, 'j_powb_powercrept')
                new_card:set_edition({ negative = true }, true)
                new_card:add_to_deck()
                G.jokers:emplace(new_card)
            end
            event_added = true -- Set the flag to true after adding the event
        end
    end,
    in_pool = function(self, wawa, wawa2)
        return true
    end,
}
SMODS.Joker{
    key = 'powercrept',
    loc_txt = {
        name = 'Power Crept',
        text = {
            "{X:mult,C:white} X#1# {} Mult"
        }
    },
    atlas = 'powercreepb', -- atlas' key
    rarity = 3,
    cost = 1,
    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    pos = {x = 1, y = 0},
    config = {
        extra = {
            Xmult = 1.5
        }
    },
    loc_vars = function(self, info_queue, center)
        return {vars = {center.ability.extra.Xmult}}
    end,
    calculate = function(self, card, context)
        if context.joker_main then
            return {
                Xmult =1.5
            }
        end
    end,
    in_pool = function(self, wawa, wawa2)
        return false
    end,
}
