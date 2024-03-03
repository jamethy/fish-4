extends Control


func _on_start_button_pressed():
	Effects._play_fx()
	get_tree().change_scene_to_file("res://game.tscn")


func _on_exit_button_pressed():
	Effects._play_fx()
	get_tree().quit()
	
