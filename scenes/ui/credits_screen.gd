extends MarginContainer

signal closed

@onready var back_button: Button = %BackButton

func _ready() -> void:
	back_button.pressed.connect(on_back_button)
	
func on_back_button() -> void:
	closed.emit()
