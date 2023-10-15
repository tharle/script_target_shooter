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

-- @param multplicator (number): cest un numero qui va multiplier dans le vector
function Vector:multiplication(multplicator)
    return Vector.new(self.x * multplicator, self.y * multplicator)
end

-- @param valueMin (number): vérifier si la valueMin est plus grand que x
-- @param valueMax (number): vérifier si la valueMax est plus petite que y
function Vector:isInLimit(valueMin, valueMax)
    valueMax = valueMax or valueMin
    return valueMin > self.x and valueMax < self.y;
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