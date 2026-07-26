class_name Inventory
extends Control

@export var inventory_items: Dictionary[String, Item] = {}

var expanded = false

func _ready() -> void:
	GlobalUpgrades.upgrade_id_for_inventory.connect(check_if_inventory_icon)

func check_if_inventory_icon(upgrade_id: String):
	if inventory_items.has(upgrade_id):
		inventory_items.get(upgrade_id).reparent($Panel/MarginContainer/Panel/MarginContainer/GridContainer)

func _on_texture_button_pressed() -> void:
	if expanded:
		position.y = 220
	else:
		position.y = 720
		
	expanded = !expanded
