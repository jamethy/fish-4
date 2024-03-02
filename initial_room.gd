extends Node3D
class_name Fish

@onready
var other_fish_scenes = [
	preload("res://fish.tscn"),
]

@export var fish_count = 500

# Called when the node enters the scene tree for the first time.
func _ready():
	for i in range(0, fish_count):
		var new_fish = other_fish_scenes.pick_random().instantiate()
		new_fish.position = Vector3(randf_range(-12, 12), randf_range(1, 3), randf_range(-12, 12))
		add_child(new_fish)
	Events.player_found_goal_fish.connect(_on_player_found_goal_fish)

func _on_player_found_goal_fish(_d: Dictionary):
	$CanvasLayer.visible = true
	$Camera3D.target = $GoalFish
