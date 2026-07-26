class_name Inventory
extends Control

@export var inventory_items: Dictionary[String, Item] = {}

var expanded = false

func _on_texture_button_pressed() -> void:
	if expanded:
		position.y = 220
	else:
		position.y = 720
		
	expanded = !expanded
	position.rotated(PI / 2)
