 -- Animation controller pour un GameObject
 local Animation = {}
 Animation.__index = Animation
 
 ---------------------------------------------------------------
 --  NEW 
 ---------------------------------------------------------------
 -- @param game_object (table:GameObject) referance du game object
 -- @param scr_sprite_sheet (string) url pour le sprite sheet
 -- @param width (number) width de chaque sprite animation
 -- @param height (number) height de chaque sprite animation
 -- @param duration (number) duration de chaque animation
 function Animation.new(game_object, scr_sprite_sheet, width, height, duration)
    local o = {} 
    setmetatable(o, Animation) 
    o.game_object = game_object
    o.sprite_sheet = love.graphics.newImage(scr_sprite_sheet)
    o.quads = {}
    o.duration = duration or 1
    o.currentTime = 0
    o.sprit_index = 2
    o.angle = 0

    -- charger les sprites
    for x = 0, o.sprite_sheet:getWidth() - width, width do
        for y = 0, o.sprite_sheet:getHeight() - height, height do
            table.insert(o.quads, love.graphics.newQuad(x, y, width, height, o.sprite_sheet:getDimensions()))
        end
    end

    return o
 end

---------------------------------------------------------------
--  UPDATE
---------------------------------------------------------------
function Animation:update(dt)
    self.currentTime = self.currentTime + dt

    if self.currentTime >= self.duration then
        self.currentTime = self.currentTime - self.duration
    end
    
    self.sprit_index = math.floor(self.currentTime / self.duration * #self.quads) + 1
    self.angle = self.game_object.direction:angleInRadians()
end


---------------------------------------------------------------
--  DRAW
---------------------------------------------------------------
function Animation:draw()
    --love.graphics.draw(self.sprite_sheet, self.quads[self.sprit_index], 0, 0, 0, 4)
    love.graphics.draw(self.sprite_sheet, self.quads[self.sprit_index], self.game_object.position.x, self.game_object.position.y, -self.angle, 1)
end

return Animation