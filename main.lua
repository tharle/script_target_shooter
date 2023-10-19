local MenuScreen = require("scr.screens.MenuScreen")
local GameController = require("scr.controllers.GameController")
local GameConfiguration = require("scr.controllers.GameConfiguration")
local GameState = require("scr.modules.GameState")

-- Executable
-- copy /b love.exe+Mygame.love MyGame.exe


-- require("scr.modules.Pigeon")

---------------------------------------------------------------
--  LOAD
---------------------------------------------------------------

function  love.load()
    game_state = GameState:stateMenu()
    menu_screen = MenuScreen.new()
    startGame()
end

function startGame()
    game_configuration = GameConfiguration.new()
    game_controller = GameController.new(game_configuration)
end

---------------------------------------------------------------
--  UPDATE
---------------------------------------------------------------
function love.update(dt)
    game_controller:update(dt) -- game controller fait son propre traitement

    if isStateMenu() then
        menu_screen:update(dt)
    end
end


function isStateRun()
    return game_state ==  GameState:stateRun()
end

function isStateMenu()
    return game_state ==  GameState:stateMenu()
end

function isStateGameOver()
    return game_state ==  GameState:stateGameOver()
end

---------------------------------------------------------------
--  KEY PRESSED
---------------------------------------------------------------
function love.keypressed(key, scancode, isrepeat)
    if isStateMenu() then
        game_state = GameState:stateRun()
        startGame()
    end
end

---------------------------------------------------------------
--  DRAW
---------------------------------------------------------------
function love.draw()
    if isStateMenu() then
        menu_screen:draw()
    else
        game_controller:draw()
    end

end