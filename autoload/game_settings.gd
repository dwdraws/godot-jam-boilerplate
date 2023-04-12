extends Node

const SAVE_SETTINGS_PATH = "user://settings.save"

const SETTING_TO_BUS = {
	master_muted = "Master",
	master_volume = "Master",
	music_muted = "music",
	music_volume = "music",
	sfx_muted = "sfx",
	sfx_volume = "sfx",
	ambient_muted = "ambient",
	ambient_volume = "ambient",
}

var settings: Dictionary = {
	master_muted = false,
	master_volume = 1.0,
	music_muted = false,
	music_volume = 1.0,
	sfx_muted = false,
	sfx_volume = 1.0,
	ambient_muted = false,
	ambient_volume = 1.0,
}

func _ready() -> void:
	load_settings()

func get_settings() -> Dictionary:
	return settings

func update_setting(key: String, value) -> void:
	if key not in settings:
		return
	
	if settings[key] != value:
		settings[key] = value
		GameEvents.emit_settings_updated(settings)
		update_audio_buses()


func update_audio_buses() -> void:
	for key in settings:
		if "volume" in key:
			update_audio_bus_volume(key)
		elif "muted" in key:
			update_audio_bus_muted(key)

func update_audio_bus_volume(key: String) -> void:
	var bus := AudioServer.get_bus_index(SETTING_TO_BUS[key])
	AudioServer.set_bus_volume_db(bus, settings[key])

func update_audio_bus_muted(key: String) -> void:
	var bus := AudioServer.get_bus_index(SETTING_TO_BUS[key])
	AudioServer.set_bus_mute(bus, settings[key])

func save_settings() -> void:
	var file := FileAccess.open(SAVE_SETTINGS_PATH, FileAccess.WRITE)
	file.store_var(settings)
	
	print("settings saved", settings)

func load_settings() -> void:
	if !FileAccess.file_exists(SAVE_SETTINGS_PATH):
		return
	
	var file := FileAccess.open(SAVE_SETTINGS_PATH, FileAccess.READ)
	settings = file.get_var()
	
	GameEvents.emit_settings_updated(settings)
	update_audio_buses()
	
	print("settings loaded", settings)
