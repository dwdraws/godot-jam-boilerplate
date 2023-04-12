extends Node

@export var music_list: Array[AudioTrack]

@onready var music_stream_player: AudioStreamPlayer = $MusicStreamPlayer

var music_dict: Dictionary = {}

func _ready() -> void:
	for music_track in music_list:
		music_dict[music_track.id] = music_track

func play_music(id: String, volume: float = 0, pitch_scale: float = 1) -> void:
	if id not in music_dict:
		return
		
	var music_track = music_dict[id] as AudioTrack
		
	if music_stream_player.playing:
		music_stream_player.stop()
		
	music_stream_player.pitch_scale = pitch_scale
	music_stream_player.volume = volume if !!volume else music_track.base_volume
	music_stream_player.stream = music_track.audio_stream
	music_stream_player.play()

func play_music_random() -> void:
	var music_track = music_list.pick_random()
	
	if music_stream_player.playing:
		music_stream_player.stop()
		
	music_stream_player.volume_db = music_track.base_volume
	music_stream_player.stream = music_track.audio_stream
	music_stream_player.play()
