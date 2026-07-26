extends Node

@export var pet_cursor = preload("res://assets/hand cursor petting smol.png")
@export var default_cursor = preload("res://assets/hand cursor open smol.png")
@export var click_cursor = preload("res://assets/hand cursor closed smol.png")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

# This deals with clicking, but breaks the other petting thing so for now we just leaving this
#func _input(event):
	#if event.as_text() == "Left Mouse Button" and Input.get_current_cursor_shape() != Input.CURSOR_BUSY:
		#print("bruh")
		#if Input.get_current_cursor_shape() == Input.CURSOR_ARROW:
			#Input.set_custom_mouse_cursor(click_cursor, Input.CURSOR_BDIAGSIZE, Vector2(65, 65))
		#elif Input.get_current_cursor_shape() == Input.CURSOR_BDIAGSIZE:
			## Should be the closed one
			#Input.set_custom_mouse_cursor(default_cursor, Input.CURSOR_ARROW, Vector2(65, 65))
