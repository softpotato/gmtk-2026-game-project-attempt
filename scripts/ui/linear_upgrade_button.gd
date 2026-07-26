class_name LinearUpgradeButton
extends UpgradeButton

@export var increment: int = 10

func ready() -> void:
	play_button.button_down.connect(_on_button_down)
	play_button.button_up.connect(_on_button_up)

func _register_next_upgrade() -> void:
	cost += increment
	
	# Bad dependencies you have to do every subsequent inherited
	# button. Sadly, wish I didn't make the base button delete 
	# itself, but hard to remove feature with inheritance. 
	recalculate_ui()
	
func _on_button_down() -> void:
	Input.set_custom_mouse_cursor(Cursor.click_cursor, Input.CURSOR_IBEAM, Vector2(35, 35))

func _on_button_up() -> void:
	Input.set_custom_mouse_cursor(Cursor.default_cursor, Input.CURSOR_ARROW, Vector2(35, 35))
