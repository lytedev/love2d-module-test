require("utils")
require("menus/menuitems/menuitem")
menuitems.textarea = menuitem:new()

function menuitems.textarea:init()
    self.text = "Text"
    self.pos = { 0, 0 }
    self.size = { 100, 30 }
    self.align = "left"

    self.carat = "|"
    self.caratDelay = 0.5
    self.currentCaratTime = 0
    self.caratPosition = 0

    self.active = false
    self.enabled = true
    self.onSelect = nil

    self.color = { 255, 255, 255, 255 }
    self.activeColor = { 255, 255, 255, 255 }
    self.disabledColor = { 150, 150, 150, 255 }

    self.backgroundColor = { 32, 32, 32, 255 }
    self.borderColor = { 150, 150, 150, 255 }
end

function menuitems.textarea:update(dt)
    self.currentCaratTime = (self.currentCaratTime + dt)
    if self.currentCaratTime > (self.caratDelay * 2) then
        self.currentCaratTime = self.currentCaratTime % (self.caratDelay * 2)
    end
    self.text = self.text .. love.textInput
    if love.textInput ~= "" then
        self.currentCaratTime = 0
    end
end

function menuitems.textarea:draw()
    love.graphics.setColor(self.backgroundColor)
    love.graphics.rectangle("fill", self.pos[1], self.pos[2], self.size[1], self.size[2])

    if not self.enabled then
        love.graphics.setColor(self.disabledColor)
    elseif self.active then
        love.graphics.setColor(self.activeColor)
    else
        love.graphics.setColor(self.color)
    end
    local drawstr = self.text
    if self.currentCaratTime <= self.caratDelay then
        drawstr = drawstr .. self.carat
    end
    love.graphics.printf(self.text, self.pos[1], self.pos[2], self.size[1], self.align)

    love.graphics.setColor(self.borderColor)
    love.graphics.rectangle("line", self.pos[1], self.pos[2], self.size[1], self.size[2])
end
