local Behavior = Behavior or {}
local Data = Data or {}

function Behavior.spawned(world, units)
	if Data[world] == nil then
		Data[world] = {}
	end

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

function Behavior.unspawned(world, units)
end

function Behavior.update(world, dt)
end

function Behavior.collision_begin(touched, touching, actor, position, normal, distance)
	--print("Collision begin")
end

function Behavior.collision(touched, touching, actor, position, normal, distance)
	print("Collision")
	-- print(Vector3.elements(position))
	-- print(Vector3.elements(normal))
	-- print(distance)
end

return Behavior
