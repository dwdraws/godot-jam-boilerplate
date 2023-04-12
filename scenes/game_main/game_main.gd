extends Node

@export var pause_screen_scene: PackedScene

var state = GameState.new()

func _ready() -> void:
	GameEvents.game_paused.connect(on_game_paused)
	GameEvents.exit_game_to_menu.connect(on_exit_game_to_menu)

func on_game_paused(paused: bool) -> void:
	if paused:
		add_child(pause_screen_scene.instantiate())
		
	get_tree().paused = paused

func on_exit_game_to_menu() -> void:
	queue_free()
