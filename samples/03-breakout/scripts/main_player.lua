local PlayerBehaviour = PlayerBehaviour or {}
local Data = Data or {}
local sg
local pw
local playerUnit = nil

function PlayerBehaviour.spawned(world, units)
	playerUnit = units[1]
	sg = World.scene_graph(world)
	pw = World.physics_world(world)
end

function PlayerBehaviour.unspawned(world, units)
end

function PlayerBehaviour.update(world, dt)
	-- Player movement
	local function swap_yz(vector3_xy)
		return Vector3(vector3_xy.x, 0, vector3_xy.y)
	end

	-- Read direction from joypad
	local pad_dir = Pad1.axis(Pad1.axis_id("left"))
	-- Add keyboard contribution
	if pad_dir.x == 0.0 and pad_dir.y == 0.0 then
		pad_dir.x = pad_dir.x + Keyboard.button(Keyboard.button_id("right")) - Keyboard.button(Keyboard.button_id("left"))
		--pad_dir.y = pad_dir.y + Keyboard.button(Keyboard.button_id("w")) - Keyboard.button(Keyboard.button_id("s"))
	end
	-- Compute new player position
	local player_speed = 10
	local player_position = SceneGraph.local_position(sg, playerUnit)
	local platform_width = 485
	local delta_x =  swap_yz(pad_dir)*player_speed*dt

	hit_left, c, n, t, unit, actor_left = PhysicsWorld.cast_ray(pw, player_position, Vector3(-1, 0, 0), platform_width/2/32*platform_scale)
	hit_right, c, n, t, unit, actor_right = PhysicsWorld.cast_ray(pw, player_position, Vector3(1, 0, 0), platform_width/2/32*platform_scale)

	if hit_left and delta_x.x < 0 then
		print("hit_left")
		delta_x = Vector3(0, 0, 0)
	end

	if hit_right and delta_x.x > 0 then
		print("hit_right")
		delta_x = Vector3(0, 0, 0)
	end

	SceneGraph.set_local_position(sg, playerUnit, player_position + delta_x)

end

function PlayerBehaviour.collision_begin(touched, touching, actor, position, normal, distance)
	--print("Collision begin")
end

function PlayerBehaviour.collision(touched, touching, actor, position, normal, distance)
	--print("Collision")
	-- print(Vector3.elements(position))
	-- print(Vector3.elements(normal))
	-- print(distance)
end

return PlayerBehaviour
