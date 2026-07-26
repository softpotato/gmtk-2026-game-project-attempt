extends Control

@onready var duck_sound: AudioStreamPlayer2D = $AudioStreamPlayer2D
@onready var duck_animation: AnimatedSprite2D = $AnimatedSprite2D

@onready var baseback: Sprite2D = $basecapback
@onready var basefront: Sprite2D = $basecapfront
@onready var beanback: Sprite2D = $beanback
@onready var beanfront: Sprite2D = $beanfront
@onready var bow: Sprite2D = $bow
@onready var leaf: Sprite2D = $leaf
@onready var tophat: Sprite2D = $tophat
@onready var wizback: Sprite2D = $wizback
@onready var wizfront: Sprite2D = $wizfront


@export var play_button: TextureButton

var pat_count: int = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	play_button.focus_mode = Control.FOCUS_NONE
	play_button.button_down.connect(_on_button_down)
	play_button.button_up.connect(_on_button_up)

func _on_button_pressed() -> void:
	duck_animation.stop()
	duck_animation.play()
	duck_sound.play()
	
	pat_count += 1
	
	var hat_check = pat_count % 21
	
	if hat_check < 3:
		wizback.visible = false
		wizfront.visible = false
	elif hat_check < 6:
		baseback.visible = true
		basefront.visible = true
	elif hat_check < 9:
		baseback.visible = false
		basefront.visible = false
		beanback.visible = true
		beanfront.visible = true
	elif hat_check < 12:
		beanback.visible = false
		beanfront.visible = false
		bow.visible = true
	elif hat_check < 15:
		bow.visible = false
		leaf.visible = true
	elif hat_check < 18:
		leaf.visible = false
		tophat.visible = true
	elif hat_check < 21:
		tophat.visible = false
		wizback.visible = true
		wizfront.visible = true
		

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_button_down() -> void:
	Input.set_custom_mouse_cursor(Cursor.petting_cursor, Input.CURSOR_POINTING_HAND, Vector2(35, 35))

func _on_button_up() -> void:
	Input.set_custom_mouse_cursor(Cursor.pet_cursor, Input.CURSOR_POINTING_HAND, Vector2(35, 35))
