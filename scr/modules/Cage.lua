local GameObject = require("scr.modules.GameObject")
local Vector = require("scr.modules.Vector")

-- Meta data
local Cage = {}
Cage.__index = Cage

---------------------------------------------------------------
--  NEW 
---------------------------------------------------------------
 -- Classe Cage
 -- @param position (table:Vector): position initiel
 -- @param offset_x (number): valeur de offset pour les pigeon ne pas sortir de la cage visualement
 -- @param offset_y (number): valeur de offset pour les pigeon ne pas sortir de la cage visualement
function Cage.new(position, offset_x, offsset_y)
    local o = {}

    -- pigeons du type Table:Pigeon
    o.pigeons = {}
    o.position = position

    o.cage_front    = GameObject.new("assets/sprites/objects/pigeons/pigeons_cage_front.png", position)
    o.cage_back     = GameObject.new("assets/sprites/objects/pigeons/pigeons_cage_back.png", position)

    local max_bound_horizontal = o.position.x + o.cage_front.width - offset_x
    local max_bound_vertical = o.position.y + o.cage_front.height - offsset_y
    o.bounds_horizontal = Vector.new(o.position.x, max_bound_horizontal)
    o.bounds_vertical = Vector.new(o.position.y, max_bound_vertical)

    setmetatable(o, Cage)

    return o
end


-- @param pigeon (table: Pigeon)
function Cage:addPiegon(pigeon)
    -- get random position in cage
    local position_pigeon = Vector:randomVector(self.bounds_horizontal, self.bounds_vertical)
    pigeon:setCapturated(position_pigeon)
    pigeon.index = #self.pigeons + 1
    self.pigeons[pigeon.index] = pigeon
end

---------------------------------------------------------------
--  DRAW
---------------------------------------------------------------
function Cage:draw()
    self.cage_back:draw()
    for key, pigeon in ipairs(self.pigeons) do
        pigeon:draw()
    end
    self.cage_front:draw()
    love.graphics.rectangle("line", self.bounds_horizontal.x,self.bounds_vertical.x, self.cage_front.width, self.cage_front.height)
end

return Cage