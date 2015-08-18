require("utils")
menu = class:new()
menus = {}

function menu:init()	
	self.keymap = {
		onpress = {

		},
		onrelease = {

		},
		onupdate = {

		},
	}

	love.keymap = self.keymap

	self.items = {}
end

function menu:update(dt)
	self:updateItems(dt)
end

function menu:draw()
	self:drawItems()
end

function menu:addItem(menuItem)
	table.insert(self.items, 1, menuItem)
end

function menu:removeItem(id)
	table.remove(self.items, id)
end

function menu:selectItem(id)
	if id < 1 or id > #self.items then return end
	self.items[id]:callback()
end

function menu:updateItems(dt)
	for i = 1, #self.items, 1 do
		self.items[i]:update(dt)
	end
end

function menu:drawItems()
	for i = 1, #self.items, 1 do
		self.items[i]:draw()
	end
end