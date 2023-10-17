-- Meta class
local Background = require("scr.modules.Background")
local GameObject = require("scr.modules.GameObject")
local GameState = require("scr.modules.GameState")
local Target = require("scr.modules.Target")
local Vector = require("scr.modules.Vector")


local GameConfiguration = require("scr.controllers.GameConfiguration")
local GameHud = require("scr.controllers.GameHud")
local Player = require("scr.controllers.Player")

 -- 
 -- 
 -- @param game_configuration (table:Vector) referance pour le controlateur du jeu
local GameController = {}
GameController.__index = GameController
function GameController.new()
    local o = {} 
    
    o.game_configuration = GameConfiguration.new();
    o.game_hud = GameHud.new(o)
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

    o.player = Player.new(o)
    o.score = 0
    o.timer = o.game_configuration.timer_start
    o.game_state = GameState:stateRun()
    o.gun_magazine = o.game_configuration.gun_magazine_size

    setmetatable(o, GameController)     

    return o
end

---------------------------------------------------------------
--  UPDATE
---------------------------------------------------------------
function GameController:update(dt)

    if self:isStateMenu() then
        print "JEU DANS MENU."
    elseif self:isStateGameOver() then
       -- print "JEU DANS GAME OVER."
    else -- GameState:stateRun() or autre game state iconnu
        self:run(dt)
    end
    
    self.player:update(dt)
end

function GameController:run(dt)
    self.background:update(dt)

    for key, scenario_game_object in ipairs(self.scenario_game_objects) do
        scenario_game_object:update(dt)
    end

    for key, target in ipairs(self.targets) do
        target:update(dt)
    end

    self.timer = self.timer - dt;

    if self.timer <= 0 then
        self.timer = 0
        self.game_state = GameState:stateGameOver()
    end
end

function GameController:isStateRun()
    return self.game_state ==  GameState:stateRun()
end

function GameController:isStateMenu()
    return self.game_state ==  GameState:stateMenu()
end

function GameController:isStateGameOver()
    return self.game_state ==  GameState:stateGameOver()
end



-- Retourne toute les objets qui sont possible de collider dans le point 
 -- @param point (table: Vector) : point de collision
function GameController:getAllGameObjetCollided(point)
    local game_objects = {}

    if self:isStateRun() then
        game_objects = self:getAllPigionsInPoint(point)
    end

    return game_objects
end


-- @param point (table: Vector) : point de collision
function getAllPigionsInPoint(point)
    local pigeons_collided = {}
    local size = 0
    for key, pigeons in ipairs(self.targets) do
        if pigeon:isCollide(point) then
            size = size + 1
            pigeons_collided[size] = pigeons
        end
    end

    return pigeons_collided
end 

---------------------------------------------------------------
--  DRAW
---------------------------------------------------------------
function GameController:draw()
    self:drawStageScreen()

    if self:isStateMenu() then
        self:drawMenuScreen()
    elseif self:isStateGameOver() then
        self:drawGameOverScreen()
    end

    self.player:draw()
end

function GameController:drawStageScreen()
    self.background:draw()
    
    for key, scenario_game_object in ipairs(self.scenario_game_objects) do
        scenario_game_object:draw()
    end

    for key, target in ipairs(self.targets) do
        target:draw()
    end

   self.game_hud:draw()
end

function GameController:drawMenuScreen()
end

function GameController:drawGameOverScreen()
end

return GameController