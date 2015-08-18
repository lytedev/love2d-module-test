require("scenes/scene")
require("menus/main")
require("utils")
scenes.menu = scene:new()

function scenes.menu:init()
	self.menu = menus.main:new()

	self.nextMenu = ""
	self.fader = fader:new()
    self.fader.color = { 11, 11, 11, 255 }
    self.fader.startTime = 0
    self.fader.fadeTime = 0.3
    self.fader.endTime = 0
    self.fader.time = self.fader:getTotalTime()
    self.fader.fadeOut = false
end

function scenes.menu:update(dt)
	self.menu:update(dt)
	self.fader:update(dt)
end

function scenes.menu:draw()
	love.graphics.setColor(255, 255, 255, 255)
	self.menu:draw()
	self.fader:draw()
	love.graphics.setColor(255, 255, 255, 255)
end

function scenes.menu:loadMenu(menuName)
	self.fader.time = 0
    self.fader.startTime = 0.05
    self.fader.fadeTime = 0.1
    self.fader.endTime = 0.05
	self.fader.fadeOut = true
	self.fader.finished = false
	self.nextMenu = menuName
	self.fader.onFinish = function() scene:loadMenuCallback() end
end

function scenes.menu:loadMenuCallback()
	if self.nextMenu == "" then return end
	require("menus/" .. self.nextMenu)
	self.menu = menus[self.nextMenu]:new()

	self.fader.time = self.fader:getTotalTime()
    self.fader.startTime = 0.05
    self.fader.fadeTime = 0.1
    self.fader.endTime = 0.05
	self.fader.fadeOut = false
	self.fader.finished = false
	self.nextMenu = menuName
	self.fader.onFinish = function() return end
end
