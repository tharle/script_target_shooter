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
    local terrain = GameObject.new("assets/sprites/objects/gras_eath_all.png", Vector.new(0, 565))
    
    o.scenario_game_objects = { 
        tree_1, 
        tree_2,
        terrain
    }

    local target_1 = Target.new(
        --"assets/target.png",  -- url 
        nil,
        Vector.new(220, 220), -- postion
        Vector:Right():addtion(Vector:Down()), -- direction
        150, -- velocity
        Vector.new(100, 700), -- limit horizontal
        Vector.new(100, 500) -- limit vertical
    )
    target_1:setAnimation("assets/sprites/objects/pigeons/pigeons_1_fly.png", 64, 64, 0.5)
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
       -- print "JEU DANS GAME OVER."
    else -- GameState:stateRun() or autre game state iconnu
        self:run(dt)
    end
end

function GameStageScene:run(dt)
    self.background:update(dt)

    for key, scenario_game_object in ipairs(self.scenario_game_objects) do
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
    self:drawStageScreen()

    if game_controller:equalsGameState(GameState:stateMenu()) then
        self:drawMenuScreen()
    elseif game_controller:equalsGameState(GameState:stateGameOver()) then
        self:drawGameOverScreen()
    end
end

function GameStageScene:drawStageScreen()
    self.background:draw()
    
    for key, scenario_game_object in ipairs(self.scenario_game_objects) do
        scenario_game_object:draw()
    end

    for key, target in ipairs(self.targets) do
        target:draw()
    end

   self.game_hud:draw()
end

function GameStageScene:drawMenuScreen()
end

function GameStageScene:drawGameOverScreen()
end

return GameStageScene