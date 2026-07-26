extends Node

const BASE_SPAWN_RATE := 10.0
const SPAWN_RATE_MULTIPLIER := 0.8 

var timer: Timer

func _ready() -> void:
	timer = Timer.new()
	timer.one_shot = false
	timer.timeout.connect(_on_timeout)
	add_child(timer)

	_update_spawn_rate()
	GlobalUpgrades.scavenging_updated.connect(_update_spawn_rate)

func _update_spawn_rate() -> void:
	var level = GlobalUpgrades.get_level("scavenging")

	if level == 0:
		timer.stop()
		return

	timer.start(BASE_SPAWN_RATE * pow(SPAWN_RATE_MULTIPLIER, level - 1))

func _on_timeout() -> void:
	GameCounter.add_score(1)
