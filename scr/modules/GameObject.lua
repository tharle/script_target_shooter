local Vector = require("scr.modules.Vector")

-- Meta data
local GameObject = {}
GameObject.__index = GameObject

---------------------------------------------------------------
--  NEW 
---------------------------------------------------------------
 -- Objet utilisé dans le jeu
 -- @param scr (string) : c'est le chemain pour le le sprite
 -- @param position (table:Vector): position initiel 
 -- @param direction (table: Vector) :  direction qui le objet si deplace
 -- @param velocity (number): valeur en pixel par frame qui le objet si deplace
function GameObject.new(src_sprite, position, direction, velocity)
    local o = {} 
    o.sprite    = love.graphics.newImage(src_sprite)
    o.width     = o.sprite:getWidth()
    o.height    = o.sprite:getHeight()
    o.position  = position or Vector:Zero()
    o.direction = direction or Vector:Zero()
    o.velocity  = velocity or 0

    setmetatable(o, GameObject)     

    return o
end

---------------------------------------------------------------
--  UPDATE
---------------------------------------------------------------
-- @param dt (number): cest le delta time
function GameObject:update(dt)
    local velocityByTime = self.velocity * dt
    local direction_velocity = self.direction:multiplication(velocityByTime)
    self.position = self.position:addtion(direction_velocity)
end

-- @return (table:Vector) avec le position x,y du centre de la sprite du GameObject
function GameObject:getCentre()
    self.centre = self.centre or Vector:Zero()
    local centre_x = self.position.x + self.sprite:getWidth()/2
    local centre_y = self.position.y + self.sprite:getHeight()/2
    self.centre:set(centre_x, centre_y)
    return self.centre
end

---------------------------------------------------------------
--  DRAW
---------------------------------------------------------------
function GameObject:draw()
    love.graphics.draw(self.sprite, self.position.x, self.position.y)
end

return GameObject