extends Control

@export var play_button: TextureButton

func _ready() -> void:
	# add to group to tag it for easy identification
	# as a feather on the screen
	add_to_group(Constants.FEATHERS_GROUP_NAME)
	
	play_button.button_down.connect(_on_button_down)
	play_button.button_up.connect(_on_button_up)
	play_button.focus_mode = Control.FOCUS_NONE
	self.rotation_degrees = randf_range(0, 360)

func _on_button_pressed() -> void:
	GameCounter.add_score(1)
	self.queue_free()

func _on_button_down() -> void:
	Input.set_custom_mouse_cursor(Cursor.click_cursor, Input.CURSOR_IBEAM, Vector2(35, 35))

func _on_button_up() -> void:
	Input.set_custom_mouse_cursor(Cursor.default_cursor, Input.CURSOR_ARROW, Vector2(35, 35))
