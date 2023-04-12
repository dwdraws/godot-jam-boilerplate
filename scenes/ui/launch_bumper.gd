extends CanvasLayer

signal complete

func on_complete() -> void:
	complete.emit()
	queue_free()
