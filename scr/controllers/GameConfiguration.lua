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

    o.title = "MON JEU"
    o.timer_start = 40
    o.gun_magazine_size = 5
    o.resolution = Vector.new(CONFIG_RESOLUTION_WIDTH, CONFIG_RESOLUTION_HEIGHT)

    
    love.window.setMode(CONFIG_RESOLUTION_WIDTH, CONFIG_RESOLUTION_HEIGHT)
    love.window.setTitle( o.title )

    return o
end

return GameConfiguration