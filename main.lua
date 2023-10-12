-- Executable
-- copy /b love.exe+Mygame.love MyGame.exe
local Vector = require("scr.modules.Vector")
local GameObject = require("scr.modules.GameObject")
local Target = require("scr.modules.Target")

-- require("scr.modules.Target")

---------------------------------------------------------------
--  LOAD
---------------------------------------------------------------

GAME_STATE_RUN = 0
GAME_STATE_MENU = 1
GAME_STATE_OVER = 2

function  love.load()
    target_1 = GameObject.new("assets/target.png", Vector.new(50, 50))
    target_1:setLimitHorizontal(Vector.new(0, 800))
    target_1:setLimitVertical(Vector.new(0, 600))
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