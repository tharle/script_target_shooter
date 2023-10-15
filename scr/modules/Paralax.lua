 
 local GameObject = require("scr.modules.GameObject")
 local Vector = require("scr.modules.Vector")

 -- Meta data
 local Paralax = setmetatable({}, {__index = GameObject})
 Paralax.__index = Paralax

 -- L'image paralax
 function Paralax.new(src_sprite, position, direction, velocity)
    local o = setmetatable(GameObject.new(src_sprite, position, direction, velocity), Paralax)
    return o
 end

---------------------------------------------------------------
--  UPDATE
---------------------------------------------------------------
-- @param dt (number): cest le delta time
function Paralax:update(dt)
    self:move(dt)

    -- si le paralax touche le limite de l'image
    if self.position.x > self.sprite:getWidth() then
        -- on reset la position
        self.position.x = 0
    end
 end


---------------------------------------------------------------
--  Draw
---------------------------------------------------------------

function Paralax:draw()
    local bounds = Vector.new(self.sprite:getWidth(), 0)
    local position_sprite_before = self.position:subtraction(bounds)
    local position_sprite_after = self.position:addtion(bounds)
    
    love.graphics.draw(self.sprite, position_sprite_before.x, position_sprite_before.y)
    love.graphics.draw(self.sprite, self.position.x, self.position.y)
    love.graphics.draw(self.sprite, position_sprite_after.x, position_sprite_after.y)
end

 return Paralax