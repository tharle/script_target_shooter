local GameObject = require("scr.modules.GameObject")
local Paralax = require("scr.modules.Paralax")
local Vector = require("scr.modules.Vector")

-- Constants de configuration
local ROOT_URL = "assets/sprites/BG/"
local SKY_URL = ROOT_URL.."sky.png"
local CLOUD_URL = ROOT_URL.."cloud.png"
local CLOUD_VELOCITY = 15
local MOUNTAIN_URL = ROOT_URL.."mountain.png"
local GRASS_URL = ROOT_URL.."grass.png"

 -- Le background du jeu
local Background = {}
Background.__index = Background

---------------------------------------------------------------
--  NEW 
---------------------------------------------------------------
function Background.new()
    local o = {} 
    -- static
    local sky = GameObject.new(SKY_URL) 
    local cloud = Paralax.new(CLOUD_URL, Vector:Zero(), Vector:Right(), CLOUD_VELOCITY) 
    local montain = GameObject.new(MOUNTAIN_URL)
    local grass = GameObject.new(GRASS_URL)
    o.sprites = { sky, cloud, montain, grass }

    setmetatable(o, Background)     
    return o
end

---------------------------------------------------------------
--  UPDATE
---------------------------------------------------------------
function Background:update(dt)
    for key, sprite in ipairs(self.sprites) do
        sprite:update(dt)
    end
end

---------------------------------------------------------------
--  DRAW
---------------------------------------------------------------
function Background:draw()
    for key, sprite in ipairs(self.sprites) do
        sprite:draw(dt)
    end
end

return Background