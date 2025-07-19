@tool
extends PanelContainer

@onready var label: Label = $Label
@export var text: String

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	label.text = text
