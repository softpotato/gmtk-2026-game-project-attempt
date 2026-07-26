class_name UpgradeButton
extends Control

@export var parent_reference: UpgradeMenu
@export var upgrade_id: String
@export var button_text: String
@export var cost: int
@export var render_cost: int # cost for upgrade to show up
@export var play_button: TextureButton

const format_string: String = "Buy %s for %s"
	

func _ready() -> void:
	GameCounter.score_changed.connect(_on_feather_change)
	play_button.button_down.connect(_on_button_down)
	play_button.button_up.connect(_on_button_up)
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

func _on_button_down() -> void:
	Input.set_custom_mouse_cursor(Cursor.click_cursor, Input.CURSOR_IBEAM, Vector2(35, 35))

func _on_button_up() -> void:
	Input.set_custom_mouse_cursor(Cursor.default_cursor, Input.CURSOR_ARROW, Vector2(35, 35))

# This is a virtual function intended to be overriden if the 
# overrided class is to 
func _register_next_upgrade() -> void:
	parent_reference.remove_upgrade(self)
