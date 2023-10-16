-- Meta class
local Vector = require("scr.modules.Vector")
local GameObject = require("scr.modules.GameObject")
local GameState = require("scr.modules.GameState")
local Target = require("scr.modules.Target")
local Background = require("scr.modules.Background")

local GameHud = require("scr.controllers.GameHud")

 -- 
 -- 
 -- @param game_controller (table:Vector) referance pour le controlateur du jeu
local GameStageScene = {}
GameStageScene.__index = GameStageScene
function GameStageScene.new(game_controller)
    local o = {} 
    o.game_controller = game_controller
    o.game_hud = GameHud.new(game_controller)
    o.background = Background.new()
    local tree_1 = GameObject.new("assets/sprites/objects/tree_2.png", Vector.new(25, 365))
    local tree_2 = GameObject.new("assets/sprites/objects/tree_1.png", Vector.new(550, 365))

    --TODO changer ça pour juste une sprite
    local terrain_1 = GameObject.new("assets/sprites/objects/gras_eath_2.png", Vector.new(0, 565))
    local terrain_2 = GameObject.new("assets/sprites/objects/gras_eath_2.png", Vector.new(64, 565))
    local terrain_3 = GameObject.new("assets/sprites/objects/gras_eath_2.png", Vector.new(128, 565))
    local terrain_4 = GameObject.new("assets/sprites/objects/gras_eath_2.png", Vector.new(192, 565))
    local terrain_5 = GameObject.new("assets/sprites/objects/gras_eath_2.png", Vector.new(256, 565))
    local terrain_6 = GameObject.new("assets/sprites/objects/gras_eath_2.png", Vector.new(320, 565))
    local terrain_7 = GameObject.new("assets/sprites/objects/gras_eath_2.png", Vector.new(384, 565))
    local terrain_8 = GameObject.new("assets/sprites/objects/gras_eath_2.png", Vector.new(448, 565))
    local terrain_9 = GameObject.new("assets/sprites/objects/gras_eath_2.png", Vector.new(512, 565))
    local terrain_10 = GameObject.new("assets/sprites/objects/gras_eath_2.png", Vector.new(576, 565))
    local terrain_11 = GameObject.new("assets/sprites/objects/gras_eath_2.png", Vector.new(640, 565))
    local terrain_12 = GameObject.new("assets/sprites/objects/gras_eath_2.png", Vector.new(704, 565))
    local terrain_13 = GameObject.new("assets/sprites/objects/gras_eath_2.png", Vector.new(768, 565))
    
    o.scenario_game_objects = { 
        target_1, 
        tree_1, 
        tree_2,
        terrain_1,
        terrain_2,
        terrain_3,
        terrain_4,
        terrain_5,
        terrain_6,
        terrain_7,
        terrain_8,
        terrain_9,
        terrain_10,
        terrain_11,
        terrain_12,
        terrain_13
    }

    local target_1 = Target.new(
        "assets/target.png",  -- url 
        Vector.new(220, 220), -- postion
        Vector:Right():addtion(Vector:Down()), -- direction
        150, -- velocity
        Vector.new(100, 700), -- limit horizontal
        Vector.new(100, 500) -- limit vertical
    )
    o.targets = {target_1}

    o.score = 0
        


    setmetatable(o, GameStageScene)     

    return o
end

---------------------------------------------------------------
--  UPDATE
---------------------------------------------------------------
function GameStageScene:update(dt)

    if game_controller:equalsGameState(GameState:stateMenu()) then
        print "JEU DANS MENU."
    elseif game_controller:equalsGameState(GameState:stateGameOver()) then
        print "JEU DANS GAME OVER."
    else -- GameState:stateRun() or autre game state iconnu
        print "JEU DANS RUN."
        self:run(dt)
    end
end

function GameStageScene:run(dt)
    self.background:update(dt)

    for key, game_object in ipairs(self.scenario_game_objects) do
        scenario_game_object:update(dt)
    end

    for key, target in ipairs(self.targets) do
        target:update(dt)
    end

    self.game_controller.timer = self.game_controller.timer - dt;

    if self.game_controller.timer <= 0 then
        self.game_controller.timer = 0
        self.game_controller.game_state = GameState:stateGameOver()
    end
end

---------------------------------------------------------------
--  DRAW
---------------------------------------------------------------
function GameStageScene:draw()
    self.background:draw()
    
    for key, game_object in ipairs(self.scenario_game_objects) do
        scenario_game_object:draw()
    end

    for key, target in ipairs(self.targets) do
        target:draw()
    end

    self.game_hud:draw()
end

return GameStageScene