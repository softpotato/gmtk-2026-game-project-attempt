extends Node

signal season_change(weather)

var end_season = 40
var win_scene: StringName = &"uid://c0648gxmk5xek"
var lose_scene: StringName = &"uid://bc6gwaeuemflk"

var season: WeatherBar.Weather = WeatherBar.Weather.SPRING
var season_count = 0

func _ready() -> void:
	GameCounter.score_changed.connect(check_for_winter)
	
func check_for_winter(curr_score: int, lifetime_score: int):
	if season == WeatherBar.Weather.WINTER && curr_score <= 0:
		SceneLoader.load_scene(lose_scene)

func set_season(season: WeatherBar.Weather):
	self.season = season
	season_count += 1
	
	if season_count >= end_season:
		SceneLoader.load_scene(win_scene)
		
	print("season: %s" % season)
	
	emit_signal("season_change", self.season)
