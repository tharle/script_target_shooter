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
    o.background = GameObject.new("assets/sprites/HUD/menu_background.png", o.position)
    
    o.title_font = love.graphics.newFont("assets/fonts/gamer.ttf", 40) -- load de font personalizé
    o.body_font = love.graphics.newFont("assets/fonts/gamer.ttf", 30) -- load de font personalizé

    o.pigeon_score = GameObject.new()
    o.pigeon_score.position = Vector.new(330, 200)
    local pigeon_width = 46
    local pigeon_height = 30
    local velocity_animation = 0.5
    o.pigeon_score:setAnimation("assets/sprites/objects/pigeons/pigeon_wink.png", pigeon_width, pigeon_height, velocity_animation)


    setmetatable(o, GameOverScreen)

    return o
end

function GameOverScreen:draw()
    self.background:draw()
    love.graphics.setFont(self.title_font)
    love.graphics.print("- Game Over - ", self.position.x + 100, self.position.y + 10) 

    self.pigeon_score:draw()
    love.graphics.print("x   "..#self.game_controller.cage.pigeons, 400, 200)

    love.graphics.print("Miss", self.position.x + 100, 270) 
    love.graphics.print("x   "..self.game_controller.miss_click,  400, 270) 

    love.graphics.setFont(self.body_font)
    love.graphics.rectangle("line", self.position.x + 50, self.position.y + 225, 320, 1)
    love.graphics.print("Final Score:", self.position.x + 70, self.position.y + 230) 
    love.graphics.print(self.game_controller:getFinalScore(), self.position.x + 300, self.position.y + 230) 

    


    love.graphics.print("- Press any key to Menu -", 270, 400)
end

return GameOverScreen