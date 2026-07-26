extends Control

func _on_button_pressed() -> void:
	GameCounter.add_score(1 + GlobalUpgrades.get_level("feather_value"))
