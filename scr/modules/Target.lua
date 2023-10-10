-- Meta class
Target = {}

 -- Derived class method new
 -- @param scr c'est le chemain pour le le sprite
 -- @param position est une variable du type Vector
function Target:new(src_sprite, position)
    local o = GameObject:new(src_sprite, position)
    setmetatable(o,self)     
    self.__index = self

    return o
end