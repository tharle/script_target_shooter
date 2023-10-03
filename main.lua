-- Executable
-- copy /b love.exe+Mygame.love MyGame.exe
require("scr.modules.Vector")
require("scr.modules.Target")

---------------------------------------------------------------
--  LOAD
---------------------------------------------------------------

GAME_STATE_RUN = 0
GAME_STATE_MENU = 1
GAME_STATE_OVER = 2

function  love.load()
    target_1 = Target:new("assets/target.png", Vector:new(50, 50))
end

---------------------------------------------------------------
--  UPDATE
---------------------------------------------------------------
function love.update(dt)
    calculerTargetPosition(dt)
end

-- calculer la position de target
function calculerTargetPosition(dt)
    target_1:move(dt)
end


---------------------------------------------------------------
--  DRAW
---------------------------------------------------------------
function love.draw()
    target_1:draw()
end