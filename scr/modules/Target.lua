-- Meta class
Target = {}

 -- Derived class method new
 -- @param scr c'est le chemain pour le le sprite
 -- @param position est une variable du type Vector
function Target:new(scr_sprite, position) -- assets/target.png
    local o = {} 
    setmetatable(o,self)     
    self.__index = self

    o.position = Vector:new(position.x, position.y)
    o.image = love.graphics.newImage(scr_sprite)
    o.width  = o.image:getWidth()
    o.height = o.image:getHeight()


    o.velocity = 150
    o.direction = VECTOR_RIGHT:addtion(VECTOR_DOWN):normalazed() -- sens sud est


    -- o.limit_min_x = 0
    -- o.limit_min_y = 0
    -- o.limit_max_x = o.width
    -- o.limit_max_y = o.height

    o.die = false

    return o
end

-- @param dt cest le delta time
function Target:move(dt)
    local direction_velocity = self.direction.multiplication(self.velocity * dt)
    self.position = self.position:addtion(direction_velocity)

   -- if verifyLimitsEcran(targetX, targetMinX, targetMaxX) then
    --    targetVelocityX = -targetVelocityX;
    --end

    -- if verifyLimitsEcran(targetY, targetMinY, targetMaxY) then
       -- targetVelocityY = -targetVelocityY;
    -- end
end


function Target:draw ()
    love.graphics.draw(self.image, self.position.x, self.position.y)
end