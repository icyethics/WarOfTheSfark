SMODS.Joker {
  key = "greengiant",
  pos = { x = 0, y = 0 },
  atlas = "war_jokers",
  rarity = 2,
  blueprint_compat = true,
  cost = 6,
  config = { extra = {
    loyalty = 0,
    uses = 1,
    mult_per = 1,
    roll_add = 0,
    roll_add_per = 1,
  }, },

  planeswalker = true,
  planeswalker_costs = { 3 },
  default_loyalty_effects = true,
  
  loc_vars = function(self, info_queue, card)
    info_queue[#info_queue+1] = { key = "planeswalker_explainer", set="Other", specific_vars = { 0 } }
    return { vars = { card.ability.extra.mult_per, card.ability.extra.mult_per * card.ability.extra.loyalty, card.ability.extra.roll_add_per, card.ability.extra.roll_add } }
  end,
  calculate = function(self, card, context)
    if context.joker_main and card.ability.extra.loyalty > 0 then
      return {
        mult = card.ability.extra.mult_per * card.ability.extra.loyalty
      }
    end
  end,
  
  can_loyalty = function(card, idx)
    if idx == 1 then
      return true
    else return false end
  end,
  loyalty = function(card, idx)
    if idx == 1 then
      G.GAME.round_resets.reroll_cost = G.GAME.round_resets.reroll_cost + card.ability.extra.roll_add_per
      -- this isn't scaling? since it's tracking the amount that was added
      card.ability.extra.roll_add = card.ability.extra.roll_add + card.ability.extra.roll_add_per
      G.GAME.current_round.reroll_cost = math.max(0,
          G.GAME.current_round.reroll_cost + card.ability.extra.roll_add_per)
        
      play_sound('multhit1', 0.7)
    end
  end,
  
  add_to_deck = function(self, card, from_debuff)
    -- in case we get copied
    G.GAME.round_resets.reroll_cost = G.GAME.round_resets.reroll_cost + card.ability.extra.roll_add
    G.GAME.current_round.reroll_cost = math.max(0,
        G.GAME.current_round.reroll_cost + card.ability.extra.roll_add)
  end,
  remove_from_deck = function(self, card, from_debuff)
    G.GAME.round_resets.reroll_cost = G.GAME.round_resets.reroll_cost - card.ability.extra.roll_add
    G.GAME.current_round.reroll_cost = math.max(0,
        G.GAME.current_round.reroll_cost - card.ability.extra.roll_add)
  end
}
