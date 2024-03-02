extends RigidBody3D

@export var found_scale = 5

# Called when the node enters the scene tree for the first time.
func _ready():
	Events.player_found_goal_fish.connect(_on_player_found_goal_fish)


var found = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _on_player_found_goal_fish(_d: Dictionary):
	if found:
		return
	found = true
	var tween = get_tree().create_tween()
	tween.tween_property(self, "scale", Vector3(found_scale, found_scale, found_scale), 10)
	gravity_scale = 0
	
		

func _physics_process(delta):
	if not found:
		return
	
	position.y += 2 * delta
	rotation.y += 2 * delta
