extends PanelContainer

signal next_level_button_pressed

func _on_next_level_button_pressed():
	next_level_button_pressed.emit()
