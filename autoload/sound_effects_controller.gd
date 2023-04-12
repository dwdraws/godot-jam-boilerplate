extends Node

@export var sfx_list: Array[SoundEffect]

@onready var players = get_children()

var sfx_dict: Dictionary = {}

func _ready() -> void:
	for sound_effect in sfx_list:
		sfx_dict[sound_effect.id] = sound_effect
	
	print (sfx_dict)

func play(id: String, volume: float = 0, pitch_scale: float = 1) -> void:
	if id not in sfx_dict:
		return

	var sound_effect = sfx_dict[id] as SoundEffect
		
	for player in players:
		if not player.playing:
			player.pitch_scale = pitch_scale
			player.volume_db = volume if !!volume else sound_effect.base_volume
			player.stream = sound_effect.audio_stream
			player.play()
			return
	
	print("SoundEffectsController: no players available")
