PIXELS_PER_METER=32
block_width = 425
block_height = 239
block_num_rows = 6
blocks_per_row = 6
platform_height = 128
platform_width = 485
pipe_height = 32
pipe_width = 32
ball_radius = 128

block_names = {"units/Walls/brick", "units/Walls/brick_blue", "units/Walls/brick_pink_side", "units/Walls/brick_red"}
blocks = {}
local pw = nil
local rw = nil
local sg = nil
local sm = nil

function gen_background()
end

function gen_piped_wall(world)
	width = 0.7*device_width
	heigth = device_heigth
	pw = World.physics_world(world)
	rw = World.render_world(world)
	sg = World.scene_graph(world)
	sm = World.animation_state_machine(world)

    num_y_pipes = math.ceil(heigth/pipe_height)
    scale_y = heigth/(num_y_pipes*pipe_height)
    num_x_pipes = math.ceil(width/pipe_width)
    scale_x = width/(num_x_pipes*pipe_width)

    posx = -(device_width)/2/PIXELS_PER_METER + (pipe_width/2/PIXELS_PER_METER)*scale_y
    posz = -heigth/2/PIXELS_PER_METER + (pipe_height/PIXELS_PER_METER/2)*scale_y
    for i=1, num_y_pipes do
        a = World.spawn_unit(world, "units/pipes/pipes", Vector3(posx, 0, posz), Quaternion.from_elements(0, 0, 0, 1), Vector3(scale_x, 1, scale_y))
        RenderWorld.sprite_set_frame(rw, a, 14)
        b = World.spawn_unit(world, "units/pipes/pipes", Vector3(posx + width/PIXELS_PER_METER - pipe_width/PIXELS_PER_METER, 0, posz), Quaternion.from_elements(0, 0, 0, 1), Vector3(scale_x, 1, scale_y))
        RenderWorld.sprite_set_frame(rw, b, 14)
        posz = posz + (pipe_height/PIXELS_PER_METER)*scale_y
    end
    posx = -device_width/2/PIXELS_PER_METER + (pipe_width/2/PIXELS_PER_METER)*scale_y
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

    local unitBg = World.spawn_unit(world, "units/Background/computer_wires", Vector3(0, 0, 0))
	matBg = RenderWorld.sprite_material(Game.rw, unitBg)
    gen_piped_wall(world)

    width = width - 2*pipe_width
    heigth = heigth - 2*pipe_height
    bricks_scale = width/(blocks_per_row*block_width)
	ball_scale = 0.3
	platform_scale = 0.35
    pos = -(device_width - 2*pipe_width)/2/PIXELS_PER_METER
    pos = pos + (block_width/PIXELS_PER_METER/2)*bricks_scale
    posz = heigth/2/PIXELS_PER_METER;
    posz = posz - (block_height/PIXELS_PER_METER/2)*bricks_scale
    for i=1, block_num_rows do
		blocks[i] = {}
        for j=1, blocks_per_row do
            blocks[i][j] = World.spawn_unit(world, "units/bricks/brick_bottom", Vector3(pos, 0, posz), Quaternion.from_elements(0, 0, 0, 1), Vector3(bricks_scale, bricks_scale, bricks_scale))
            --SceneGraph.set_local_scale(sg, blocks[idx], Vector3(scale, scale, scale))
			--RenderWorld.sprite_set_frame(rw, blocks[i][j], 25)
            pos = pos + (block_width/PIXELS_PER_METER)*bricks_scale
        end
        pos = -(device_width - 2*pipe_width)/2/PIXELS_PER_METER
        pos = pos + (block_width/PIXELS_PER_METER/2)*bricks_scale
        posz = posz - (block_height/PIXELS_PER_METER)*bricks_scale
    end
	mat_bricks = RenderWorld.sprite_material(Game.rw, blocks[1][1])
	Material.set_vector2(mat_bricks, "u_block_size", Vector2(block_width*bricks_scale/device_width, block_height*bricks_scale/device_heigth))

    pos_platform_z = -heigth/2/PIXELS_PER_METER;
    pos_platform_z = pos_platform_z + (platform_height/PIXELS_PER_METER/2)*platform_scale
    pos_platform_x = 0
    GameBase.game.player = World.spawn_unit(world, "units/platforms/platform", Vector3(pos_platform_x, 0, pos_platform_z), Quaternion.from_elements(0, 0, 0, 1), Vector3(platform_scale, platform_scale, platform_scale))
    --SceneGraph.set_local_scale(sg, GameBase.game.player, Vector3(scale, scale, scale))
    GameBase.game.ball = World.spawn_unit(world, "units/balls/ball", Vector3(pos_platform_x, 0, pos_platform_z+platform_scale*platform_height/PIXELS_PER_METER/2 + ball_scale*ball_radius/PIXELS_PER_METER/2), Quaternion.from_elements(0, 0, 0, 1), Vector3(ball_scale, ball_scale, ball_scale))
    --SceneGraph.set_local_scale(sg, GameBase.game.ball, Vector3(scale, scale, scale))


end
