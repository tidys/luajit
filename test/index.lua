print("123")
local a = 1;
a = 2;
print("A")
local b = a + 2;
print("b")

function a()

    print("a")
end

function b()
    print("b")
    a()
end

local class = {}
function class:say()
    print("class say")
end
b();

class:say()