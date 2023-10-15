-- Executable
-- copy /b love.exe+Mygame.love MyGame.exe
local Vector = require("scr.modules.Vector")
local GameObject = require("scr.modules.GameObject")
local Target = require("scr.modules.Target")
local Background = require("scr.modules.Background")

-- require("scr.modules.Target")

---------------------------------------------------------------
--  LOAD
---------------------------------------------------------------
scene_game_objects = {}

function  love.load()
    local target_1 = Target.new(
        "assets/target.png",  -- url 
        Vector.new(220, 220), -- postion
        Vector:Right():addtion(Vector:Down()), -- direction
        150, -- velocity
        Vector.new(100, 700), -- limit horizontal
        Vector.new(100, 500) -- limit vertical
    )

    local background_scene = Background.new()

    scene_game_objects = {background_scene, target_1}
end

---------------------------------------------------------------
--  UPDATE
---------------------------------------------------------------
function love.update(dt)
    for key, game_object in ipairs(scene_game_objects) do
        game_object:update(dt)
    end
end

---------------------------------------------------------------
--  DRAW
---------------------------------------------------------------
function love.draw()
    for key, game_object in ipairs(scene_game_objects) do
        game_object:draw(dt)
    end
end