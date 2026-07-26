extends Node

signal upgrade_unlocked(upgrade_id)

var unlocked_upgrades: Dictionary[String, int] = {}

func add_upgrade(upgrade_id: String) -> void:
	if unlocked_upgrades.has(upgrade_id):
		unlocked_upgrades.set(upgrade_id, unlocked_upgrades.get(upgrade_id))		
	else:
		unlocked_upgrades.set(upgrade_id, 1)
		emit_signal("upgrade_unlocked", upgrade_id)

func is_upgrade_exist(upgrade_id: String) -> void:
	return unlocked_upgrades.has(upgrade_id)
