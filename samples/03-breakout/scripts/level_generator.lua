PIXELS_PER_METER=32
block_width = 384
block_height = 128
block_num_rows = 6
blocks_per_row = 6
platform_height = 128
platform_width = 485
ball_radius = 128

block_names = {"units/Walls/brick", "units/Walls/brick_blue", "units/Walls/brick_pink_side", "units/Walls/brick_red"}
blocks = {}

function gen_background()
end

function level1(world)
    width, heigth = Device.resolution()

	pw = World.physics_world(world)
	rw = World.render_world(world)
	sg = World.scene_graph(world)
	sm = World.animation_state_machine(world)

    World.spawn_unit(world, "units/Background/background", Vector3(0, 0, 0))

    scale = width/(blocks_per_row*block_width)
    pos = -width/2/PIXELS_PER_METER
    pos = pos + (block_width/PIXELS_PER_METER/2)*scale
    posz = heigth/2/PIXELS_PER_METER;
    posz = posz - (block_height/PIXELS_PER_METER/2)*scale
    for i=1, block_num_rows do
        for j=1, blocks_per_row do
            idx = (i-5)*5 + j
            blocks[idx] = World.spawn_unit(world, "units/bricks/bricks_sheet", Vector3(pos, 0, posz))
            SceneGraph.set_local_scale(sg, blocks[idx], Vector3(scale, scale, scale))
            RenderWorld.sprite_set_frame(rw, blocks[idx], math.random(1,20))
            pos = pos + (block_width/PIXELS_PER_METER)*scale
        end
        pos = -width/2/PIXELS_PER_METER
        pos = pos + (block_width/PIXELS_PER_METER/2)*scale
        posz = posz - (block_height/PIXELS_PER_METER)*scale
    end

    pos_platform_z = -heigth/2/PIXELS_PER_METER;
    pos_platform_z = pos_platform_z + (platform_height/PIXELS_PER_METER/2)*scale
    pos_platform_x = 0
    print(pos_platform_z)
    GameBase.game.player = World.spawn_unit(world, "units/platforms/platform", Vector3(pos_platform_x, 0, pos_platform_z))
    SceneGraph.set_local_scale(sg, GameBase.game.player, Vector3(scale, scale, scale))
    GameBase.game.ball = World.spawn_unit(world, "units/balls/ball", Vector3(pos_platform_x, 0, pos_platform_z+platform_height/PIXELS_PER_METER/2 + ball_radius/PIXELS_PER_METER/2))
    --SceneGraph.set_local_scale(sg, GameBase.game.ball, Vector3(scale, scale, scale))


end
