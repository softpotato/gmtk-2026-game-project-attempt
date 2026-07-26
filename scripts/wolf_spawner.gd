# This script handles the background random chance event of wolves spawning. Every fixed interval
# of time, it flips a biased coin, and if the flip succeeds, a wolf spawns in-game. This passive
# random wolf spawning is something that constantly happens in the background.

# A wolf passively drains feathers at a fixed rate. That logic is defined in wolf.gd.
# this file exclusively governs the passive random spawning of wolves.

extends Node

# the max number of wolves that can be on screen at any time
const MAX_WOLVES: int = 10

# time interval on which wolves have a chance of spawning
const SPAWN_CHANCE_INTERVAL: float = 10.0

# the probability of a wolf spawning per spawn chance interval
const SPAWN_PROBABILITY: float = 0.7

# the wolf template to be instantiated when it's time to spawn a wolf
var wolf_scene: PackedScene = preload("res://templates/wolf.tscn")

# the background timer for passive wolf spawning
var spawn_timer: Timer

func _ready() -> void:
	spawn_timer = Timer.new()
	spawn_timer.wait_time = SPAWN_CHANCE_INTERVAL
	spawn_timer.one_shot = false
	spawn_timer.timeout.connect(_on_spawn_timer_timeout)
	add_child(spawn_timer)
	spawn_timer.start()

	print("wolf spawner readied")

func _on_spawn_timer_timeout() -> void:
	# flip the biased coin
	var time_to_spawn_wolf = randf() <= SPAWN_PROBABILITY

	# if successful, spawn the wolf
	if time_to_spawn_wolf:
		spawn_wolf()

func spawn_wolf() -> void:
	# if the screen already has the max number of wolves, don't spawn more
	var num_wolves_on_screen_now = get_tree().get_nodes_in_group(Constants.WOLVES_GROUP_NAME).size()
	if num_wolves_on_screen_now >= MAX_WOLVES:
		return

	# instantiate a wolf from the wolf template
	var wolf = wolf_scene.instantiate()

	# the dimensions of the game screen itself
	var viewport_size = get_viewport().get_visible_rect().size
	# margin padding so wolves don't get spawned right on the edge of the screen
	var margin = 50.0

	# we don't want to spawn a wolf on top of an existing UI element
	# on the screen, so we randomly generate a candidate position and
	# check if it overlaps with an existing element. If it does, retry
	# generating a position. If after a fixed number of tries it fails
	# to find a spawn position for the wolf, just give up and skip
	# spawning this wolf
	var max_attempts = 5
	for attempt in range(max_attempts):
		var candidate_position = Vector2(
			randf_range(margin, viewport_size.x - wolf.size.x - margin),
			randf_range(margin, viewport_size.y - wolf.size.y - margin)
		)
		wolf.position = candidate_position

		if not overlaps_with_existing_elements(wolf.get_rect()):
			get_parent().add_child(wolf)
			print("spawned %s" % [wolf.name])
			return

	print("could not find spawn location for a new wolf after %d attempts, skipping spawning this wolf" % [max_attempts])
	wolf.queue_free()

# accepts an on-screen rectangle (of a wolf) and checks to see if it overlaps
# with any existing element on the UI. this func is called by the spawn_wolf()
# func on every attempt to find a spawn position for a wolf. this means it rescans
# the UI elements on screen every attempt. the alternative is to scan the elements
# on screen once and store them locally, then check against those locally stored
# elements on each randomly generated candidate position. the reason this
# "rescan every attempt" approach is taken is to protect against the possibility
# that this wolf spawner reads in the on-screen UI state now and stores it, then the state
# of the UI changes immediately after, meaning the wolf spawner has incorrect information
# about the current state of the UI and has an increased chance of spawning a wolf
# on top of an existing element
func overlaps_with_existing_elements(wolf_rect: Rect2) -> bool:
	for child in get_parent().get_children():
		if (child is Control) and (wolf_rect.intersects(child.get_rect())):
			return true
	return false
