local GameObject = require("scr.modules.GameObject")
local Vector = require("scr.modules.Vector")

-- Meta data
local Pigeon = setmetatable({}, {__index = GameObject})
Pigeon.__index = Pigeon

---------------------------------------------------------------
--  NEW 
---------------------------------------------------------------
 -- Classe Pigeon
 -- @param scr (string): c'est le chemain pour le le sprite
 -- @param position (table:Vector): position initiel
 -- @param direction (table: Vector) :  direction qui le objet si deplace
 -- @param velocity (number): valeur en pixel par frame qui le objet si deplace
 -- @param limit_horizontal (table:Vector): limit horizontal du object (il ne peut pas passer ça)
 -- @param limit_vertical (table:Vector): limit horizontal du object (il ne peut pas passer ça)
function Pigeon.new(src_sprite, position, direction, velocity, limit_horizontal, limit_vertical)
    local o = setmetatable(GameObject.new(src_sprite, position, direction, velocity), Pigeon)

    o.limit_horizontal  = limit_horizontal or Vector.new(0, math.huge)
    o.limit_vertical    = limit_vertical or Vector.new(0, math.huge)
    o.free = true

    return o
end

---------------------------------------------------------------
--  UPDATE
---------------------------------------------------------------
-- [Overrite]
-- @param dt (number) cest le delta time
function Pigeon:update(dt)
    if self.free then
        self:move(dt)

        if not self:isInLimitsScreenHorizontal() then
            self.direction.x = self.direction.x * -1;
        end

        if not self:isInLimitsScreenVertical() then
            self.direction.y = self.direction.y * -1;
        end
    end
end

function Pigeon:isInLimitsScreenHorizontal()
    local collision_bound_x = self.position.x + self.collision_bound.x;
    return self.limit_horizontal:isInLimit(self.position.x, collision_bound_x)
end

function Pigeon:isInLimitsScreenVertical()
    local collision_bound_y = self.position.y + self.collision_bound.y;
    return self.limit_vertical:isInLimit(self.position.y, collision_bound_y)
end

-- @param point (table: Vector) : point de collision
function Pigeon:isCollide(point)
    local bounds_horizontal = Vector.new(self.position.x, self.position.x + self.width)
    local bounds_vertical = Vector.new(self.position.y, self.position.y + self.width)

    return bounds_horizontal:isInLimit(point.x) and bounds_vertical:isInLimit(point.y)
end

function Pigeon:isCapturated(position_in_cage)
    self.position = position_in_cage
    self.free = false
    self.direction = Vector:Right()
end

return Pigeon