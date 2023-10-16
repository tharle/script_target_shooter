local GameStageScene = require("scr.scenes.GameStageScene")
local GameController = require("scr.controllers.GameController")

-- Executable
-- copy /b love.exe+Mygame.love MyGame.exe


-- require("scr.modules.Target")

---------------------------------------------------------------
--  LOAD
---------------------------------------------------------------

function  love.load()
    game_controller = GameController.new();
    game_stage_scene = GameStageScene.new(game_controller)
end

---------------------------------------------------------------
--  UPDATE
---------------------------------------------------------------
function love.update(dt)
    game_stage_scene:update(dt)
end

---------------------------------------------------------------
--  DRAW
---------------------------------------------------------------
function love.draw()
    game_stage_scene:draw()
end