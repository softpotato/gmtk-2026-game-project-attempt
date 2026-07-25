class_name LinearUpgradeButton
extends UpgradeButton

@export var increment: int = 10

func _register_next_upgrade() -> void:
	cost += increment
	
	# Bad dependencies you have to do every subsequent inherited
	# button. Sadly, wish I didn't make the base button delete 
	# itself, but hard to remove feature with inheritance. 
	recalculate_ui()
	
