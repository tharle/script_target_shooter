local GameState = require("scr.modules.GameState")
local Vector = require("scr.modules.Vector")

CONFIG_TIMER_MAX = 10
CONFIG_RESOLUTION_WIDTH = 800
CONFIG_RESOLUTION_HEIGHT = 600
CONFIG_GUN_MAGAZINE_SIZE = 5

-- Meta class
local GameConfiguration = {}
GameConfiguration.__index = GameConfiguration

-- Objet utilisé pour garder des infos importantes du jeu
function GameConfiguration.new()
    local o = {} 
    setmetatable(o, GameConfiguration)     

    o.title = "CATH THE PIGEON"
    o.level = 5
    o.timer_start = 40
    o.gun_magazine_size = 5
    o.resolution = Vector.new(CONFIG_RESOLUTION_WIDTH, CONFIG_RESOLUTION_HEIGHT)
    o.resolution_hud = Vector.new(CONFIG_RESOLUTION_WIDTH, 50)
    o.limit_horizontal = Vector.new(0, CONFIG_RESOLUTION_WIDTH) -- limit horizontal
    o.limit_vertical = Vector.new(o.resolution_hud.y,CONFIG_RESOLUTION_HEIGHT) -- limit vertical
    o.pigeon_count_type_pigeons = 1
    o.pigeons_amount_by_level = 5
    o.pigeon_width = 44
    o.pigeon_height = 36
    o.pigeon_velocity_animation = 0.5
    o.pigeon_bounds_horizontal = Vector.new(400, 400)
    o.pigeon_bounds_vertical = Vector.new(300, 300)
    o.pigeon_limit_velocity = Vector.new(20, 50)
    o.pigeon_src_sprite = "assets/sprites/objects/pigeons/pigeon_fly_"


    
    love.window.setMode(CONFIG_RESOLUTION_WIDTH, CONFIG_RESOLUTION_HEIGHT)
    love.window.setTitle( o.title )

    math.randomseed( os.time() )

    return o
end

return GameConfiguration