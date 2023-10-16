local GameState = require("scr.modules.GameState")
local Vector = require("scr.modules.Vector")

CONFIG_TIMER_MAX = 10
CONFIG_RESOLUTION_WIDTH = 800
CONFIG_RESOLUTION_HEIGHT = 600

-- Meta class
local GameController = {}
GameController.__index = GameController

-- Objet utilisé pour garder des infos importantes du jeu
function GameController.new()
    local o = {} 
    setmetatable(o, GameController)     

    o.score = 0
    o.timer = CONFIG_TIMER_MAX
    o.game_state = GameState.stateRun()
    o.resolution = Vector.new(CONFIG_RESOLUTION_WIDTH, CONFIG_RESOLUTION_HEIGHT)

    return o
end

function GameController:equalsGameState(game_state)
    return self.game_state == game_state
end


return GameController