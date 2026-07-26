extends Control

@export var expand_button: TextureButton
@export var collapse_button: TextureButton

var expanded = true

func _ready() -> void:
	expand_button.visible = false
	collapse_button.visible = true
	
	expand_button.pressed.connect(expand)
	collapse_button.pressed.connect(collapse)
	
func expand() -> void:
	expand_button.visible = false
	collapse_button.visible = true
	
	position.x = 980
	
func collapse() -> void:
	expand_button.visible = true
	collapse_button.visible = false
	
	position.x = 1280
