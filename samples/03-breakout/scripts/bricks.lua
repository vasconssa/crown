local Bricks = Bricks or {}
local Data = Data or {}

function Bricks.spawned(world, units)
end

function Bricks.unspawned(world, units)
end

function Bricks.update(world, dt)
end

function Bricks.collision_begin(touched, touching, actor, position, normal, distance)
	--if touching == Game.ball then
		--print(touching)
		--UnitManager.destroy(touched)
	--end
	--print("Collision begin")
end

function Bricks.collision(touched, touching, actor, position, normal, distance)
	--if touching == Game.ball then
		--print(touching)
		--UnitManager.destroy(touched)
	--end
	--print("Collision")
	-- print(Vector3.elements(position))
	-- print(Vector3.elements(normal))
	-- print(distance)
end

return Bricks
