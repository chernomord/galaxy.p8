blast={
 type='blast',
 vel=0,
 collide=false,
 is_destroyed=false,
 t_created=0,
}
blast.__index = blast


function blast:create(pos2d, vec2d, vel)
 local pos, vec = pos2d:copy(), vec2d:copy()
 local sparks = {}
 for i=1,18 do
  local x,y = rnd(4) - 2, rnd(4) - 2
  local dx, dy = x, y
  local vel = rnd(3)
  add(sparks, {x=x, y=y, dx=dx, dy=dy, vel=vel})
 end

 local o ={ 
  pos=pos,
  vec=vec,
  vel=vel,
  t_created=t(),
  sparks=sparks,
 }

 return setmetatable(o, self)
end

function blast:before_destroy()
end

function blast:to_destroy()
 return t() - self.t_created > .5
end

function blast:draw()
 for spark in all(self.sparks) do 
  local x,y = self.pos.x + spark.x + 4, self.pos.y + spark.y + 4
  spr(38, x, y)
 end
 
end

function blast:update()
 self.pos += self.vec * self.vel
 for spark in all(self.sparks) do 
  spark.x += spark.dx
  spark.y += spark.dy
  log(spark.x .. ' ' .. spark.y)
 end
 log('END')
end

