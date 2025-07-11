extends Node # To be set as a global script as it needs to initialize

#region names_enum (not declared as enum because enums must have int value)
const PLAYER: String = "player"
const ENEMY: String = "enemy"
const PLAYER_PROJECTILE: String = "player_projectile"
const ENEMY_PROJECTILE: String = "enemy_projectile"
#endregion

var _layers_dict: Dictionary

func _init() -> void:
	_load_layer_names()
	print(_layers_dict)

func _load_layer_names() -> void:
	for i: int in range(32):
		var layer_index: int = i + 1
		var layer: String = ProjectSettings.get_setting("layer_names/2d_physics/layer_%s" % layer_index as String)
		if layer:
			_layers_dict[layer] = pow(2, i)
		
func get_collision_layer_from_name(name: StringName) -> int:
	if not _layers_dict.has(name):
		push_error("Collision layer named %s does not exist" % name)
	return _layers_dict[name]
