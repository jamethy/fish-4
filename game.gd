extends Node

var current_level: int = 1


func _ready():
	Events.player_health_changed.connect(_on_player_health_changed)
	Events.player_found_goal_fish.connect(_on_player_found_goal_fish)
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	
	var has_level_already = false # for testing
	for c in get_children():
		if c as Node3D:
			has_level_already = true
			break
	if not has_level_already:
		load_level(1)
	else:
		_after_level_loaded()

func load_level(level: int):
	$CanvasLayer/Loading.visible = true
	$CanvasLayer/PlayerUI.visible = false
	call_deferred("_load_level", level)


func _load_level(level: int):
	current_level = level
	var current_level_node = get_node_or_null("Level")
	if current_level_node != null:
		remove_child(current_level_node)
	var scene = load("res://Scenes/level_%d.tscn" % level).instantiate()
	add_child(scene)
	call_deferred("_after_level_loaded")
	
	
func _after_level_loaded():
	$CanvasLayer/Loading.visible = false
	$CanvasLayer/PlayerUI.visible = true
	$CanvasLayer/LevelStartDisplay.show_for_level_start(current_level)


func _unhandled_input(_event):
	if $CanvasLayer/Loading.visible:
		return
	if Input.is_action_just_released("show_menu"):
		_toggle_in_game_menu()


func _toggle_in_game_menu():
	var menu_node = $CanvasLayer/InGameMenu
	menu_node.visible = !menu_node.visible
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE if menu_node.visible else Input.MOUSE_MODE_CAPTURED
	

func _on_level_complete_menu_next_level_button_pressed():
	load_level(current_level + 1)


func _on_in_game_menu_back_to_game_pressed():
	_toggle_in_game_menu()


func _on_player_health_changed(d:Dictionary):
	if d.player_health <= 0:
		$CanvasLayer/GameOver.visible = true


func _on_player_found_goal_fish(_d: Dictionary):
	$CanvasLayer.visible = true
