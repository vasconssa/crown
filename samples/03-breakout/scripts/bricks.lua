local Bricks = Bricks or {}
local Data = Data or {}
local wrd = nil
local destructible = {}
local clock = 0

function Bricks.spawned(world, units)
	wrd = world
	if Data[world] == nil then
		Data[world] = {}
	end
	un = units

	for uu = 1, #units do
		local unit = units[uu]

		if Data[world][unit] == nil then
			-- Store instance-specific data
			 print(unit)
			 Data[world][unit] = {}
			 Data[world][unit]["num_collisions"] = 0
		end

		-- Set sprite depth based on unit's position
		local sg = World.scene_graph(world)
		local rw = World.render_world(world)
		local pos = SceneGraph.local_position(sg, unit)
		--local depth = math.floor(1000 + (1000 - 32*pos.z))
		--RenderWorld.sprite_set_depth(rw, unit, depth)
	end
end

function Bricks.unspawned(world, units)
	-- Cleanup
	for uu = 1, #units do
		if Data[world][units] then
			--Data[world][units] = nil
		end
	end
end

function Bricks.update(world, dt)
	clock = clock + dt
    for i, unit in ipairs(destructible) do
		if clock - unit[2] > 1 then
			World.destroy_unit(GameBase.world, unit[1])
			destructible[i] = nil
		end
	end
end

function Bricks.collision_begin(touched, touching, actor, position, normal, distance)
	if touched == Game.ball then
		if (UnitManager.alive(touching)) then
			Data[wrd][touching]["num_collisions"] = Data[wrd][touching]["num_collisions"] + 1
			if Data[wrd][touching]["num_collisions"] == 1 then
				AnimationStateMachine.trigger(Game.sm, touching, "cracked")
			elseif Data[wrd][touching]["num_collisions"] == 2 then
				AnimationStateMachine.trigger(Game.sm, touching, "explode")
				local actor = PhysicsWorld.actor_instances(Game.pw, touching)
				PhysicsWorld.actor_disable_collision(Game.pw, actor)
				table.insert(destructible, {touching, clock})
			--elseif Data[wrd][touching]["num_collisions"] == 3 then
				--World.destroy_unit(GameBase.world, touching)
			end
		end
	end
end

function Bricks.collision(touched, touching, actor, position, normal, distance)
	--if touching == Game.ball then
		--print(touching)
		--UnitManager.destroy(touched)
	--end
	-- print(Vector3.elements(position))
	-- print(Vector3.elements(normal))
	-- print(distance)
end

return Bricks
