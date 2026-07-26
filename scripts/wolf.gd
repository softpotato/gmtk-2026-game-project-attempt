extends Control

@export var play_button: TextureButton

# the interval at which an individual wolf takes a feather away
const STEAL_INTERVAL: int = 5

# the wolf's health
var health: int = 5

# the background timer for a wolf passively stealing feathers
var steal_timer: Timer

func _ready() -> void:
	# add to group to tag it for easy identification
	# as a wolf on the screen
	add_to_group(Constants.WOLVES_GROUP_NAME)

	# set the timer for wolf to passively steal feathers
	steal_timer = Timer.new()
	steal_timer.wait_time = STEAL_INTERVAL
	steal_timer.one_shot = false
	steal_timer.timeout.connect(_on_steal_timer_timeout)
	add_child(steal_timer)
	steal_timer.start()
	
	play_button.button_down.connect(_on_button_down)
	play_button.button_up.connect(_on_button_up)
	play_button.focus_mode = Control.FOCUS_NONE

	print(name, " readied")

# logic for a wolf stealing a feather
func _on_steal_timer_timeout() -> void:
	# don't steal feathers if there are 0 feathers
	# or somehow negative feathers
	if GameCounter.score <= 0:
		print(name, " saw there were no feathers and didn't steal any")
		return

	GameCounter.subtract_score(1)
	print(name, " stole a feather")

# logic for a wolf being clicked on, taking damage, and eventually dying
func _on_button_pressed() -> void:
	health -= 1
	if health <= 0:
		# removes the wolf from the scene and also
		# from the "wolves" group that's used to
		# identify wolf elements in the scene
		self.queue_free()
		
func _on_button_down() -> void:
	Input.set_custom_mouse_cursor(Cursor.click_cursor, Input.CURSOR_IBEAM, Vector2(35, 35))

func _on_button_up() -> void:
	Input.set_custom_mouse_cursor(Cursor.default_cursor, Input.CURSOR_ARROW, Vector2(35, 35))
