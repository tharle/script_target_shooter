-- Meta class
local GameObject = require("scr.modules.GameObject")
local Vector = require("scr.modules.Vector")

GAME_STATE_RUN = 0
GAME_STATE_MENU = 1
GAME_STATE_OVER = 2

 -- Objet utilisé dans le jeu
 -- @param scr (string) : c'est le chemain pour le le sprite
 -- @param position (table:Vector): position initiel 
local ScenarioController = {}
ScenarioController.__index = ScenarioController
function ScenarioController.new()
    local o = {} 
    o.background = GameObject.new("url", )

    setmetatable(o, ScenarioController)     

    return o
end