extends Node

signal settings_updated(settings: Dictionary)

signal start_game
signal exit_game_to_menu

signal game_win
signal game_over
signal game_paused(paused: bool)


func emit_settings_updated(settings: Dictionary) -> void:
	settings_updated.emit(settings)

func emit_start_game() -> void:
	start_game.emit()

func emit_exit_game_to_menu() -> void:
	exit_game_to_menu.emit()

func emit_game_paused(paused: bool):
	game_paused.emit(paused)

func emit_game_win() -> void:
	game_win.emit()
	
func emit_game_over() -> void:
	game_over.emit()
