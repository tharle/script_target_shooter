local Animation = require("scr.controllers.Animation")
local Vector = require("scr.modules.Vector")

-- Meta class
local Player = {}
Player.__index = Player


---------------------------------------------------------------
--  NEW 
---------------------------------------------------------------
-- Objet utilisé pour controler la sorris
function Player.new(game_controller)
    local o = {} 
    
    o.scr_mouse_animation = ""
    o.position = Vector:Zero()
    o.width = 32
    o.height = 32
    o.animation_mouse = loadMouseAnimation(o)
    o.game_controller = game_controller
    o.isFiring = false

    setmetatable(o, Player)  

    return o
end

function loadMouseAnimation(object)
    local scr_sprite_sheet = "assets/sprites/objects/cross-mouse.png"
    local duration = 1
    love.mouse.setVisible(false)
    return Animation.new(object, scr_sprite_sheet, object.width, object.height, duration)
end

---------------------------------------------------------------
--  UPDATE
---------------------------------------------------------------
-- [Overrite]
-- @param dt (number) cest le delta time
function Player:update(dt)
    local x, y = love.mouse.getPosition()
    x = x - self.width / 2
    y = y - self.height / 2
    self.position:set(x, y)

    --if game_configuration:equalsGameState(GameState:stateMenu()) then
        
    --else -- GameState:stateRun() or autre game state iconnu
        self.animation_mouse:update(dt)
        self:onMouseClickTarget()
    --end
end

function Player:onMouseClickTarget()

    if  love.mouse.isDown(1) and not self.isFiring then
        self.isFiring = true
        local x, y = love.mouse.getPosition()
        local game_objects = self.game_controller:getAllGameObjetCollided(Vector.new(x, y))
        print(#game_objects)
    elseif not love.mouse.isDown(1) then
        self.isFiring = false
    end
end

---------------------------------------------------------------
--  DRAW
---------------------------------------------------------------
function Player:draw()
    
    --if game_configuration:equalsGameState(GameState:stateMenu()) then
        
    --else -- GameState:stateRun() or autre game state iconnu
        self.animation_mouse:draw()
    --end
end

return Player