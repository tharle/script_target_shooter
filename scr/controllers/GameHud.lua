local Vector = require("scr.modules.Vector")

-- Meta class
local GameHud = {}
GameHud.__index = GameHud

-- Classe pour afficher et controller le HUD 
 -- @param game_configuration (table:Vector) referance pour le controlateur du jeu
function GameHud.new(game_controller)
    local o = {} 
    setmetatable(o, GameHud)

    o.game_controller = game_controller
    o.background_color = {0, 0, 0, 1} -- black
    o.font_color = {1, 1, 1, 1} -- white
    o.font = love.graphics.newFont("assets/fonts/gamer.ttf", 40) -- load de font personalizé

    local hud_y = 10;
    local resolution = o.game_controller.game_configuration.resolution
    o.position_score = Vector.new(resolution.x -200, hud_y)
    o.position_timer = Vector.new(resolution.x/2 - 25, hud_y)
    o.position_gun_magazine = Vector.new(10, hud_y)
    -- Balas

    return o
end


---------------------------------------------------------------
--  DRAW
---------------------------------------------------------------
function GameHud:draw()
    local game_configuration = self.game_controller.game_configuration
    love.graphics.setColor(self.background_color);
    love.graphics.rectangle( "fill", 0, 0, self.game_controller.game_configuration.resolution.x, 60 )

    love.graphics.setFont(self.font) -- set le font pour être utilisé
    love.graphics.setColor(self.font_color);

    love.graphics.print("SCORE: "..self.game_controller.score, self.position_score.x, self.position_score.y) 
    
    local timer = math.floor(self.game_controller.timer)
    love.graphics.print(timer, self.position_timer.x, self.position_timer.y)

    love.graphics.print("SHOT: "..self.game_controller.gun_magazine, self.position_gun_magazine.x, self.position_gun_magazine.y)
    --local invisible_color = {1, 1, 1, 0} -- pour ne pas toucher aux sprites
    --love.graphics.setColor(invisible_color)
end

return GameHud


