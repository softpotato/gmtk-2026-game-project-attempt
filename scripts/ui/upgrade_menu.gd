class_name UpgradeMenu
extends Control

@export var locked_upgrades: Array[UpgradeButton]
var unlocked_upgrades: Array[UpgradeButton]
var purchased_upgrades: Array[UpgradeButton]

func _ready() -> void:
	GameCounter.score_changed.connect(_check_locked_upgrades)
	_check_locked_upgrades(GameCounter.score, GameCounter.totalFeathersAccumulated)

# Rendering Logic
#func refresh_menu():
	#for child in $ScrollContainer/VBoxContainer.get_children():
		#$ScrollContainer/VBoxContainer.remove_child(child)
	#
	#for upgrade in unlocked_upgrades:
		#upgrade.reparent($ScrollContainer/VBoxContainer)
		##$ScrollContainer/VBoxContainer.add_child(upgrade)
		
# Adding New Upgrade To Render
func _check_locked_upgrades(current_feathers: int, feathers_lifetime: int) -> void:
	locked_upgrades.filter(
		func(upgrade): 
			if upgrade.render_cost <= current_feathers:
				unlocked_upgrades.append(upgrade)
				upgrade.reparent($MarginContainer/ScrollContainer/VBoxContainer)
				return false
			return true
	)
	
	#refresh_menu()

# Performance wise, probably not good. But we don't need to worry too much about scaling
# at this scale of 10-20 options
func remove_upgrade(buttonToRemove: UpgradeButton) -> void:
	unlocked_upgrades.filter(func (upgrade: UpgradeButton) -> bool:
			return upgrade != buttonToRemove
	)
	$MarginContainer/ScrollContainer/VBoxContainer.remove_child(buttonToRemove)
	purchased_upgrades.append(buttonToRemove)

# This callback method is primarily for registering the next upgrade once
# the previous one is selected
func register_next_unlocked_upgrade(upgrade: UpgradeButton):
	unlocked_upgrades.append(upgrade)
	_sort_unlocked_upgrades()
	
func _sort_unlocked_upgrades() -> void:
	unlocked_upgrades.sort_custom(_custom_upgrade_sort)
	
func _custom_upgrade_sort(a: UpgradeButton, b: UpgradeButton):
	return a.cost < b.cost
