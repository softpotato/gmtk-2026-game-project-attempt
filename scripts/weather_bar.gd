class_name WeatherBar
extends Control

enum Weather { SPRING, SUMMER, FALL, WINTER }

@export var season_duration: float = 60.0
var elapsed_time: float = 0.0
var current_season: Weather = Weather.SPRING

var format_string: String = "Time till %s"

func _ready() -> void:
	$Label.text = "Time till summer"

func _process(delta: float) -> void:
	if elapsed_time < season_duration:
		elapsed_time += delta
		
		$ProgressBar.value = season_duration - elapsed_time
	else:
		elapsed_time = 0
		$ProgressBar.value = season_duration
		
		match current_season:
			Weather.SPRING:
				current_season = Weather.SUMMER
				$Label.text = format_string % ["Fall"]
			Weather.SUMMER:
				current_season = Weather.FALL
				$Label.text = format_string % ["Winter"]
			Weather.FALL:
				current_season = Weather.WINTER
				$Label.text = format_string % ["Spring"]
			Weather.WINTER:
				current_season = Weather.SPRING
				$Label.text = format_string % ["Summer"]
		
		SeasonsCycle.set_season(current_season)
		
