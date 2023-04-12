extends CanvasLayer

@onready var pause_button: Button = %PauseButton

func _ready() -> void:
	pause_button.pressed.connect(on_pause_button_pressed)


func on_pause_button_pressed() -> void:
	GameEvents.emit_game_paused(true)
