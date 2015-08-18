require("menus/menu")
menus.main = menu:new()

function menus.main:init()
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

	local play = menuitems.button:new()
	play.text = "Play"
	play.pos = {50, 50}
	play.onSelect = function() scene:loadMenu("play") end

	local settings = menuitems.button:new()
	settings.text = "Settings"
	settings.pos = {50, 70}
	settings.onSelect = function() scene:loadMenu("settings") end

	local quit = menuitems.button:new()
	quit.text = "Quit"
	quit.pos = {50, 90}
	quit.onSelect = function() scene:loadMenu("quit") end

	self:addItem(play)
	self:addItem(settings)
	self:addItem(quit)

	self:activateMouseItem()

	love.graphics.setFont(fonts.serif)
end

function menus.main:update(dt)
	self:updateItems(dt)
	local x, y = love.mouse.getPosition()
	local ni = self.activeItem
	if lastMouseX ~= x or lastMouseY ~= y then
		self:activateMouseItem()
	end
end

function menus.main:draw()
	self:drawItems()
end

function menus.main:addItem(menuItem)
	table.insert(self.items, 1, menuItem)
end

function menus.main:removeItem(id)
	table.remove(self.items, id)
	if #self.items < 1 then
		self.activeItem = -1
	elseif self.activeItem > #self.items then
		self.activeItem = #self.items
	end
end

function menus.main:selectItem(id)
	id = id or self.activeItem
	if id < 1 or id > #self.items then return end
	self.items[id]:onSelect()
end

function menus.main:activateMouseItem()
	local x, y = love.mouse.getPosition()
	ni = -1
	for i = 1, #self.items, 1 do
		local j = self.items[i]
		if j.enabled then
			if pointInRect(x, y, j.pos[1], j.pos[2], j.size[1], j.size[2]) then
				ni = i
			end
		end
	end
	self:setActiveItem(ni)
	return ni
end

function menus.main:activateNextItem()
	local ni = self.activeItem - 1
	local oni = ni
	if ni > #self.items then
		ni = 1
	elseif ni < 1 then
		ni = #self.items
	end
	local success = self:setActiveItem(ni)
	if not success then
		self.activeItem = ni
		self:activateNextItem()
	end
end

function menus.main:activatePreviousItem()
	local ni = self.activeItem + 1
	if ni > #self.items then
		ni = 1
	elseif ni < 1 then
		ni = 1
	elseif ni < 1 then
		ni = #self.items
	end
	local success = self:setActiveItem(ni)
	if not success then
		self.activeItem = ni
		self:activatePreviousItem()
	end
end

function menus.main:setActiveItem(ni)
	if self.activeItem >= 1 and self.activeItem <= #self.items then
		self.items[self.activeItem].active = false
		if ni ~= self.activeItem then
			self.items[self.activeItem]:onDeselect()
		end
	end
	if ni >= 1 and ni <= #self.items and self.items[ni].enabled then
		self.activeItem = ni
		self.items[self.activeItem].active = true
		return true
	else
		self.activeItem = -1
		return false
	end
end
