bullets={}
last_bull_t=0
state={
	player={}
}

entities = {}

function check_coll(pos1, pos2, w1, w2)
	return (
		pos1.x < pos2.x + w2 and
		pos2.x < pos1.x + w1 and
		pos1.y < pos2.y + w2 and
		pos2.y < pos1.y + w1
	)
end

function _init()
	log('init', true)
	state.player = player:_init()
	init_rocks()
	init_stars()
end

function _draw()
	cls(0)
	draw_stars()
	for ent in all(entities) do
  ent:draw()
 end

	state.player:draw()
end

function _update()
	state.player:update()
	if (btn(4) and last_bull_t < t() - .25) then
		local bul_pos = state.player.pos:copy()
		local blt1=bullet:create(bul_pos)
		last_bull_t=t()
		add(entities,blt1)
	end
	update_stars()

	for ent in all(entities) do 
  ent:update()

		if (ent.collide) then
			for sub_ent in all(entities) do 
				local did_collide = sub_ent.collide and check_coll(ent.pos, sub_ent.pos, 8, 8)
				if (did_collide and ent.type != sub_ent.type) then
					ent:hit_by(sub_ent)
					sub_ent:hit_by(ent)
				end
			end
		end

  if ent:to_destroy() then
			ent:before_destroy()
   del(entities, ent)
  end
 end

end