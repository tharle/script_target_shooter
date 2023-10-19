local Animation = require("scr.controllers.Animation")
local GameObject = require("scr.modules.GameObject")
local Paralax = require("scr.modules.Paralax")
local Vector = require("scr.modules.Vector")

-- Meta data
local MenuScreen = {}
MenuScreen.__index = MenuScreen

---------------------------------------------------------------
--  NEW 
---------------------------------------------------------------
function MenuScreen.new()
    local o = {}
    o.background_position = Vector.new(200, 100)
    o.background_paralax = Paralax.new("assets/sprites/menu/menu_paralax.png", Vector:Zero(), Vector:Right(), 50) 
    o.background_menu = GameObject.new("assets/sprites/HUD/menu_background.png", o.background_position)

    o.title_font = love.graphics.newFont("assets/fonts/gamer.ttf", 60) -- load de font personalizé
    o.body_font = love.graphics.newFont("assets/fonts/gamer.ttf", 30) -- load de font personalizé
    o.width = 44
    o.height = 36
    o.animation_mouse = MenuScreen:loadMouseAnimation(o)
    o.position = Vector:Zero()

    setmetatable(o, MenuScreen)
    return o
end

function MenuScreen:loadMouseAnimation(object)
    local scr_sprite_sheet = "assets/sprites/menu/mouse.png"
    local newimage = love.graphics.newImage(scr_sprite_sheet)
    local duration = 1
    love.mouse.setVisible(false)
    return Animation.new(object, scr_sprite_sheet, object.width, object.height, duration)
end

function MenuScreen:update(dt)
    local x, y = love.mouse.getPosition()
    x = x - self.width / 2
    y = y - self.height / 2
    self.position:set(x, y)

    self.background_paralax:update(dt)
    self.animation_mouse:update(dt)

    --- watch any key
end

function MenuScreen:isLookingRight()
    return true
end

function MenuScreen:draw()
    self.background_paralax:draw()
    self.background_menu:draw()
    love.graphics.setFont(self.title_font)
    love.graphics.print("CATCH", self.background_position.x + 130, self.background_position.y + 10) 
    love.graphics.print("THE", self.background_position.x + 150, self.background_position.y + 70) 
    love.graphics.print("PIGEONS", self.background_position.x + 110, self.background_position.y + 130) 

    love.graphics.setFont(self.body_font)
    
    love.graphics.print("- Press any key to start -", 270, 380)
    self.animation_mouse:draw()
end

return MenuScreen