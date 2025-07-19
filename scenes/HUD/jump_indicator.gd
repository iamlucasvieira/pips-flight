extends HBoxContainer

const SINGLE_JUMP_INDICATOR = preload("res://scenes/HUD/single_jump_indicator.tscn")



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Game.jumps_counter_updated.connect(_on_jumps_counter_updated)
	var indicator_instance
	for i in range(Game.get_jumps_available()):
		indicator_instance = SINGLE_JUMP_INDICATOR.instantiate()
		indicator_instance.name = "JumpIndicator" + str(i + 1)
		indicator_instance.texture = indicator_instance.texture.duplicate()
		add_child(indicator_instance)
	update_indicator_status()
	

func update_indicator_status():
	var children = get_children()
	for i in range(children.size()):
		var texture_rect = children[i]
		var atlas = texture_rect.texture as AtlasTexture
		
		if i < Game.jumps_used:
			atlas.region.position.x = 0
		else:
			atlas.region.position.x = 16

func _on_jumps_counter_updated():
	update_indicator_status()
