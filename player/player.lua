player = {
 pos=vec2d(60,60),
 speed_max=2,
 direction=vec2d(0,0),
 spr_id=3,
}
function player:_init()
 return self
end

function player:draw()
 local frame, pos = flr(t()/2*30), self.pos
 local reflect = self.spr_id == 4 and self.direction.x < 0
 spr(self.spr_id, pos.x, pos.y, 1, 1, reflect)
 spr(19 + frame % 2, pos.x, pos.y + 8)
end

function player:update()
 self.spr_id=3
 
 self.direction *=.84
 local dir = self.direction
 
 if (btn(0)) dir.x=mid(1, -1, dir.x-.2) 
 if (btn(1)) dir.x=mid(1, -1, dir.x+.2) 
 if (btn(2)) dir.y=mid(1, -1, dir.y-.2) 
 if (btn(3)) dir.y=mid(1, -1, dir.y+.2) 

 if abs(dir.x) == abs(dir.y) and dir.x~=0 and dir.y~=0 then
  dir *=.707
 end

 if (dir.x> .1 or dir.x< -.1) then self.spr_id=4 else self.spr_id=3 end
 self.pos+=dir*self.speed_max
 return self
end

