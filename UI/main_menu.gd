extends Control

@onready var audio_stream_player = $AudioStreamPlayer


func _ready():
	audio_stream_player.play()


func _on_start_button_pressed():
	Effects._play_random_fx()
	get_tree().change_scene_to_file("res://game.tscn")


func _on_exit_button_pressed():
	Effects._play_random_fx()
	get_tree().quit()
	
