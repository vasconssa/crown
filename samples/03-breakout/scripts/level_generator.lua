PIXELS_PER_METER=32
block_width = 384
block_height = 128
block_num_rows = 6
blocks_per_row = 6
platform_height = 128
platform_width = 485
pipe_height = 32
pipe_width = 32
ball_radius = 128

block_names = {"units/Walls/brick", "units/Walls/brick_blue", "units/Walls/brick_pink_side", "units/Walls/brick_red"}
blocks = {}

function gen_background()
end

function gen_piped_wall(world)
    width, heigth = Device.resolution()
	pw = World.physics_world(world)
	rw = World.render_world(world)
	sg = World.scene_graph(world)
	sm = World.animation_state_machine(world)

    num_y_pipes = math.ceil(heigth/pipe_height)
    scale_y = heigth/(num_y_pipes*pipe_height)
    print(scale_y)
    num_x_pipes = math.ceil(width/pipe_width)
    scale_x = width/(num_x_pipes*pipe_width)
    print(scale_x)

    posx = -width/2/PIXELS_PER_METER + (pipe_width/2/PIXELS_PER_METER)*scale_y
    posz = -heigth/2/PIXELS_PER_METER + (pipe_height/PIXELS_PER_METER/2)*scale_y
    for i=1, num_y_pipes do
        a = World.spawn_unit(world, "units/pipes/pipes", Vector3(posx, 0, posz), Quaternion.from_elements(0, 0, 0, 1), Vector3(scale_x, 1, scale_y))
        RenderWorld.sprite_set_frame(rw, a, 14)
        b = World.spawn_unit(world, "units/pipes/pipes", Vector3(posx + width/PIXELS_PER_METER - pipe_width/PIXELS_PER_METER, 0, posz), Quaternion.from_elements(0, 0, 0, 1), Vector3(scale_x, 1, scale_y))
        RenderWorld.sprite_set_frame(rw, b, 14)
        posz = posz + (pipe_height/PIXELS_PER_METER)*scale_y
    end
    posx = -width/2/PIXELS_PER_METER + (pipe_width/2/PIXELS_PER_METER)*scale_y
    posz = heigth/2/PIXELS_PER_METER - (pipe_height/PIXELS_PER_METER/2)*scale_y
    for i=1, num_x_pipes do
        a = World.spawn_unit(world, "units/pipes/pipes", Vector3(posx, 0, posz), Quaternion.from_elements(0, 0, 0, 1), Vector3(scale_x, 1, scale_y))
        RenderWorld.sprite_set_frame(rw, a, 5)
        b = World.spawn_unit(world, "units/pipes/pipes", Vector3(posx, 0, posz - heigth/PIXELS_PER_METER + pipe_height/PIXELS_PER_METER), Quaternion.from_elements(0, 0, 0, 1), Vector3(scale_x, 1, scale_y))
        RenderWorld.sprite_set_frame(rw, b, 6)
        posx = posx + (pipe_width/PIXELS_PER_METER)*scale_x
    end
    
end

function level1(world)

	pw = World.physics_world(world)
	rw = World.render_world(world)
	sg = World.scene_graph(world)
	sm = World.animation_state_machine(world)

    World.spawn_unit(world, "units/Background/background", Vector3(0, 0, 0))
    gen_piped_wall(world)
    width, heigth = Device.resolution()

    width = width - 2*pipe_width
    print("height: ")
    heigth = heigth - 2*pipe_height
    scale = width/(blocks_per_row*block_width)
    pos = -width/2/PIXELS_PER_METER
    pos = pos + (block_width/PIXELS_PER_METER/2)*scale
    posz = heigth/2/PIXELS_PER_METER;
    posz = posz - (block_height/PIXELS_PER_METER/2)*scale
    for i=1, block_num_rows do
        for j=1, blocks_per_row do
            idx = (i-5)*5 + j
            blocks[idx] = World.spawn_unit(world, "units/bricks/bricks_sheet", Vector3(pos, 0, posz), Quaternion.from_elements(0, 0, 0, 1), Vector3(scale, scale, scale))
            --SceneGraph.set_local_scale(sg, blocks[idx], Vector3(scale, scale, scale))
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
    GameBase.game.player = World.spawn_unit(world, "units/platforms/platform", Vector3(pos_platform_x, 0, pos_platform_z), Quaternion.from_elements(0, 0, 0, 1), Vector3(scale, scale, scale))
    --SceneGraph.set_local_scale(sg, GameBase.game.player, Vector3(scale, scale, scale))
    GameBase.game.ball = World.spawn_unit(world, "units/balls/ball", Vector3(pos_platform_x, 0, pos_platform_z+scale*platform_height/PIXELS_PER_METER/2 + scale*ball_radius/PIXELS_PER_METER/2), Quaternion.from_elements(0, 0, 0, 1), Vector3(scale, scale, scale))
    --SceneGraph.set_local_scale(sg, GameBase.game.ball, Vector3(scale, scale, scale))


end
