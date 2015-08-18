require("menus/main")
menus.play = menus.main:new()

function menus.play:init()
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
	self.keymap.onpress["return"] = self.keymap.onpress.lmb
	self.keymap.onpress[" "] = self.keymap.onpress.lmb

	love.keymap = self.keymap

	self.items = {}
	self.activeItem = -1

	require("menus/menuitems/button")

	local quit = menuitems.button:new()
	quit.text = "Back"
	quit.pos = {50, 90}
	quit.onSelect = function() scene:loadMenu("main") end

	self:addItem(quit)

	self:activateMouseItem()
end
