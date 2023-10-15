local GameObject = require("scr.modules.GameObject")
local Vector = require("scr.modules.Vector")



-- Meta data
local Target = setmetatable({}, {__index = GameObject})
Target.__index = Target

---------------------------------------------------------------
--  NEW 
---------------------------------------------------------------
 -- Classe Target
 -- @param scr (string): c'est le chemain pour le le sprite
 -- @param position (table:Vector): position initiel
 -- @param direction (table: Vector) :  direction qui le objet si deplace
 -- @param velocity (number): valeur en pixel par frame qui le objet si deplace
 -- @param limit_horizontal (table:Vector): limit horizontal du object (il ne peut pas passer ça)
 -- @param limit_vertical (table:Vector): limit horizontal du object (il ne peut pas passer ça)
function Target.new(src_sprite, position, direction, velocity, limit_horizontal, limit_vertical)
    local o = setmetatable(GameObject.new(src_sprite, position, direction, velocity), Target)

    o.limit_horizontal  = limit_horizontal or Vector.new(0, math.huge)
    o.limit_vertical    = limit_vertical or Vector.new(0, math.huge)
    o.collision_bound   = Vector.new(o.sprite:getWidth(), o.sprite:getHeight())

    return o
end

---------------------------------------------------------------
--  UPDATE
---------------------------------------------------------------
-- [Overrite]
-- @param dt (number) cest le delta time
function Target:update(dt)
    local velocityByTime = self.velocity * dt
    local direction_velocity = self.direction:multiplication(velocityByTime)
    self.position = self.position:addtion(direction_velocity)

    if not self:isInLimitsScreenHorizontal() then
        self.direction.x = self.direction.x * -1;
    end

    if not self:isInLimitsScreenVertical() then
        self.direction.y = self.direction.y * -1;
    end
end

function Target:isInLimitsScreenHorizontal()
    local collision_bound_x = self.position.x + self.collision_bound.x;
    return self.limit_horizontal:isInLimit(self.position.x, collision_bound_x)
end

function Target:isInLimitsScreenVertical()
    local collision_bound_y = self.position.y + self.collision_bound.y;
    return self.limit_vertical:isInLimit(self.position.y, collision_bound_y)
end

return Target