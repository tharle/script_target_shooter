-- Meta class
local GameState = {}
GameState.__index = GameState

-- Classe pour garder les states du jeu
function GameState.new(GameState)
    local o = {} 
    setmetatable(o, GameState)

    return o
end

function GameState:stateRun()
    return 0
end 

function GameState:stateMenu()
    return 1
end 

function GameState:stateGameOver()
    return 2
end 

return GameState