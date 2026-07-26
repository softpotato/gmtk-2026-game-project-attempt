class_name Item
extends Panel

@export var texture: Texture

func _ready() -> void:
	$MarginContainer/TextureRect.texture = texture
