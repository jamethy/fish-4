extends Control

func _ready():
	Effects._play_music()


func _on_start_button_pressed():
	Effects._play_random_fx()
	get_tree().change_scene_to_file("res://game.tscn")


func _on_exit_button_pressed():
	Effects._play_random_fx()
	get_tree().quit()
	
