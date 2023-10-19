local Vector = require("scr.modules.Vector")
local PigeonFactory = require("scr.controllers.PigeonFactory")
-- Meta class
local SpawnerPigeons = {}
SpawnerPigeons.__index = SpawnerPigeons

-- 
 -- 
 -- @param game_configuration (table:Vector) referance pour le controlateur du jeu
function SpawnerPigeons.new(game_configuration)
    local o = {}
    setmetatable(o, SpawnerPigeons)

    o.game_configuration = game_configuration
    o.pigeon_factory = PigeonFactory.new(o.game_configuration)

    return o
end

function SpawnerPigeons:spwan(amount)
    local new_pigeons = {}
    local amount_pigeons = self.game_configuration.pigeons_amount_by_level * self.game_configuration.level
    for i=1, amount_pigeons do
        local new_pigeon = self.pigeon_factory:create()
        new_pigeons[#new_pigeons + 1] = new_pigeon
    end

    return new_pigeons
end

return SpawnerPigeons