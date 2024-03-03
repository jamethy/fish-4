extends Control

signal back_to_game_pressed

func _on_back_to_game_button_pressed():
	Effects._play_fx()
	back_to_game_pressed.emit()

func _on_exit_to_main_menu_button_pressed():
	Effects._play_fx()
	get_tree().change_scene_to_file("res://UI/main_menu.tscn")


func _on_exit_to_desktop_button_pressed():
	Effects._play_fx()
	get_tree().quit()
