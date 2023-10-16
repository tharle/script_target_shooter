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

    local tree_1 = GameObject.new("assets/sprites/objects/tree_2.png", Vector.new(25, 365))
    local tree_2 = GameObject.new("assets/sprites/objects/tree_1.png", Vector.new(550, 365))

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

    scene_game_objects = {
        background_scene, 
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