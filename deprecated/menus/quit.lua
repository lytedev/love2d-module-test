require("menus/main")
menus.quit = menus.main:new()

function menus.quit:init()
	self.keymap = {
		onpress = {
			escape = function() scene:loadMenu("main") end,

			up = function() self:activatePreviousItem() end,
			w = function() self:activatePreviousItem() end,

			down = function() self:activateNextItem() end,
			s = function() self:activateNextItem() end,

			lmb = function() self:selectItem() end,
		},
		onrelease = {

		},
		onupdate = {

		},
	}
	self.keymap.onpress["return"] = function() if self.activeItem < 1 or self.activeItem > #self.items then love.event.quit() else self:selectItem() end end
	self.keymap.onpress[" "] = self.keymap.onpress["return"]

	love.keymap = self.keymap

	self.items = {}
	self.activeItem = -1

	require("menus/menuitems/button")
	require("menus/menuitems/label")

	local query = menuitems.label:new()
	query.text = "Are you sure you want to quit?"
	query.pos = {50, 50}
	query.color = { 0, 100, 255, 255 }

	local yes = menuitems.button:new()
	yes.text = "Yes"
	yes.pos = {50, 70}
	yes.onSelect = love.event.quit

	local no = menuitems.button:new()
	no.text = "No"
	no.pos = {50, 90}
	no.onSelect = function() scene:loadMenu("main") end

	self:addItem(query)
	self:addItem(yes)
	self:addItem(no)

	self:activateMouseItem()
end
