BDC = SMODS.current_mod

BDC.warning_colour = SMODS.Gradients.warning_text

function BDC.should_apply_warning(cardarea)
	sendDebugMessage(G.GAME.selected_back.name)
	if not G.GAME.selected_back then
		return false
	end
	return cardarea == G.jokers
		and cardarea.config.card_count == cardarea.config.card_limit - 1
		and G.GAME.selected_back.name == "Black Deck"
end

local event
local cached_card_count = 0
event = Event({
	blockable = false,
	blocking = false,
	pause_force = true,
	no_delete = true,
	trigger = "after",
	delay = 3,
	timer = "UPTIME",
	func = function()
		if G.jokers and cached_card_count ~= G.jokers.config.card_count then
			cached_card_count = G.jokers.config.card_count
			G.jokers.children.area_uibox:remove()
			G.jokers.children.area_uibox = nil
			G.jokers:draw()
		end
		event.start_timer = false
	end,
})
G.E_MANAGER:add_event(event)
