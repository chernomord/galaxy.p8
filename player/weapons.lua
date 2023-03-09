bullet={
 type='bullet',
 vel=4,
 collide=true,
 is_destroyed=false,
}
bullet.__index=bullet

function bullet:create(v_pos)
 local o={pos=v_pos,vec=vec2d(0,-1)}
 sfx(0)
 return setmetatable(o, self)
end

function bullet:draw()
 spr(2,self.pos.x,self.pos.y)
end

function bullet:update()
 self.pos += self.vec*self.vel
end

function bullet:to_destroy()
 return self.pos.y < -8 or self.is_destroyed
end

function bullet:before_destroy()
end

function bullet:hit_by(entity)
 self.is_destroyed = true
end