class_name GetFactionParam extends Node

static func get_collision_layer_for_entity(faction: Enums.Faction) -> int:
	match faction:
		Enums.Faction.PLAYER:
			return PhysicsLayersNamesUtils.get_collision_layer_from_name(PhysicsLayersNamesUtils.PLAYER)
		Enums.Faction.ENEMY:
			return PhysicsLayersNamesUtils.get_collision_layer_from_name(PhysicsLayersNamesUtils.ENEMY)
		_:
			push_error("Unexpected Faction")
			return 0

static func get_collision_layer_for_projectile(faction: Enums.Faction) -> int:
	match faction:
		Enums.Faction.PLAYER:
			return PhysicsLayersNamesUtils.get_collision_layer_from_name(PhysicsLayersNamesUtils.PLAYER_PROJECTILE)
		Enums.Faction.ENEMY:
			return PhysicsLayersNamesUtils.get_collision_layer_from_name(PhysicsLayersNamesUtils.ENEMY_PROJECTILE)
		_:
			push_error("Unexpected Faction")
			return 0

static func get_collision_mask_for(faction: Enums.Faction) -> int:
	match faction:
		Enums.Faction.PLAYER:
			return PhysicsLayersNamesUtils.get_collision_layer_from_name(PhysicsLayersNamesUtils.ENEMY)
		Enums.Faction.ENEMY:
			return PhysicsLayersNamesUtils.get_collision_layer_from_name(PhysicsLayersNamesUtils.PLAYER)
		_:
			push_error("Unexpected Faction")
			return 0
			
static func get_projectile_direction_for(faction: Enums.Faction) -> Vector2:
	match faction:
		Enums.Faction.PLAYER:
			return Vector2.UP
		Enums.Faction.ENEMY:
			return Vector2.DOWN
		_:
			push_error("Unexpected Faction")
			return Vector2.ZERO
