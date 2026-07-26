extends CanvasLayer

signal loading_screen_ready

@export var animation_player: AnimationPlayer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	await animation_player.animation_finished
	loading_screen_ready.emit()

# Can be a progress bar
func _on_progress_changed(new_value: float) -> void:
	pass
	
func _on_load_finished() -> void:
	if !GameCounter.introPlayed:
		GameCounter.introPlayed = true
		animation_player.play("Introduction")
		await animation_player.animation_finished

	queue_free()
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
