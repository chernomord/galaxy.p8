rock={
 type='rock',
 vel=1,
 size=1,
 collide=true,
 is_destroyed=false,
}
rock.__index=rock

function rock:create(x,y, dx,dy)
 local o={pos=vec2d(x,y),vec=vec2d(dx,dy)}
 self.vel = 1 + rnd(4)
 o.width = self.size * 8
 return setmetatable(o, self)
end

function rock:draw()
 local frame = flr(t()/self.vel*10) % 4
 spr(34+frame,self.pos.x,self.pos.y)
end

function rock:update()
 self.pos += self.vec * self.vel
 if (self:to_reset()) then 
  self.pos.y = -8 
  self.pos.x = rnd(120) 
  self.vec.x = rnd(.2) -.1
  self.vel = rnd(4) + 1
 end
end

function rock:to_reset()
 local pos = self.pos
 return (pos.y > 128 or pos.x > 128 or pos.x < self.size * -8)
end

function rock:to_destroy()
 return self.is_destroyed
end

function rock:hit_by(ent)
 if (ent.type == 'bullet') self.is_destroyed = true
end

function rock:before_destroy()
 local blast = blast:create(self.pos, self.vec, self.vel)
 add(entities, blast)
end

function init_rocks()
 for i=1,6 do
  local x, dx, dy = rnd(120), rnd(.2) - .1, .5 + rnd(.5)
  local item = rock:create(x,-8, dx, dy)
  add(entities, item)
 end
end