extends Node

@onready var launch_bumper: CanvasLayer = $LaunchBumper

@export var main_menu_scene: PackedScene
@export var game_main_scene: PackedScene
@export var skip_bumper: bool = false

func _ready() -> void:
	GameEvents.start_game.connect(on_start_game)
	GameEvents.exit_game_to_menu.connect(on_exit_game_to_menu)
	
	launch_bumper.complete.connect(on_launch_bumper_complete)
	
	if skip_bumper:
		launch_bumper.queue_free()
		start_main_menu()
	

func start_main_menu() -> void:
	AudioController.play_music_random()
	
	var main_menu_instance = main_menu_scene.instantiate()
	add_child(main_menu_instance)
	
func on_start_game() -> void:
	var game_main_instance = game_main_scene.instantiate()
	add_child(game_main_instance)

func on_exit_game_to_menu() -> void:
	var main_menu_instance = main_menu_scene.instantiate()
	add_child(main_menu_instance)

func on_launch_bumper_complete() -> void:
	start_main_menu()
