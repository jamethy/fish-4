extends Control

func _on_exit_to_main_menu_button_pressed():
	get_tree().change_scene_to_file("res://UI/main_menu.tscn")


func _on_exit_to_desktop_button_pressed():
	get_tree().quit()
