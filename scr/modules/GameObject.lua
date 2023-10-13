local Vector = require("scr.modules.Vector")

 -- Objet utilisé dans le jeu
 -- @param scr (string) : c'est le chemain pour le le sprite
 -- @param position (table:Vector): position initiel 
local GameObject = {}
GameObject.__index = GameObject
function GameObject.new(src_sprite, position)
    local o = {} 
    o.position = position
    o.image = love.graphics.newImage(src_sprite)
    o.width = o.image:getWidth()
    o.height = o.image:getHeight()

    o.velocity = 150
    o.direction = Vector.Right()
    o.direction = Vector.Right():addtion(Vector.Down()):normalazed() -- sens sud est

    setmetatable(o, GameObject)     

    return o
end

-- @param dt (number): cest le delta time
function GameObject:move(dt)
    local velocityByTime = self.velocity * dt
    local direction_velocity = self.direction:multiplication(velocityByTime)
    self.position = self.position:addtion(direction_velocity)
end


function GameObject:draw()
    love.graphics.draw(self.image, self.position.x, self.position.y)
end

return GameObject