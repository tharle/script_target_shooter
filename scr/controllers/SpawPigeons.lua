-- Meta class
local SpawPigeons = {}
SpawPigeons.__index = SpawPigeons

-- 
 -- 
 -- @param game_configuration (table:Vector) referance pour le controlateur du jeu
function SpawPigeons.new()
    local o = {}
    setmetatable(o, SpawPigeons)

    return o
end


return SpawPigeons