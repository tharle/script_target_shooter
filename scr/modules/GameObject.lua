-- Meta class
GameObject = {}

 -- Derived class method new
 -- @param scr c'est le chemain pour le le sprite
 -- @param position est une variable du type Vector
function GameObject:new(src_sprite, position)
    local o = {} 
    setmetatable(o,self)     
    self.__index = self

    o.position = Vector:new(position.x, position.y)
    o.image = love.graphics.newImage(src_sprite)
    o.width  = o.image:getWidth()
    o.height = o.image:getHeight()


    o.velocity = 150
    o.direction = VECTOR_RIGHT:addtion(VECTOR_DOWN):normalazed() -- sens sud est


    o.limit_min_x = 0
    o.limit_min_y = 0
    o.limit_max_x = math.huge
    o.limit_max_y = math.huge

    return o
end

function GameObject:setDrawLimitHorizontal(limit_min_x, limit_max_x)
    -- TODO effectuer des calculues par rapport le sprite
    self.limit_min_x = limit_min_x
    self.limit_max_x = limit_max_x
end

function GameObject:setDrawLimitVertical(limit_min_y, limit_max_y)
    -- TODO effectuer des calculues par rapport le sprite
    self.limit_min_y = limit_min_y
    self.limit_max_y = limit_max_y
end

-- @param dt cest le delta time
function GameObject:move(dt)
    local velocityByTime = self.velocity * dt
    local direction_velocity = self.direction:multiplication(velocityByTime)
    self.position = self.position:addtion(direction_velocity)

    if self:IsInLimitsScreenHorizontal(self.position.x) then
        print("PASSOU X")
        self.direction.x = self.direction.x * -1;
    end

    if self:IsInLimitsScreenVertical(self.position.y) then
        print("PASSOU Y")
        self.direction.y = self.direction.y * -1;
    end
end

function GameObject:IsInLimitsScreenHorizontal(value)
    return value > self.limit_max_x or value < self.limit_min_x;
end

function GameObject:IsInLimitsScreenVertical(value)
    return value > self.limit_max_y or value < self.limit_min_y;
end


function GameObject:draw()
    love.graphics.draw(self.image, self.position.x, self.position.y)
end