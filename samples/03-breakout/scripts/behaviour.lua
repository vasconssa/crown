local BallBehaviour = BallBehaviour or {}
local Data = Data or {}

function BallBehaviour.spawned(world, units)
	if Data[world] == nil then
		Data[world] = {}
	end
	print("num unit: ")
	print(#units)

	for uu = 1, #units do
		local unit = units[uu]

		if Data[world][unit] == nil then
			Data[world][unit] = { enemy_vel = Vector3Box() }
		end

		local sg = World.scene_graph(world)
		local rw = World.render_world(world)
		local pos = SceneGraph.local_position(sg, unit)
		-- print(Vector3.elements(position))
	end
end

function BallBehaviour.unspawned(world, units)
end

function BallBehaviour.update(world, dt)
end

function BallBehaviour.collision_begin(touched, touching, actor, position, normal, distance)
end

function BallBehaviour.collision(touched, touching, actor, position, normal, distance)
	--print("Collision")
	-- print(Vector3.elements(position))
	-- print(Vector3.elements(normal))
	-- print(distance)
end

return BallBehaviour
