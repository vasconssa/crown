local Behavior = Behavior or {}
local Data = Data or {}
local sg
local playerUnit = nil

function Behavior.spawned(world, units)
	playerUnit = units[1]
	sg = World.scene_graph(world)
end

function Behavior.unspawned(world, units)
end

function Behavior.update(world, dt)

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
	SceneGraph.set_local_position(sg, playerUnit, player_position + swap_yz(pad_dir)*player_speed*dt)
end

function Behavior.collision_begin(touched, touching, actor, position, normal, distance)
	--print("Collision begin")
end

function Behavior.collision(touched, touching, actor, position, normal, distance)
	--print("Collision")
	-- print(Vector3.elements(position))
	-- print(Vector3.elements(normal))
	-- print(distance)
end

return Behavior
