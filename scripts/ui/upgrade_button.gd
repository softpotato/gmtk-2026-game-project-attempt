class_name UpgradeButton
extends Control

@export var parent_reference: UpgradeMenu
@export var upgrade_id: String
@export var button_text: String
@export var cost: int
@export var render_cost: int # cost for upgrade to show up

const format_string: String = "Buy %s for %s"

func _ready() -> void:
	GameCounter.score_changed.connect(_on_feather_change)
	recalculate_ui()

func recalculate_ui() -> void:
	$TextureButton/Text.text = format_string % [button_text, cost]
	_on_feather_change(GameCounter.score, GameCounter.totalFeathersAccumulated)

# Listen for total feathers
func _on_feather_change(current_feathers: int, lifetime_feathers: int) -> void:
	if current_feathers >= cost:
		$TextureButton.disabled = false
		$TextureButton.modulate = Color(1, 1, 1, 1)
	else:
		$TextureButton.disabled = true
		$TextureButton.modulate = Color(0.5, 0.5, 0.5, 1)

# When the button is pressed
func _on_texture_button_pressed() -> void:
	if GameCounter.score >= cost:
		GameCounter.subtract_score(cost)
		GlobalUpgrades.add_upgrade(upgrade_id)
		_register_next_upgrade()

# This is a virtual function intended to be overriden if the 
# overrided class is to 
func _register_next_upgrade() -> void:
	parent_reference.remove_upgrade(self)
