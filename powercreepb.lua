--- STEAMODDED HEADER
--- MOD_NAME: powercreep
--- MOD_ID: powercreep
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
SMODS.Joker{
    key = 'powercreepb',
    loc_txt = {
        name = 'Power Crept',
        text = {
            "{X:mult,C:white} X#1# {} Mult", "Beating a {C:attention}Boss Blind{} by triple", "the required chips creates", "a {C:blue}Negative{} copy of Power Creep"
        }
    },
    atlas = 'powercreepb', --atlas' key
    rarity = 3, 
    cost = 12, 
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
    loc_vars = function(self,info_queue,center)
        return {vars = {center.ability.extra.Xmult}}
    end,
    calculate = function(self, card, context)
        if context.joker_main then
            return {
                Xmult =1.5
            }
        end

        if G.GAME.blind.boss and (G.GAME.chips / G.GAME.blind.chips >= 3) and not card_created then --have to set this to the 3x boss blind condition
            card_created = true
            local success, new_card = pcall(create_card, 'powercreepb', G.jokers, nil, nil, nil, nil, 'j_powb_powercreepb')
            if not success or not new_card then
                if not success then
                end
                card_created = false -- Reset the flag if card creation fails
                return
            end
            
            new_card:set_edition({ negative = true }, true)
            new_card:add_to_deck()
            G.jokers:emplace(new_card)
        end
        -- Reset the flag when the condition is no longer met
        if not context.setting_blind then
            card_created = false
        end
    end,
    in_pool = function(self,wawa,wawa2)
        return true
    end,
}
