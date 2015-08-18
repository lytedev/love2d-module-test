require("utils")
require("menus/menuitems/menuitem")
menuitems.label = menuitem:new()

function menuitems.label:init()
	self.text = "Button"
	self.pos = { 0, 0 }
	self.size = { 1000, 16 }
	self.align = "left"

	self.active = false
	self.enabled = false

	self.color = { 255, 255, 255, 255 }
end

function menuitems.label:update(dt)

end

function menuitems.label:draw()
	love.graphics.setColor(self.color) 
	love.graphics.printf(self.text, self.pos[1], self.pos[2], self.size[1], self.align)
end