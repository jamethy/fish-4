extends Node3D

const BUBBLE = preload("res://Player/bubble.tscn")
@onready var camera_3d = $Camera3D

@onready
var other_fish_scenes = [
	preload("res://fish.tscn"),
]

@export var fish_count = 100

# Called when the node enters the scene tree for the first time.
func _ready():
	Events.player_wriggled.connect(_on_player_wriggled)
	Events.player_found_goal_fish.connect(_on_player_found_goal_fish)
	
	for i in range(0, fish_count):
		var new_fish = other_fish_scenes.pick_random().instantiate()
		new_fish.position = Vector3(randf_range(-12, 12), randf_range(1, 3), randf_range(-12, 12))
		add_child(new_fish)
	Events.player_found_goal_fish.connect(_on_player_found_goal_fish)

func _on_player_found_goal_fish(_d: Dictionary):
	camera_3d.target = $GoalFish


func _on_player_wriggled(pos:Dictionary):
	var scene = BUBBLE.instantiate()
	self.add_child(scene)
	scene.global_position =  pos["player_pos"]
