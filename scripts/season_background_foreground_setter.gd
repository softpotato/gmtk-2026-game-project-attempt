extends TextureRect

@export var background: TextureRect
@export var foreground: TextureRect

@export var spring_background: CompressedTexture2D
@export var spring_foreground: CompressedTexture2D

@export var summer_background: CompressedTexture2D
@export var summer_foreground: CompressedTexture2D

@export var fall_background: CompressedTexture2D
@export var fall_foreground: CompressedTexture2D

@export var winter_background: CompressedTexture2D
@export var winter_foreground: CompressedTexture2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	SeasonsCycle.season_change.connect(on_season_change)

func on_season_change(season: WeatherBar.Weather):
	match season:
		WeatherBar.Weather.SPRING:
			print("SPRING")
			background.texture = spring_background
			foreground.texture = spring_foreground
			
		WeatherBar.Weather.SUMMER:
			print("SUMMER")
			background.texture = summer_background
			foreground.texture = summer_foreground
			
		WeatherBar.Weather.FALL:
			print("FALL")
			background.texture = fall_background
			foreground.texture = fall_foreground
			
		WeatherBar.Weather.WINTER:
			print("WINTER")
			background.texture = winter_background
			foreground.texture = winter_foreground

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
