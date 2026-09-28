extends PanelContainer
class_name WeatherBanner

## WeatherBanner: Compact top-bar badge indicating active weather and terrain
## Shows animated emoji, remaining seconds, and hovering tooltip with strategic combat bonuses.

@onready var weather_icon_label: Label = $HBox/WeatherIconLabel
@onready var weather_name_label: Label = $HBox/WeatherNameLabel
@onready var terrain_name_label: Label = $HBox/TerrainNameLabel
@onready var timer_label: Label = $HBox/TimerLabel

func _ready() -> void:
	if not WeatherSystem.weather_changed.is_connected(_on_environment_changed):
		WeatherSystem.weather_changed.connect(_on_environment_changed)
	if not WeatherSystem.terrain_changed.is_connected(_on_environment_changed):
		WeatherSystem.terrain_changed.connect(_on_environment_changed)
	_update_display()

func _process(_delta: float) -> void:
	if WeatherSystem.weather_timer > 0.0 or WeatherSystem.terrain_timer > 0.0:
		var sec = int(max(WeatherSystem.weather_timer, WeatherSystem.terrain_timer))
		timer_label.text = "(%ds)" % sec
		timer_label.visible = true
	else:
		timer_label.visible = false

func _on_environment_changed(_param: String = "", _dur: float = 0.0) -> void:
	_update_display()

func _update_display() -> void:
	var w = WeatherSystem.current_weather
	var t = WeatherSystem.current_terrain
	
	var w_name = WeatherSystem.get_weather_name(w)
	var t_name = WeatherSystem.get_terrain_name(t)
	
	if w != "none":
		weather_name_label.text = w_name
		weather_name_label.visible = true
	else:
		weather_name_label.text = "常态"
		weather_name_label.visible = false
		
	if t != "none":
		terrain_name_label.text = t_name
		terrain_name_label.visible = true
	else:
		terrain_name_label.visible = false
		
	if w == "none" and t == "none":
		weather_icon_label.text = "🌤️"
		weather_name_label.text = "微风常态"
		weather_name_label.visible = true
	else:
		weather_icon_label.text = "🌪️" if w == "sandstorm" else ("🌧️" if w == "rain" else ("☀️" if w == "sun" else "❄️"))
		
	tooltip_text = "【当前天气】%s\n%s\n\n【当前场地】%s\n%s" % [
		w_name, WeatherSystem.get_weather_desc(w),
		t_name, WeatherSystem.get_terrain_desc(t)
	]
