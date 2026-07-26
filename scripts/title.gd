extends Node2D

@export var initial_scene: StringName = &""
@export var play_button: Button

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	play_button.pressed.connect(_on_button_pressed)
	play_button.button_down.connect(_on_button_down)
	play_button.button_up.connect(_on_button_up)

func _on_button_pressed() -> void:
	SceneLoader.load_scene(initial_scene)

func _on_button_down() -> void:
	Input.set_custom_mouse_cursor(Cursor.click_cursor, Input.CURSOR_IBEAM, Vector2(35, 35))

func _on_button_up() -> void:
	Input.set_custom_mouse_cursor(Cursor.default_cursor, Input.CURSOR_ARROW, Vector2(35, 35))

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
