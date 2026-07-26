extends Node

const UPGRADE_DATA : Dictionary = {
	"spawn_rate": {
		"name": "spawn_rate",
		"base_cost": 10,
		"cost_multiplier": 1.35,
	},
	"feather_value": {
		"name": "feather_value",
		"base_cost": 50,
		"cost_multiplier": 1.65,
	},
	"golden_chance": {
		"name": "golden_chance",
		"base_cost": 25,
		"cost_multiplier": 1.65,
	},
	"scavenging": {
		"name": "scavenging",
		"base_cost": 20,
		"cost_multiplier": 1.40,
	}
}

signal spawn_rate_updated()

signal scavenging_updated()

signal upgrade_id_for_inventory(upgrade_id)

var upgrade_levels: Dictionary[String, int] = {}

func get_level(upgrade_id: String) -> int:
	return upgrade_levels.get(upgrade_id, 0)

func buy_upgrade(upgrade_id: String) -> void:
	upgrade_levels[upgrade_id] = get_level(upgrade_id) + 1
	if upgrade_id == "spawn_rate":
		emit_signal("spawn_rate_updated")
	if upgrade_id == "scavenging":
		emit_signal("scavenging_updated")
		
	emit_signal("upgrade_id_for_inventory", upgrade_id)

func get_cost(upgrade_id: String) -> int:
	var data = UPGRADE_DATA[upgrade_id]
	var level = get_level(upgrade_id)

	return roundi(data.base_cost * pow(data.cost_multiplier, level))
	
func get_cost_label(upgrade_id: String) -> String:
	return "Buy %s for %d" % [ 
		UPGRADE_DATA[upgrade_id].name, 
		get_cost(upgrade_id) 
	]
