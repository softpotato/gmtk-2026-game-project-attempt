class_name UpgradeButton
extends Control

@export var upgrade_id: String
@export var play_button: TextureButton

func _ready() -> void:
	GameCounter.score_changed.connect(_update_state)
	_update_text()
	_update_state(GameCounter.score, GameCounter.totalFeathersAccumulated)
	play_button.button_down.connect(_on_button_down)
	play_button.button_up.connect(_on_button_up)

func _update_text() -> void:
	$TextureButton/Text.text = GlobalUpgrades.get_cost_label(upgrade_id)

# Listen for total feathers
func _update_state(current_feathers: int, _feathers_lifetime: int) -> void:
	if current_feathers >= GlobalUpgrades.get_cost(upgrade_id):
		$TextureButton.disabled = false
		$TextureButton.modulate = Color(1, 1, 1, 1)
	else:
		$TextureButton.disabled = true
		$TextureButton.modulate = Color(0.5, 0.5, 0.5, 1)

# When the button is pressed
func _on_texture_button_pressed() -> void:
	var cost = GlobalUpgrades.get_cost(upgrade_id)
	
	if GameCounter.score >= cost:
		GlobalUpgrades.buy_upgrade(upgrade_id)
		GameCounter.subtract_score(cost)
		_update_text()

func _on_button_down() -> void:
	Input.set_custom_mouse_cursor(Cursor.click_cursor, Input.CURSOR_IBEAM, Vector2(35, 35))

func _on_button_up() -> void:
	Input.set_custom_mouse_cursor(Cursor.default_cursor, Input.CURSOR_ARROW, Vector2(35, 35))
