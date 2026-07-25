extends Label


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	GameCounter.score_changed.connect(_on_score_changed)
	
	text = "Score: " + str(GameCounter.score)

func _on_score_changed(new_score: int, _total_score: int):
	text = "Score: " + str(new_score)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
