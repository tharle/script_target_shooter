local Vector = require("scr.modules.Vector")

 -- Derived class method new
 -- @param scr c'est le chemain pour le le sprite
 -- @param position est une variable du type Vector
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


    o.limit_horizontal = Vector.new(0, math.huge)
    o.limit_vertical = Vector.new(0, math.huge)

    setmetatable(o, GameObject)     

    return o
end


 -- @param limit_horizontal est une variable du type Vector
function GameObject:setLimitHorizontal(limit_horizontal)
    limit_horizontal.y = limit_horizontal.y - self.image:getWidth()
    self.limit_horizontal = limit_horizontal
end

-- @param limit_vertical est une variable du type Vector
function GameObject:setLimitVertical(limit_vertical)
    limit_vertical.y = limit_vertical.y - self.image:getHeight()
    self.limit_vertical = limit_vertical
end

-- @param dt cest le delta time
function GameObject:move(dt)
    local velocityByTime = self.velocity * dt
    local direction_velocity = self.direction:multiplication(velocityByTime)
    self.position = self.position:addtion(direction_velocity)

    if not self:isInLimitsScreenHorizontal() then
        print("PASSOU X")
        self.direction.x = self.direction.x * -1;
    end

    if not self:isInLimitsScreenVertical() then
        print("PASSOU Y")
        self.direction.y = self.direction.y * -1;
    end
end

function GameObject:isInLimitsScreenHorizontal()
    return self.limit_horizontal:isInLimit(self.position.x)
end

function GameObject:isInLimitsScreenVertical()
    return self.limit_vertical:isInLimit(self.position.y)
end


function GameObject:draw()
    love.graphics.draw(self.image, self.position.x, self.position.y)
end

return GameObject