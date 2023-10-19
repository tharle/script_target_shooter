local GameObject = require("scr.modules.GameObject")
local Vector = require("scr.modules.Vector")

-- Meta data
local Pigeon = setmetatable({}, {__index = GameObject})
Pigeon.__index = Pigeon

---------------------------------------------------------------
--  NEW 
---------------------------------------------------------------
 -- Classe Pigeon
 -- @param position (table:Vector): position initiel
 -- @param direction (table: Vector) :  direction qui le objet si deplace
 -- @param velocity (number): valeur en pixel par frame qui le objet si deplace
 -- @param game_configuration (table: GameConfiguration) parametres de jeu
function Pigeon.new(position, direction, velocity, game_configuration)
    local o = setmetatable(GameObject.new(nil, position, direction, velocity), Pigeon)
    o.game_configuration = game_configuration
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
        self:verifyLimits()
    end
end

-- verifie les limites pour le deplacement des pigeons
function Pigeon:verifyLimits()
    local compare_horizontal = self:isInLimitsScreenHorizontal()
    if compare_horizontal ~= 0 then
        self.direction.x = self.direction.x * -1;

        -- correction pour eviter des bogues
        if compare_horizontal < 0 then self.position.x = self.game_configuration.limit_horizontal.x
        else self.position.x = self.game_configuration.limit_horizontal.y - self.width end
    end

    local compare_vertical = self:isInLimitsScreenVertical()
    if compare_vertical ~= 0 then
        self.direction.y = self.direction.y * -1;

        -- correction pour eviter des bogues
        if compare_vertical < 0 then self.position.y = self.game_configuration.limit_vertical.x
        else self.position.y = self.game_configuration.limit_vertical.y - self.height end
    end
end

function Pigeon:isInLimitsScreenHorizontal()
    local collision_bound_x = self.position.x + self.collision_bound.x;
    local limit_horizontal = self.game_configuration.limit_horizontal
    return limit_horizontal:isInLimit(self.position.x, collision_bound_x)
end

function Pigeon:isInLimitsScreenVertical()
    local collision_bound_y = self.position.y + self.collision_bound.y;
    local limit_vertical = self.game_configuration.limit_vertical
    return limit_vertical:isInLimit(self.position.y, collision_bound_y)
end

-- @param point (table: Vector) : point de collision
function Pigeon:isCollide(point)
    local bounds_horizontal = Vector.new(self.position.x, self.position.x + self.width)
    local bounds_vertical = Vector.new(self.position.y, self.position.y + self.height)

    print("Bounds Horizontal")
    print(bounds_horizontal:toString())

    print("Bounds Vertical")
    print(bounds_vertical:toString())

    return bounds_horizontal:isInLimit(point.x) == 0 and bounds_vertical:isInLimit(point.y) == 0
end

function Pigeon:setCapturated(position_in_cage)
    self.position = position_in_cage
    self.free = false
    self.direction = Vector:Right()
end



---------------------------------------------------------------
--  DRAW
---------------------------------------------------------------
function Pigeon:draw()
    self:drawSprite()
    -- love.graphics.rectangle("line", self.position.x,self.position.y, self.width, self.height)
end

return Pigeon