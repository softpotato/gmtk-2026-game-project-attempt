extends Node

# WARNING: POTENTIALLY DEPRECATING THIS CLASS. WILL REMOVE 
# IN A FEW PUSHES IN FAVOR OF GENERIC global_upgrades.gd

var generator_count: Array[int] = [0, 0, 0]
var generator_algorithm: Array[String] = ["linear", "logarithmic", "logarithmic"]


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func increment_generator_count(index: int) -> void:
	generator_count[index] += 1
