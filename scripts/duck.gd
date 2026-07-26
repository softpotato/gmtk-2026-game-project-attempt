extends Control

@onready var duck_sound: AudioStreamPlayer2D = $AudioStreamPlayer2D
@onready var duck_animation: AnimatedSprite2D = $AnimatedSprite2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func _on_button_pressed() -> void:
	duck_animation.stop()
	duck_animation.play()
	duck_sound.play()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_texture_button_mouse_entered() -> void:
	Input.set_custom_mouse_cursor(Cursor.pet_cursor, Input.CURSOR_ARROW, Vector2(65, 65)) 


func _on_texture_button_mouse_exited() -> void:
	Input.set_custom_mouse_cursor(Cursor.default_cursor, Input.CURSOR_ARROW, Vector2(65, 65)) 
