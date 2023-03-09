stars = {}

local st_ext_spd = 0

function init_stars()
	for i=1,80 do
		local nid = i/80
		local s = nid * nid * 2 + rnd(1)
		add(stars,{
			x=rnd(128),
			y=rnd(128),
			s=s,
			vel=.2 + s*.8,
		})
	end 
end

function update_stars()
	if (btn(5)) then
		st_ext_spd = mid(0, st_ext_spd + .1, 10)
	else
		st_ext_spd = mid(0, st_ext_spd - .1, 10)
	end
	for st in all(stars) do
		st.vel =  st.vel + st_ext_spd/10
  st.y += st.vel
  if st.y >= 128 then
   st.y = -10
   st.x=rnd(128)
			st.vel=st.s
  end
 end
end

function draw_stars()
	for st in all(stars) do
		local col = 1
		local vel = st.vel
  if (vel > 2) then col = 13 elseif (vel > 5) then col = 6 end
		color(col)
		local length = st.vel*(1+st_ext_spd)

		line(st.x, st.y, st.x, st.y+length)
 end
end