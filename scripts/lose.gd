extends Node

@onready var lose_sound: AudioStreamPlayer2D = $Lose

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	lose_sound.play() 


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
