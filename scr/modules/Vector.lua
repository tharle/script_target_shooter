-- Classe Vector
local Vector = {}
Vector.__index = Vector

function Vector.new(x,y)
    local o = {}
    o.x = x or 0
    o.y = y or 0
    setmetatable(o, Vector)

    return o
end

function Vector:set(x, y)
    self.x = x
    self.y = y
end

-- @param vector_b (table: Vector): vector qui sera addicione au Vector self
function Vector:addtion(vector_b)
    local result_x = self.x + vector_b.x
    local result_y = self.y + vector_b.y

    return Vector.new(result_x, result_y)
end

function Vector:angleInRadians()
    local angle = math.atan2(-self.y, self.x)
    return angle
end

function Vector:angle()
    --local angle = math.deg(math.atan2(-self.y, self.x))
    local angle = math.deg(self:angleInRadians())
    
    if angle < 0 then
        return angle + 360
    else
        return angle
    end
end

function Vector:randomVector(vector_bounds_x, vector_bounds_y)
    local x = math.random(vector_bounds_x.x, vector_bounds_x.y)
    local y = math.random(vector_bounds_y.x, vector_bounds_y.y)
    
    return Vector.new(x, y)
end

-- @param multplicator (number): cest un numero qui va multiplier dans le vector
function Vector:multiplication(multplicator)
    return Vector.new(self.x * multplicator, self.y * multplicator)
end

-- @param valueMin (number): vérifier si la valueMin est plus grand que x
-- @param valueMax (number): vérifier si la valueMax est plus petite que y
-- @return (number) 0: si equal; 1: si plus grand max; -1: si plus petit que le min
function Vector:isInLimit(valueMin, valueMax)
    valueMax = valueMax or valueMin
    
    if valueMin < self.x then
        return -1
    end

    if valueMax > self.y then
        return 1
    end

    return 0
end

function Vector:normalazed()
    local magnitude = math.sqrt( (self.x ^ 2) + (self.y ^ 2) )
    return Vector.new(self.x/magnitude, self.y/magnitude)
end

 -- @param vector_b (table: Vector): vector qui sera subtrai au Vector self
 function Vector:subtraction(vector_b)
    local result_x = self.x - vector_b.x
    local result_y = self.y - vector_b.y

    return Vector.new(result_x, result_y)
end

function Vector:toString()
    return "Table:Vetor("..self.x..", "..self.y..")"
end


-- -------------------------------------------------------------------------
-- CONSTANTS DES VECTORS PRÉDEFINIS
-- -------------------------------------------------------------------------
function Vector:Zero()
    return Vector.new()
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