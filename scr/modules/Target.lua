-- Meta class
local GameObject = require("scr.modules.GameObject")

 -- Derived class method new
 -- @param scr c'est le chemain pour le le sprite
 -- @param position est une variable du type Vector

local Target = setmetatable({}, {__index = GameObject})
Target.__index = Target
function Target.new(src_sprite, position)
    local o = setmetatable(GameObject.new(src_sprite, position), Target)
    return o
end

return Target