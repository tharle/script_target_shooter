local Vector = require("scr.modules.Vector")

-- Meta class
local GameHud = {}
GameHud.__index = GameHud

-- Classe pour afficher et controller le HUD 
 -- @param game_controller (table:Vector) referance pour le controlateur du jeu
function GameHud.new(game_controller)
    local o = {} 
    setmetatable(o, GameHud)

    o.game_controller = game_controller
    o.background_color = {0, 0, 0, 1} -- black
    o.font_color = {1, 1, 1, 1} -- white
    o.font = love.graphics.newFont("assets/fonts/gamer.ttf", 40) -- load de font personalizé

    o.position_score = Vector.new(o.game_controller.resolution.x -150, 20)
    o.position_timer = Vector.new(o.game_controller.resolution.x/2 - 25, 20)
    -- Balas

    return o
end


---------------------------------------------------------------
--  DRAW
---------------------------------------------------------------
function GameHud:draw()
    love.graphics.setColor(self.background_color);
    love.graphics.rectangle( "fill", 0, 0, self.game_controller.resolution.x, 60 )

    love.graphics.setFont(self.font) -- set le font pour être utilisé
    love.graphics.setColor(self.font_color);
    love.graphics.print("score: "..self.game_controller.score, self.position_score.x, self.position_score.y) 
    local timer = math.floor(self.game_controller.timer)
    love.graphics.print(timer, self.position_timer.x, self.position_timer.y)

    --local invisible_color = {1, 1, 1, 0} -- pour ne pas toucher aux sprites
    --love.graphics.setColor(invisible_color)
end

return GameHud


