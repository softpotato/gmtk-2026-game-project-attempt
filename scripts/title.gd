extends Node2D

@export var initial_scene: StringName = &""
@export var play_button: Button

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	play_button.pressed.connect(_on_button_pressed)

func _on_button_pressed() -> void:
	SceneLoader.load_scene(initial_scene)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
