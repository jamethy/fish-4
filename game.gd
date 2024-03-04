extends Node

var current_level: int = 0

var levels = [
	preload("res://Scenes/level_1.tscn"),
	preload("res://Scenes/level_3.tscn"),
	preload("res://Scenes/level_2.tscn"),
]

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
		load_level(0)
	else:
		_after_level_loaded()
		
		
func _process(delta: float):
	_set_timer()


func _set_timer():
	var timer_node = get_node_or_null("Level/Timer")
	if not timer_node:
		return
	var seconds = int(timer_node.time_left)
	var sixtieth_seconds = int((timer_node.time_left - seconds) * 60)
	$CanvasLayer/PlayerUI/TimerLabel.text = "%02.0f:%02.0f" % [seconds, sixtieth_seconds]

func load_level(level: int):
	$CanvasLayer/Loading.visible = true
	$CanvasLayer/PlayerUI.visible = false
	call_deferred("_load_level", level)


func _load_level(level: int):
	current_level = level
	var current_level_node = get_node_or_null("Level")
	if current_level_node != null:
		remove_child(current_level_node)
		current_level_node.queue_free()
	if level >= len(levels):
		$CanvasLayer/Loading.visible = false
		$CanvasLayer/Credits.visible = true
		$CanvasLayer/LevelCompleteMenu.visible = false
		return
	var node = levels[level].instantiate()
	node.name = "Level"
	add_child(node)
	call_deferred("_after_level_loaded")
	
	
func _after_level_loaded():
	$CanvasLayer/Loading.visible = false
	$CanvasLayer/LevelCompleteMenu.visible = false
	$CanvasLayer/PlayerUI.visible = true
	$CanvasLayer/LevelStartDisplay.show_for_level_start(current_level)
	_set_mouse(false)
	var timer_node = get_node_or_null("Level/Timer")
	$CanvasLayer/PlayerUI/TimerLabel.visible = timer_node != null
	if timer_node:
		timer_node.timeout.connect(_on_time_ran_out)
		timer_node.start()


func _unhandled_input(_event):
	if $CanvasLayer/Loading.visible:
		return
	if Input.is_action_just_released("show_menu"):
		_toggle_in_game_menu()


func _set_mouse(menu_visible: bool):
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE if menu_visible else Input.MOUSE_MODE_CAPTURED


func _toggle_in_game_menu():
	var menu_node = $CanvasLayer/InGameMenu
	menu_node.visible = !menu_node.visible
	_set_mouse(menu_node.visible)
	

func _on_level_complete_menu_next_level_button_pressed():
	load_level(current_level + 1)


func _on_player_health_changed(d:Dictionary):
	if d.player_health <= 0:
		$CanvasLayer/GameOver.visible = true
		var timer_node = get_node_or_null("Level/Timer")
		if timer_node:
			timer_node.paused = true


func _on_player_found_goal_fish(_d: Dictionary):
	$CanvasLayer/LevelCompleteMenu.visible = true
	_set_mouse(true)
	var timer_node = get_node_or_null("Level/Timer")
	if timer_node:
		timer_node.paused = true


func _on_back_to_game_button_pressed():
	_toggle_in_game_menu()

func _on_exit_to_main_menu_button_pressed():
	get_tree().change_scene_to_file("res://UI/main_menu.tscn")


func _on_exit_to_desktop_button_pressed():
	get_tree().quit()


func _on_alstrainfinite_fish_button_pressed():
	OS.shell_open("https://alstrainfinite.itch.io/fish")

func _on_time_ran_out():
	$CanvasLayer/GameOver.visible = true
	_set_mouse(true)
