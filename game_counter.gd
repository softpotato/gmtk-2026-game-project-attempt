extends Node

signal score_changed(new_score)

var score: int = 0

func add_score(amount: int):
	score += amount
	print("Current Score:", score)
	
	emit_signal("score_changed", score)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# TODO: Load in state from file
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
