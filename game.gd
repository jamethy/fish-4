extends Node

var current_level: int = 1


func _ready():
	load_level(1)

func load_level(level: int):
	$CanvasLayer/Loading.visible = true
	call_deferred("_load_level", level)


func _load_level(level: int):
	current_level = level
	var current_level_node = get_node_or_null("Level")
	if current_level_node != null:
		remove_child(current_level_node)
	var scene = load("res://Scenes/level_%d.tscn" % level).instantiate()
	add_child(scene)
	call_deferred("_hide_loading_screen")
	
	
func _hide_loading_screen():
	$CanvasLayer/Loading.visible = false


func _unhandled_input(event):
	print(event)


func _on_level_complete_menu_next_level_button_pressed():
	load_level(current_level + 1)
