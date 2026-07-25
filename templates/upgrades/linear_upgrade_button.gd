extends Control

const generator_index: int = 0
@export var format_string: String = "Buy 1 Grandma Duck"
var numGrandmaDucks: int = 0
var display = true
var disabled = true

var cost = 10
var increment = 10

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	GameCounter.score_changed.connect(check_if_ready)

func check_if_ready(current_feathers: int, lifetime_feathers: int):
	if (display && !disabled && current_feathers >= cost):
		disabled = false

func _on_texture_button_pressed() -> void:
	if (!disabled):
		GeneratorUpgrades.increment_generator_count(generator_index)
		
		cost += increment
		
		if GameCounter.score > cost:
			disabled = true
