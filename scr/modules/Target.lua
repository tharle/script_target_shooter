-- Meta class
local GameObject = require("scr.modules.GameObject")
local Vector = require("scr.modules.Vector")

 -- Classe Target
 -- @param scr (string): c'est le chemain pour le le sprite
 -- @param position (table:Vector): position initiel 
local Target = setmetatable({}, {__index = GameObject})
Target.__index = Target
function Target.new(src_sprite, position)
    local o = setmetatable(GameObject.new(src_sprite, position), Target)

    o.limit_horizontal = Vector.new(0, math.huge)
    o.limit_vertical = Vector.new(0, math.huge)

    return o
end

-- @param limit_horizontal (table:Vector): est une variable du type Vector
function Target:setLimitHorizontal(limit_horizontal)
    limit_horizontal.y = limit_horizontal.y - self.image:getWidth()
    self.limit_horizontal = limit_horizontal
end

-- @param limit_vertical (table:Vector): est une variable du type Vector
function Target:setLimitVertical(limit_vertical)
    limit_vertical.y = limit_vertical.y - self.image:getHeight()
    self.limit_vertical = limit_vertical
end

function Target:isInLimitsScreenHorizontal()
    return self.limit_horizontal:isInLimit(self.position.x)
end

function Target:isInLimitsScreenVertical()
    return self.limit_vertical:isInLimit(self.position.y)
end

-- @param dt (number) cest le delta time
function Target:move(dt)
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

return Target