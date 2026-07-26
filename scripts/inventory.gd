class_name Inventory
extends Control

@export var inventory_items: Dictionary[String, Item] = {}

func _ready() -> void:
	GlobalUpgrades.upgrade_unlocked.connect(process_new_upgrades)

func process_new_upgrades(upgrade_id: String):
	if inventory_items.has(upgrade_id):
		var item_icon = inventory_items.get(upgrade_id)
		item_icon.reparent($Panel/MarginContainer/Panel/MarginContainer/GridContainer)

var expanded = false

func _on_texture_button_pressed() -> void:
	if expanded:
		position.y = 220
	else:
		position.y = 720
		
	expanded = !expanded
	position.rotated(PI / 2)
