local Background = require("scr.modules.Background")
local Cage = require("scr.modules.Cage")
local GameObject = require("scr.modules.GameObject")
local GameState = require("scr.modules.GameState")
local Vector = require("scr.modules.Vector")


local GameConfiguration = require("scr.controllers.GameConfiguration")
local GameHud = require("scr.controllers.GameHud")
local Player = require("scr.controllers.Player")
local SpawnerPigeons = require("scr.controllers.SpawnerPigeons")

local GameOverScreen = require("scr.screens.GameOverScreen")

-- Meta class
local GameController = {}
GameController.__index = GameController

-- 
 -- 
 -- @param game_configuration (table:Vector) referance pour le controlateur du jeu
function GameController.new(game_configuration)
    local o = {} 
    
    o.game_configuration = game_configuration
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
    o.spawner_pigeons = SpawnerPigeons.new(o.game_configuration)
    o.pigeons = o.spawner_pigeons:spwan()
    

    o.player = Player.new(o)
    o.cage = Cage.new(Vector.new(300, 450), o.game_configuration.pigeon_width, o.game_configuration.pigeon_height);
    o.timer = o.game_configuration.timer_start
    o.miss_click = 0
    

    o.game_over_screen = GameOverScreen.new(o)

    setmetatable(o, GameController)     

    return o
end

---------------------------------------------------------------
--  UPDATE
---------------------------------------------------------------
function GameController:update(dt)

    if isStateRun() then
        self:run(dt)
    end
    
    self.player:update(dt)
end

function GameController:run(dt)
    self.background:update(dt)
    self.game_hud:update(dt)

    for key, scenario_game_object in ipairs(self.scenario_game_objects) do
        scenario_game_object:update(dt)
    end

    for key, pigeon in ipairs(self.pigeons) do
        pigeon:update(dt)
    end

    self.timer = self.timer - dt;

    if self.timer <= 0 then
        self.timer = 0
        game_state = GameState:stateGameOver()
    end
end


function GameController:tryAndGetPigeon(point)
    if isStateRun() then
        local pigeons = self:getAllPigionsInPoint(point)

        if #pigeons > 0 then
            local pigeon = pigeons[1]
            pigeon = table.remove(self.pigeons, pigeon.index)
            self.cage:addPiegon(pigeon)
        else
            self.miss_click = self.miss_click + 1
        end

        if #self.pigeons == 0 then
            self:newLevel()
        end
    end
end

function GameController:newLevel()
    self.game_configuration.level = self.game_configuration.level + 1
    self.pigeons = self.spawner_pigeons:spwan()
end

-- @param point (table: Vector) : point de collision
function GameController:getAllPigionsInPoint(point)
    local pigeons_collided = {}
    local size = 0

    for key, pigeon in ipairs(self.pigeons) do
        if pigeon:isCollide(point) then
            size = size + 1
            pigeons_collided[size] = pigeon
        end
    end

    return pigeons_collided
end

function GameController:getFinalScore()
    local score_pigeon = #self.cage.pigeons * self.game_configuration.pigeon_value
    local score_miss = self.miss_click * self.game_configuration.miss_value
    return score_pigeon - score_miss
end

---------------------------------------------------------------
--  DRAW
---------------------------------------------------------------
function GameController:draw()
    self:drawStageScreen()

    if isStateGameOver() then
        self:drawGameOverScreen()
    end

    self.player:draw()
    --
    local bounds_horizontal = self.game_configuration.limit_horizontal
    local bounds_vertical = self.game_configuration.limit_vertical
    local width =  bounds_horizontal.y - bounds_horizontal.x
    local height = bounds_vertical.y - bounds_vertical.x
    -- love.graphics.rectangle("line", bounds_horizontal.x, bounds_vertical.x, width, height)
end

function GameController:drawStageScreen()
    self.background:draw()

    for key, scenario_game_object in ipairs(self.scenario_game_objects) do
        scenario_game_object:draw()
    end

    self.cage:draw()

    for key, pigeon in ipairs(self.pigeons) do
        pigeon:draw()
    end

    self.game_hud:draw()
end

function GameController:drawGameOverScreen()
    self.game_over_screen:draw()
end

return GameController