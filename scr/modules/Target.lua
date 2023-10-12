-- Meta class
local GameObject = require("scr.modules.GameObject")

 -- Derived class method new
 -- @param scr c'est le chemain pour le le sprite
 -- @param position est une variable du type Vector

local Target = {}
Target.__index = Target
function Target.new(src_sprite, position)
    local o = GameObject.new(src_sprite, position)
    setmetatable(o, Target)
    return o
end

return Target