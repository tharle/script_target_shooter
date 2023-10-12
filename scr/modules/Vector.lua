-- Meta class
local Vector = {}
Vector.__index = Vector
-- Derived class method new
function Vector.new(x,y)
    local o = {}
    o.x = x
    o.y = y
    setmetatable(o, Vector)

    return o
end

function Vector:set(x, y)
    self.x = x
    self.y = y
end


 -- @param vector_b est une variable du type Vector
function Vector:subtraction(vector_b)
    local result_x = self.x - vector_b.x
    local result_y = self.y - vector_b.y

    return Vector.new(result_x, result_y)
end

-- @param vector_b est une variable du type Vector
function Vector:addtion(vector_b)
    local result_x = self.x + vector_b.x
    local result_y = self.y + vector_b.y

    return Vector.new(result_x, result_y)
end

-- @param number cest un numero qui va multiplier dans le vector
function Vector:multiplication(multplicator)
    return Vector.new(self.x * multplicator, self.y * multplicator)
end

function Vector:normalazed()
    local magnitude = math.sqrt( (self.x ^ 2) + (self.y ^ 2) )
    return Vector.new(self.x/magnitude, self.y/magnitude)
end

function Vector:isInLimit(value)
    return value > self.x and value < self.y;
end


function Vector:Left()
    return Vector.new(-1, 0)
end

function Vector:Right()
    return Vector.new(1, 0)
end

function Vector:Up()
    return Vector.new(0, -1)
end

function Vector:Down()
    return Vector.new(0, 1)
end

return Vector