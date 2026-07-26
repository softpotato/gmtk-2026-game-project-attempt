extends Node

@export var pet_cursor = preload("res://assets/hand cursor petting smolest.png")
@export var petting_cursor = preload("res://assets/hand cursor petting smolest down.png")
@export var default_cursor = preload("res://assets/hand cursor open smolest.png")
@export var click_cursor = preload("res://assets/hand cursor closed smolest.png")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Input.set_custom_mouse_cursor(default_cursor, Input.CURSOR_ARROW, Vector2(35, 35))
	Input.set_custom_mouse_cursor(click_cursor, Input.CURSOR_IBEAM, Vector2(35, 35))
	Input.set_custom_mouse_cursor(pet_cursor, Input.CURSOR_POINTING_HAND, Vector2(35, 35))

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

# Doesn't really work for buttons and other UI things, not really sure why
#func _input(event):
	#if Input.get_current_cursor_shape() == Input.CURSOR_POINTING_HAND:
		#pass
	#
	#if event is InputEventMouseButton and event.is_pressed() and event.button_index == MOUSE_BUTTON_LEFT:
		#Input.set_default_cursor_shape(Input.CURSOR_IBEAM)
	#else:
		#Input.set_default_cursor_shape(Input.CURSOR_ARROW)
