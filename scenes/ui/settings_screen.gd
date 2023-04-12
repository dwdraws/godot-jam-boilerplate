extends MarginContainer

signal closed

@onready var back_button: Button = %BackButton
@onready var master_volume_slider: HSlider = %MasterVolumeSlider
@onready var music_volume_slider: HSlider = %MusicVolumeSlider
@onready var sfx_volume_slider: HSlider = %SfxVolumeSlider
@onready var ambient_volume_slider: HSlider = %AmbientVolumeSlider

var settings_changed: bool = false

func _ready() -> void:
	back_button.pressed.connect(on_back_button)
	
	var game_settings = GameSettings.get_settings()
	master_volume_slider.value = 0.0 if game_settings.master_muted else db_to_linear(game_settings.master_volume)
	music_volume_slider.value = 0.0 if game_settings.music_muted else db_to_linear(game_settings.music_volume)
	sfx_volume_slider.value = 0.0 if game_settings.sfx_muted else db_to_linear(game_settings.sfx_volume)
	ambient_volume_slider.value = 0.0 if game_settings.ambient_muted else db_to_linear(game_settings.ambient_volume)
	
	master_volume_slider.value_changed.connect(on_master_volume_slider_value_changed)
	music_volume_slider.value_changed.connect(on_music_volume_slider_value_changed)
	sfx_volume_slider.value_changed.connect(on_sfx_volume_slider_value_changed)
	ambient_volume_slider.value_changed.connect(on_ambient_volume_slider_value_changed)


func update_volume_setting(setting_bus_key: String, value: float) -> void:
	settings_changed = true
	
	if value == 0.0:
		GameSettings.update_setting(setting_bus_key + "_muted", true)
	else:
		GameSettings.update_setting(setting_bus_key + "_muted", false)
		GameSettings.update_setting(setting_bus_key + "_volume", linear_to_db(value))


func on_back_button() -> void:
	if settings_changed:
		GameSettings.save_settings()
	closed.emit()


func on_master_volume_slider_value_changed(value: float) -> void:
	update_volume_setting("master", value)


func on_music_volume_slider_value_changed(value: float) -> void:
	update_volume_setting("music", value)


func on_sfx_volume_slider_value_changed(value: float) -> void:
	update_volume_setting("sfx", value)


func on_ambient_volume_slider_value_changed(value: float) -> void:
	update_volume_setting("ambient", value)

