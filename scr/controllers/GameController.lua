local GameState = require("scr.modules.GameState")

-- Meta class
local GameController = {}
GameController.__index = GameController

-- Objet utilisé pour garder des infos importantes du jeu
function GameController.new()
    local o = {} 
    setmetatable(o, GameController)     

    o.score = 0
    -- o.game_state = GameState.stateRun()
    o.game_state = GameState.stateGameOver()

    return o
end

function GameController:equalsGameState(game_state)
    return self.game_state == game_state
end


return GameController