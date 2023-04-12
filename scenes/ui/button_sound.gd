extends Button

@export var sound_effect_id: String = "sample_sfx"

func _ready() -> void:
	pressed.connect(on_pressed)

func on_pressed() -> void:
	SoundEffectsController.play(sound_effect_id, 0, randf_range(0.8, 1.2))
