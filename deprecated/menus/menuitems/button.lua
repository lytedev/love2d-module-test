require("utils")
require("menus/menuitems/menuitem")
menuitems.button = menuitem:new()

function menuitems.button:init()
	self.text = "Button"
	self.pos = { 0, 0 }
	self.size = { 100, 16 }
	self.align = "left"

	self.active = false
	self.enabled = true

	self.color = { 255, 255, 255, 255 }
	self.activeColor = { 0, 200, 255, 255 }
	self.disabledColor = { 150, 150, 150, 255 }
end

function menuitems.button:update(dt)

end

function menuitems.button:draw()
	if not self.enabled then
		love.graphics.setColor(self.disabledColor)
	elseif self.active then
		love.graphics.setColor(self.activeColor)
	else
		love.graphics.setColor(self.color)
	end
	love.graphics.printf(self.text, self.pos[1], self.pos[2], self.size[1], self.align)
end
