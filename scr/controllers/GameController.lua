local Background = require("scr.modules.Background")
local Cage = require("scr.modules.Cage")
local GameObject = require("scr.modules.GameObject")
local GameState = require("scr.modules.GameState")
local Pigeon = require("scr.modules.Pigeon")
local Vector = require("scr.modules.Vector")


local GameConfiguration = require("scr.controllers.GameConfiguration")
local GameHud = require("scr.controllers.GameHud")
local Player = require("scr.controllers.Player")

-- Meta class
local GameController = {}
GameController.__index = GameController

-- 
 -- 
 -- @param game_configuration (table:Vector) referance pour le controlateur du jeu
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

    local pigeon_width = 44
    local pigeon_height = 36
    local velocity_animation = 0.5
    local pigeon_1 = Pigeon.new(
        1, -- index
        Vector.new(220, 220), -- postion
        Vector:Right():addtion(Vector:Down()), -- direction
        200, -- velocity
        Vector.new(100, 700), -- limit horizontal
        Vector.new(100, 500) -- limit vertical
    )
    pigeon_1:setAnimation("assets/sprites/objects/pigeons/pigeon_fly_1.png", pigeon_width, pigeon_height, velocity_animation)

    
    local pigeon_2 = Pigeon.new(
        1, -- index
        Vector.new(100, 150), -- postion
        Vector:Left():addtion(Vector:Down()), -- direction
        100, -- velocity
        Vector.new(100, 700), -- limit horizontal
        Vector.new(100, 500) -- limit vertical
    )
    pigeon_2:setAnimation("assets/sprites/objects/pigeons/pigeon_fly_1.png", pigeon_width, pigeon_height, velocity_animation)
    o.pigeons = {pigeon_1, pigeon_2}

    o.player = Player.new(o)
    o.cage = Cage.new(Vector.new(300, 450), pigeon_width, pigeon_height);
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
       -- print "JEU DANS MENU."
    elseif self:isStateGameOver() then
       -- print "JEU DANS GAME OVER."
    else -- GameState:stateRun() or autre game state iconnu
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


function GameController:tryAndGetPigeon(point)
    if self:isStateRun() then
        local pigeons = self:getAllPigionsInPoint(point)

        if #pigeons > 0 then
            local pigeon = pigeons[1]
            pigeon = table.remove(self.pigeons, pigeon.index)
            self.cage:addPiegon(pigeon)
        end
    end
end

-- @param point (table: Vector) : point de collision
function GameController:getAllPigionsInPoint(point)
    local pigeons_collided = {}
    local size = 0

    for key, pigeon in ipairs(self.pigeons) do
        print("Pigeon ["..key.."] -> "..pigeon.position:toString())
        if pigeon:isCollide(point) then
            size = size + 1
            pigeons_collided[size] = pigeon
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

    self.cage:draw()

    for key, pigeon in ipairs(self.pigeons) do
        pigeon:draw()
    end

   self.game_hud:draw()
end

function GameController:drawMenuScreen()
end

function GameController:drawGameOverScreen()
end

return GameController