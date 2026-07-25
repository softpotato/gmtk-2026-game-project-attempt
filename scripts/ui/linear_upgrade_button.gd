class_name LinearUpgradeButton
extends UpgradeButton

@export var increment: int = 10

func _register_next_upgrade() -> void:
	cost += increment
	recalculate_text()
	pass
