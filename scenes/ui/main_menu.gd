extends CanvasLayer

@onready var start_button: Button = %StartButton
@onready var settings_button: Button = %SettingsButton
@onready var credits_button: Button = %CreditsButton
@onready var quit_button: Button = %QuitButton

@onready var settings_screen: MarginContainer = %SettingsScreen
@onready var credits_screen: MarginContainer = %CreditsScreen

@onready var animation_player: AnimationPlayer = $AnimationPlayer


func _ready() -> void:
	start_button.pressed.connect(on_start_button_pressed)
	settings_button.pressed.connect(on_settings_button_pressed)
	credits_button.pressed.connect(on_credits_button_pressed)
	quit_button.pressed.connect(on_quit_button_pressed)
	
	settings_screen.closed.connect(on_settings_screen_closed)
	credits_screen.closed.connect(on_credits_screen_closed)

func on_start_button_pressed() -> void:
	GameEvents.emit_start_game()
	queue_free()


func on_settings_button_pressed() -> void:
	animation_player.play("transition_settings")


func on_credits_button_pressed() -> void:
	animation_player.play("transition_credits")


func on_quit_button_pressed() -> void:
	get_tree().quit()


func on_settings_screen_closed() -> void:
	animation_player.play_backwards("transition_settings")


func on_credits_screen_closed() -> void:
	animation_player.play_backwards("transition_credits")
