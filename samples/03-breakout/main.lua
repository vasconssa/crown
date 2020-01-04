require "core/game/camera"
require "scripts/level_generator"

PIXELS_PER_METER=32

Game = Game or {}

Game = {
	pw = nil,
	rw = nil,
	sg = nil,
	sm = nil,
	camera = nil,
	player = nil,
	players = {},
    ball = nil,
    blocks = {},
	fullscreen = false
}


GameBase.game = Game
GameBase.game_level = "game"

function Game.level_loaded()
	Game.pw = World.physics_world(GameBase.world)
	Game.rw = World.render_world(GameBase.world)
	Game.sg = World.scene_graph(GameBase.world)
	Game.sm = World.animation_state_machine(GameBase.world)

	-- Spawn camera
	local camera_unit = World.spawn_unit(GameBase.world, "core/units/camera")
    -- set 2d camera
    device_width, device_heigth = Device.resolution()
	World.camera_set_orthographic_size(GameBase.world, camera_unit, device_heigth/2/PIXELS_PER_METER)
	World.camera_set_projection_type(GameBase.world, camera_unit, "orthographic")
	SceneGraph.set_local_position(Game.sg, camera_unit, Vector3(0, 8, 0))
	SceneGraph.set_local_rotation(Game.sg, camera_unit, Quaternion.from_axis_angle(Vector3.right(), 90*(math.pi/180.0)))

	GameBase.game_camera = camera_unit
    level1(GameBase.world)
    --PhysicsWorld.set_gravity(Game.pw, Vector3(0, 0, -1.0))
    playerActor = PhysicsWorld.actor_instances(Game.pw, Game.player)
    --print(PhysicsWorld.actor_is_kinematic(Game.pw, playerActor))
    --PhysicsWorld.enable_debug_drawing(Game.pw,true)
	delta = 0.0
	gui = World.create_screen_gui(GameBase.world)
end

function Game.update(dt)
	Gui.image (gui, Vector2(device_width - 250, device_heigth - 200), Vector2(200, 100), "units/gui/crownout_logo", Color4(0, 0, 0,
	1))

	delta = delta + dt
	Material.set_float(matBg, "u_time", delta)
    ballActor = PhysicsWorld.actor_instances(Game.pw, Game.ball)
    --print(PhysicsWorld.actor_is_kinematic(Game.pw, playerActor))
    --PhysicsWorld.actor_teleport_world_pose(Game.pw, playerActor, SceneGraph.world_pose(Game.sg, Game.player))
    ---[[
	-- Stop the engine when the 'ESC' key is released
	if Keyboard.released(Keyboard.button_id("escape")) then
		Device.quit()
	end

	local vel = PhysicsWorld.actor_linear_velocity(Game.pw, ballActor)
    if Keyboard.released(Keyboard.button_id("space")) then
        PhysicsWorld.actor_add_impulse(Game.pw, ballActor, Vector3(0, 0, 15))
    end

	-- Toggle fullscreen
	if Keyboard.released(Keyboard.button_id("0")) then
		Game.fullscreen = not Game.fullscreen
		Window.set_fullscreen(Game.fullscreen)
	end

    --[[
	-- Cycle through characters
	if Pad1.pressed(Pad1.button_id("shoulder_right")) or Keyboard.pressed(Keyboard.button_id("j")) then
		AnimationStateMachine.trigger(Game.sm, Game.player, "idle")
		Game.player_i = Game.player_i % #Game.players + 1
		Game.player = Game.players[Game.player_i]
	end
    --]]
	-- Sprite depth is proportional to its Z position
    --[[
	for i=1, #Game.players do
		local pos = SceneGraph.local_position(Game.sg, Game.players[i])
		local depth = math.floor(1000 + (1000 - 32*pos.z))
		RenderWorld.sprite_set_depth(Game.rw, Game.players[i], depth)
	end
    --]]

    --[[
	if pad_dir.x ~= 0.0 or pad_dir.y ~= 0.0 then
		local speed_x = AnimationStateMachine.variable_id(Game.sm, Game.player, "speed_x")
		local speed_y = AnimationStateMachine.variable_id(Game.sm, Game.player, "speed_y")
		local speed   = AnimationStateMachine.variable_id(Game.sm, Game.player, "speed")
		AnimationStateMachine.set_variable(Game.sm, Game.player, speed_x, pad_dir.x)
		AnimationStateMachine.set_variable(Game.sm, Game.player, speed_y, pad_dir.y)
		AnimationStateMachine.set_variable(Game.sm, Game.player, speed, math.max(0.2, Vector3.length(pad_dir)))
		AnimationStateMachine.trigger(Game.sm, Game.player, "run")
	else
		AnimationStateMachine.trigger(Game.sm, Game.player, "idle")
	end
    --]]
    --]]
end

function Game.render(dt)
end

function Game.shutdown()
end
