local GameObject = require("scr.modules.GameObject")
local Vector = require("scr.modules.Vector")

-- Meta data
local Cage = setmetatable({}, {__index = GameObject})
Cage.__index = Cage

---------------------------------------------------------------
--  NEW 
---------------------------------------------------------------
 -- Classe Cage
 -- @param scr (string): c'est le chemain pour le le sprite
 -- @param position (table:Vector): position initiel
 -- @param direction (table: Vector) :  direction qui le objet si deplace
 -- @param velocity (number): valeur en pixel par frame qui le objet si deplace
 -- @param limit_horizontal (table:Vector): limit horizontal du object (il ne peut pas passer ça)
 -- @param limit_vertical (table:Vector): limit horizontal du object (il ne peut pas passer ça)
function Cage.new(src_sprite, position)
    local o = setmetatable(GameObject.new(src_sprite, position, Vector:Zero(), 0), Cage)

    -- pigeons du type Table:Pigeon
    o.pigeons = {}

    o.bounds_horizontal = Vector.new(o.position.x, o.position.x + 100)
    o.bounds_vertical = Vector.new(o.position.y, o.position.y + 100)

    return o
end


-- @param pigeon (table: Pigeon)
function Cage:addPiegon(pigeon)
    -- get random position in cage
    pigeon:setCapturated(Vector.new(self.bounds_horizontal.y, self.bounds_vertical.y))
    pigeon.index = #self.pigeons + 1
    self.pigeons[pigeon.index] = pigeon
end

---------------------------------------------------------------
--  DRAW
---------------------------------------------------------------
function Cage:draw()
    for key, pigeon in ipairs(self.pigeons) do
        pigeon:draw()
    end
end

return Cage