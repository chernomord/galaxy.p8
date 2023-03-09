local prototype={
 __add=function(a,b)
  return vec2d(a.x + b.x, a.y + b.y)
 end,

 __sub=function(a,b)
  return vec2d(a.x - b.x, a.y - b.y)
 end,

 __mul=function(a,b)
  if type(b) == "number" then
   return vec2d(a.x*b, a.y*b)
  elseif type(a) == "number" then
   return vec2d(a*b.x, a*b.y)
  end
  return a.x*b.x + a.y*b.y
 end,

 __eq=function(a,b)
  return a.x == b.x and a.y == b.y
 end,

 __tostring=function(a)
  return "(" .. a.x .. ", " .. a.y ..  ")"
 end
}
prototype.__index=prototype
function prototype:copy()
 return vec2d(self.x, self.y)
end

function vec2d(x,y)
 return setmetatable({x=x,y=y}, prototype)
end