extends CanvasLayer

@onready var resume_button: Button = %ResumeButton
@onready var exit_button: Button = %ExitButton


func _ready() -> void:
	resume_button.pressed.connect(on_resume_button_pressed)
	exit_button.pressed.connect(on_exit_button_pressed)


func _process(delta: float) -> void:
	if Input.is_action_just_pressed("game_pause"):
		unpause_game()


func unpause_game() -> void:
	queue_free()
	GameEvents.emit_game_paused(false)


func on_resume_button_pressed() -> void:
	unpause_game()


func on_exit_button_pressed() -> void:
	GameEvents.emit_game_paused(false)
	GameEvents.emit_exit_game_to_menu()
