local Animation = require("scr.controllers.Animation")
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
    
    if src_sprite ~= nil then
        o.sprite            = love.graphics.newImage(src_sprite)
        o.width             = o.sprite:getWidth()
        o.height            = o.sprite:getHeight()
        o.collision_bound   = Vector.new(o.width, o.height)
    else
        o.width             = 0
        o.height            = 0
        o.collision_bound   = Vector:Zero()
    end

    o.position  = position or Vector:Zero()
    o.direction = direction or Vector:Zero()
    o.velocity  = velocity or 0
    -- o.angle     = 0
    

    setmetatable(o, GameObject)     

    return o
end

-- si la animation a été crée, elle va remplacer le sprite
function GameObject:setAnimation(scr_sprite_sheet, width, height, duration)
    self.width              = width
    self.height             = height
    self.collision_bound    = Vector.new(width, height)
    self.animation          = Animation.new(self, scr_sprite_sheet, width, height, duration)
end

---------------------------------------------------------------
--  UPDATE
---------------------------------------------------------------
-- @param dt (number): cest le delta time
function GameObject:update(dt)
    self:move(dt)
end

function GameObject:move(dt)
    local velocityByTime = self.velocity * dt
    local direction_velocity = self.direction:multiplication(velocityByTime)
    self.position = self.position:addtion(direction_velocity)

    if self.animation then
        self.animation:update(dt)
    end

    --self.angle = self.direction:angle()
    
end

-- @return (table:Vector) avec le position x,y du centre de la sprite du GameObject
function GameObject:getCentre()
    self.centre = self.centre or Vector:Zero()
    local centre_x = self.position.x + self.width/2
    local centre_y = self.position.y + self.height/2
    self.centre:set(centre_x, centre_y)
    return self.centre
end

---------------------------------------------------------------
--  DRAW
---------------------------------------------------------------
function GameObject:draw()
    if self.animation ~= nil then
        self.animation:draw()
        
        love.graphics.rectangle("line", self.position.x,self.position.y, self.width, self.height)

    elseif self.sprite ~= nil then
        love.graphics.draw(self.sprite, self.position.x, self.position.y)
    end
end

return GameObject