local GameController = require("scr.controllers.GameController")

-- Executable
-- copy /b love.exe+Mygame.love MyGame.exe


-- require("scr.modules.Target")

---------------------------------------------------------------
--  LOAD
---------------------------------------------------------------

function  love.load()
    game_controller = GameController.new()
end

---------------------------------------------------------------
--  UPDATE
---------------------------------------------------------------
function love.update(dt)
    game_controller:update(dt)
end

---------------------------------------------------------------
--  DRAW
---------------------------------------------------------------
function love.draw()
    game_controller:draw()
end