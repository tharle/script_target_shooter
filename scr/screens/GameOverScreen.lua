local GameObject = require("scr.modules.GameObject")
local Vector = require("scr.modules.Vector")

-- Meta data
local GameOverScreen = {}
GameOverScreen.__index = GameOverScreen

---------------------------------------------------------------
--  NEW 
---------------------------------------------------------------
function GameOverScreen.new(game_controller)
    local o = {}
    o.game_controller = game_controller
    o.position = Vector.new(200, 100)
    o.background = GameObject.new("assets/sprites/HUD/game_over_background.png", o.position)
    
    o.title_font = love.graphics.newFont("assets/fonts/gamer.ttf", font_size) -- load de font personalizé
    o.body_font = love.graphics.newFont("assets/fonts/gamer.ttf", font_size) -- load de font personalizé

    o.pigeon_score = GameObject.new()
    o.pigeon_score.position = Vector.new(250, 250)
    local pigeon_width = 46
    local pigeon_height = 30
    local velocity_animation = 0.5
    o.pigeon_score:setAnimation("assets/sprites/objects/pigeons/pigeon_wink.png", pigeon_width, pigeon_height, velocity_animation)


    setmetatable(o, GameOverScreen)

    return o
end

function GameOverScreen:draw()
    self.background:draw()
    love.graphics.print("- Game Over - ", self.position.x + 100, self.position.y + 10) 

    self.pigeon_score:draw()
    love.graphics.print(".......................   "..#self.game_controller.cage.pigeons, 320, 250)


    love.graphics.print("Main menu", 330, 350)
end

return GameOverScreen