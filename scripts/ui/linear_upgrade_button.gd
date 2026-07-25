extends Control

@export var generator_id: String = ""
@export var button_text: String = ""
@export var initial_reveal_threshold: int = 0
const button_text_format = "%s for %s"

var numberOfUpgrades: int = 0

# Linear cost algorithmn
@export var current_cost = 10
@export var increment_per_upgrade = 10

func _ready() -> void:
	if initial_reveal_threshold > 0:
		visible = false
		get_node("TextureButton").set_visible(false)
		get_node("TextureButton/Text").set_visible(false)
	
	# Initialize the button text
	get_node("TextureButton/Text").set_text(button_text_format % [button_text, current_cost])
	
	# Add listener to running score
	GameCounter.score_changed.connect(check_if_ready)

func check_if_ready(current_feathers: int, lifetime_feathers: int):
	if !visible:
		if current_feathers > initial_reveal_threshold:
			visible = true
			get_node("TextureButton").set_visible(true)
			get_node("TextureButton/Text").set_visible(true)
	
	if (current_feathers >= current_cost):
		get_node("TextureButton").set_disabled(false)
	else:
		get_node("TextureButton").set_disabled(true)

func _on_texture_button_pressed() -> void:
	if GameCounter.score >= current_cost:
		GameCounter.subtract_score(current_cost)
		emit_signal("generator_upgraded", generator_id, current_cost)
		current_cost += increment_per_upgrade
		get_node("TextureButton/Text").set_text(button_text_format % [button_text, current_cost])
