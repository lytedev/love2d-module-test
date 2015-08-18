require("scenes/scene")
require("gameobject/tile")
require("gameobject/creature")
require("utils")
scenes.game = scene:new()

function scenes.game:init()
    self.keymap = {
        onpress = {
            escape = function()
                    world:destroy()
                    pixelsPerMeter = 32
                    love.physics.setMeter(pixelsPerMeter)
                    world = love.physics.newWorld(0, 9.81 * pixelsPerMeter, true)
                    loadScene("menu")
                end,

            f11 = function()
                    local f = settings:getBool("window_fullscreen")
                    f = not f
                    settings:set("window_fullscreen", f)
                    settings:set("window_height", 0)
                    settings:set("window_width", 0)
                    reloadModeSettings()
                end,
            f10 = function()
                    for i, j in pairs(settings.data) do print(string.format("%s: %s", i, j)) end
                end,
            r = function()
                    resetWorld()
                    self.level.objects = {}
                    self.level.tiles = {}
                    self.player = gameobjects.creature:new(0, 20, 20, 16, 32)
                end,

            b = function()
                    local w = self.level.tilesize[1]
                    local h = self.level.tilesize[2]
                    for x = 1, self.level.size[1], 1 do
                        for y = 1, self.level.size[2], 1 do
                            local id = (y * self.level.size[1]) + x
                            if x == 1 or x == 120 or y == 1 or y == 68 then
                                self.level.tiles[id] = gameobjects.tile:new(0, (x * w) - (w / 2), (y * h) - (h / 2), w, h)
                            end
                        end
                    end
                end,
            d = function()
                    self.player.body:applyLinearImpulse(100, 0)
                end,
            a = function()
                    self.player.body:applyLinearImpulse(-100, 0)
                end,
        },
        onrelease = {

        },
        onupdate = {

        },
    }
    love.keymap = self.keymap

    resetWorld()

    love.graphics.setFont(fonts.pixel)
    scene.init(self)

    self.player = gameobjects.creature:new(0, 20, 20, 16, 32)

    self.level = {}
    self.level.tiles = {}
    self.level.tilesize = {16, 16}
    self.level.size = {200, 200}
    self.level.objects = {}
end

function scenes.game:update()
    scene.update(self)
    local x, y = love.mouse.getPosition()
    local w = self.level.tilesize[1]
    local h = self.level.tilesize[2]
    local xx = math.floor(x / w) + 1
    local yy = math.floor(y / h) + 1
    local id = (yy * self.level.size[1]) + xx
    if love.mouse.isDown("l") then
        if not self.level.tiles[id] then
            self.level.tiles[id] = gameobjects.tile:new(0, (xx * w) - (w / 2), (yy * h) - (h / 2), w, h)
        end
    end
    if love.mouse.isDown("x1") then
        local c = 1
        if love.keyboard.isDown("lctrl") then
            c = 10
        end
        for i = 1, c, 1 do
            local g = gameobject:new(0, x, y, w, h)
            g.body:applyLinearImpulse(0, 10)
            table.insert(self.level.objects, g)

        end
    end
    if love.mouse.isDown("r") then
        if self.level.tiles[id] then
            if self.level.tiles[id].fixture then
                love.physics.destroyFixture(self.level.tiles[id].fixture)
            end
        end
        self.level.tiles[id] = false
    end
end

function scenes.game:draw()
    scene.draw(self)

    love.graphics.setColor(128, 128, 128, 255)
    local ts = self.level.tilesize
    for x = 1, self.level.size[1], 1 do
        for y = 1, self.level.size[2], 1 do
            local id = (y * self.level.size[1]) + x
            local tile = self.level.tiles[id]
            if tile then
                -- love.graphics.setColor(128, 255, 128, 255)
                -- love.graphics.rectangle("fill", (x - 1) * ts[1], (y - 1) * ts[2], ts[1], ts[2])
                --love.graphics.setColor(128, 128, 128, 255)
                love.graphics.polygon("fill", tile.body:getWorldPoints(tile.shape:getPoints()))
            end
        end
    end
    love.graphics.setColor(128, 128, 255, 255)
    for i = 1, #self.level.objects, 1 do
        local obj = self.level.objects[i]
        -- love.graphics.polygon("fill", obj.body:getWorldPoints(obj.shape:getPoints()))
        love.graphics.polygon("fill", obj.body:getWorldPoints(obj.shape:getPoints()))
        --love.graphics.circle("fill", obj.body:getX(), obj.body:getY(), obj.shape:getRadius())
    end
    love.graphics.polygon("fill", self.player.body:getWorldPoints(self.player.shape:getPoints()))

    love.graphics.print("FPS: " .. tostring(love.timer.getFPS()), 5, 5)
end
