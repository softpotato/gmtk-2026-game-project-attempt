extends Control

@onready var duck_sound: AudioStreamPlayer2D = $AudioStreamPlayer2D
@onready var duck_animation: AnimatedSprite2D = $AnimatedSprite2D

@export var play_button: TextureButton

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	play_button.focus_mode = Control.FOCUS_NONE
	play_button.button_down.connect(_on_button_down)
	play_button.button_up.connect(_on_button_up)

func _on_button_pressed() -> void:
	duck_animation.stop()
	duck_animation.play()
	duck_sound.play()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_button_down() -> void:
	Input.set_custom_mouse_cursor(Cursor.petting_cursor, Input.CURSOR_POINTING_HAND, Vector2(35, 35))

func _on_button_up() -> void:
	Input.set_custom_mouse_cursor(Cursor.pet_cursor, Input.CURSOR_POINTING_HAND, Vector2(35, 35))
