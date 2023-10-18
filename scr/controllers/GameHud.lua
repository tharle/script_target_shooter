local Vector = require("scr.modules.Vector")
local GameObject = require("scr.modules.GameObject")

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
    o.position_score = Vector.new(resolution.x -100, hud_y)
    o.position_timer = Vector.new(resolution.x/2 - 25, hud_y)

    o.pigeon_score = GameObject.new()
    o.pigeon_score.position = Vector.new(resolution.x -144, hud_y)
    local pigeon_width = 46
    local pigeon_height = 30
    local velocity_animation = 0.5
    o.pigeon_score:setAnimation("assets/sprites/objects/pigeons/pigeon_wink.png", pigeon_width, pigeon_height, velocity_animation)

    return o
end


---------------------------------------------------

function GameHud:update(dt)
    self.pigeon_score:draw(dt)-- animation
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

    self.pigeon_score:draw()
    love.graphics.print(" x "..#self.game_controller.cage.pigeons, self.position_score.x, self.position_score.y) 
    
    local timer = math.floor(self.game_controller.timer)
    love.graphics.print(timer, self.position_timer.x, self.position_timer.y)

    --local invisible_color = {1, 1, 1, 0} -- pour ne pas toucher aux sprites
    --love.graphics.setColor(invisible_color)
end

return GameHud


