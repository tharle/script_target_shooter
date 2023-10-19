local Pigeon = require("scr.modules.Pigeon")
local Vector = require("scr.modules.Vector")

-- Meta class
local PigeonFactory = {}
PigeonFactory.__index = PigeonFactory

-- 
 -- 
 -- @param game_configuration (table:Vector) referance pour le controlateur du jeu
function PigeonFactory.new(game_configuration)
    local o = {}
    setmetatable(o, PigeonFactory)
    o.game_configuration = game_configuration

    return o
end

function PigeonFactory:create()
    local scr_sprite_animation = self:getRandomSpritePigeon()
    local position = self:getRadomPosition()
    local direction = self:getRandomDirection()
    local velocity = self:getRandomVelocity()

    local pigeon = Pigeon.new(
        position, -- postion
        direction, -- direction
        velocity, -- velocity
        self.game_configuration -- configuration de jeu
    )
    pigeon:setAnimation(
        scr_sprite_animation, 
        self.game_configuration.pigeon_width, 
        self.game_configuration.pigeon_height, 
        self.game_configuration.pigeon_velocity_animation)
    

    return pigeon
end

function PigeonFactory:getRandomSpritePigeon()
    local index = math.random(1, self.game_configuration.pigeon_count_type_pigeons)
    return self.game_configuration.pigeon_src_sprite..index..".png"
end

function PigeonFactory:getRadomPosition()
    return Vector:randomVector(self.game_configuration.pigeon_bounds_horizontal, self.game_configuration.pigeon_bounds_vertical)
end

function PigeonFactory:getRandomDirection()
    local random_angle = math.rad(math.random(180, 360))
    local x = math.cos(random_angle)
    local y = math.sin(random_angle)
    
    return Vector.new(x, y):normalazed()
end

function PigeonFactory:getRandomVelocity()
    local limit_velocity =  self.game_configuration.pigeon_limit_velocity
    return math.random(limit_velocity.x * self.game_configuration.level, limit_velocity.y * self.game_configuration.level)
end


return PigeonFactory