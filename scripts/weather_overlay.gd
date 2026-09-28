extends ColorRect
class_name WeatherOverlay

## WeatherOverlay: Fullscreen canvas layer reacting to WeatherSystem signals
## Displays dynamic weather shaders (Sun/Rain/Sandstorm/Snow) with smooth fades.

@onready var mat: ShaderMaterial = material as ShaderMaterial

func _ready() -> void:
	mouse_filter = Control.MOUSE_FILTER_IGNORE
	if not WeatherSystem.weather_changed.is_connected(_on_weather_changed):
		WeatherSystem.weather_changed.connect(_on_weather_changed)
	_on_weather_changed(WeatherSystem.current_weather, WeatherSystem.weather_timer)

func _on_weather_changed(w: String, _duration: float) -> void:
	if mat == null:
		return
		
	var w_type = 0
	match w:
		"sun":
			w_type = 1
		"rain":
			w_type = 2
		"sandstorm":
			w_type = 3
		"snow":
			w_type = 4
		_:
			w_type = 0
			
	if w_type == 0:
		# Smoothly fade out
		var tw = create_tween()
		tw.tween_property(self, "modulate:a", 0.0, 0.3)
	else:
		mat.set_shader_parameter("weather_type", w_type)
		modulate.a = 0.0
		var tw = create_tween()
		tw.tween_property(self, "modulate:a", 1.0, 0.4)
