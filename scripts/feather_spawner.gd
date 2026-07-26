# This script handles the background random chance event of feathers spawning. Every fixed interval
# of time, it flips a biased coin, and if the flip succeeds, a feather spawns in-game. This passive
# random feather spawning is something that constantly happens in the background.

# A feather passively drains feathers at a fixed rate. That logic is defined in feather.gd.
# this file exclusively governs the passive random spawning of feathers.

extends Node

# the max number of feathers that can be on screen at any time
const MAX_FEATHERS: int = 50

# time interval on which feathers have a chance of spawning
const SPAWN_CHANCE_INTERVAL: float = 1.0

# the probability of a feather spawning per spawn chance interval
const SPAWN_PROBABILITY: float = 0.9

# how much faster the spawn is with each spawn rate upgrade
const SPAWN_RATE_MULTIPLIER: float = 0.92

# chance to spawn a golden feather per upgrade level
const GOLDEN_CHANCE_PER_LEVEL := 0.05

# value of a golden feather
const GOLDEN_VALUE := 10

# the feather template to be instantiated when it's time to spawn a feather
var feather_scene: PackedScene = preload("res://templates/feather.tscn")

# the background timer for passive feather spawning
var spawn_timer: Timer

func _ready() -> void:
	spawn_timer = Timer.new()
	spawn_timer.one_shot = false
	spawn_timer.timeout.connect(_on_spawn_timer_timeout)
	add_child(spawn_timer)
	
	GlobalUpgrades.spawn_rate_updated.connect(_update_spawn_rate)
	_update_spawn_rate()
	
	print("feather spawner readied")
	
func _update_spawn_rate() -> void:
	var level = GlobalUpgrades.get_level("spawn_rate")
	spawn_timer.start(SPAWN_CHANCE_INTERVAL * pow(SPAWN_RATE_MULTIPLIER, level))

func _on_spawn_timer_timeout() -> void:
	# flip the biased coin
	var time_to_spawn_feather = randf() <= SPAWN_PROBABILITY

	# if successful, spawn the feather
	if time_to_spawn_feather:
		spawn_feather()

func spawn_feather() -> void:
	# if the screen already has the max number of wolves, don't spawn more
	var num_feathers_on_screen_now = get_tree().get_nodes_in_group(Constants.FEATHERS_GROUP_NAME).size()
	if num_feathers_on_screen_now >= MAX_FEATHERS:
		return

	# instantiate a feather from the feather template
	var feather = feather_scene.instantiate()

	# determine whether to spawn a golden feather
	var chance = GOLDEN_CHANCE_PER_LEVEL * GlobalUpgrades.get_level("golden_chance")

	if randf() < chance:
		feather.value = GOLDEN_VALUE
		feather.modulate = Color.GOLD

	# the dimensions of the game screen itself
	var viewport_size = get_viewport().get_visible_rect().size
	# margin padding so feathers don't get spawned right on the edge of the screen
	var margin = 50.0

	# we don't want to spawn a feather on top of an existing UI element
	# on the screen, so we randomly generate a candidate position and
	# check if it overlaps with an existing element. If it does, retry
	# generating a position. If after a fixed number of tries it fails
	# to find a spawn position for the feather, just give up and skip
	# spawning this feather
	var max_attempts = 5
	for attempt in range(max_attempts):
		var candidate_position = Vector2(
			randf_range(margin, viewport_size.x - feather.size.x - margin),
			randf_range(margin, viewport_size.y - feather.size.y - margin)
		)
		feather.position = candidate_position

		if not overlaps_with_existing_elements(feather.get_rect()):
			get_parent().add_child(feather)
			print("spawned %s" % [feather.name])
			return

	print("could not find spawn location for a new feather after %d attempts, skipping spawning this feather" % [max_attempts])
	feather.queue_free()

# accepts an on-screen rectangle (of a feather) and checks to see if it overlaps
# with any existing element on the UI. this func is called by the spawn_wolf()
# func on every attempt to find a spawn position for a feather. this means it rescans
# the UI elements on screen every attempt. the alternative is to scan the elements
# on screen once and store them locally, then check against those locally stored
# elements on each randomly generated candidate position. the reason this
# "rescan every attempt" approach is taken is to protect against the possibility
# that this feather spawner reads in the on-screen UI state now and stores it, then the state
# of the UI changes immediately after, meaning the feather spawner has incorrect information
# about the current state of the UI and has an increased chance of spawning a feather
# on top of an existing element
func overlaps_with_existing_elements(feather_rect: Rect2) -> bool:
	for child in get_parent().get_children():
		if (child is Control) and (feather_rect.intersects(child.get_rect())):
			return true
	return false
