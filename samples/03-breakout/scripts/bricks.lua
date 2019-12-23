local Bricks = Bricks or {}
local Data = Data or {}

function Bricks.spawned(world, units)
end

function Bricks.unspawned(world, units)
end

function Bricks.update(world, dt)
end

function Bricks.collision_begin(touched, touching, actor, position, normal, distance)
	if touched == Game.ball then
		print("Collision begin")
		if (UnitManager.alive(touching)) then
			World.destroy_unit(GameBase.world, touching)
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
