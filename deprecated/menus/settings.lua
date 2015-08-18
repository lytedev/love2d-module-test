require("menus/main")
menus.settings = menus.main:new()

function menus.settings:init()
	self.keymap = {
		onpress = {
			escape = function()
				if love.textInputMode then
					love.textInputMode = false
					self.setActiveItem(-1)
				else
					scene:loadMenu("quit")
				end
			end,

			up = function() self:activatePreviousItem() end,
			w = function() if not love.textInputMode then self:activatePreviousItem() end end,

			down = function() self:activateNextItem() end,
			s = function()if not love.textInputMode then self:activateNextItem() end end,

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

	require("menus/menuitems/textarea")
	require("menus/menuitems/button")

	local testText = menuitems.textarea:new()
	testText.text = ""
	testText.pos = {50, 50}
	testText.onSelect = function() love.textInputMode = true end
	testText.onDeselect = function() love.textInputMode = false end

	local quit = menuitems.button:new()
	quit.text = "Back"
	quit.pos = {50, 200}
	quit.onSelect = function() scene:loadMenu("main") end

	self:addItem(quit)
	self:addItem(testText)

	self:activateMouseItem()
end
