extends RigidBody3D

@export var found_scale = 5
@export var max_victory_height = 10

# Called when the node enters the scene tree for the first time.
func _ready():
	Events.player_found_goal_fish.connect(_on_player_found_goal_fish)


var found = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _on_player_found_goal_fish(_d: Dictionary):
	if found:
		return
	found = true
	# TODO figure out why scale is being reset
	#var tween = get_tree().create_tween()
	#tween.tween_property(self, "scale", Vector3(found_scale, found_scale, found_scale), 10)
	gravity_scale = 0
	

func _physics_process(delta):
	if not found:
		return
	
	rotation = Vector3()
	# rotate children because we don't want the camera to rotate
	$CollisionShape3D.rotation.y += 2 * delta
	$FishModel.rotation.y = $CollisionShape3D.rotation.y
	var destination_height = min(position.y + 2*delta, max_victory_height)
	var weight = (max_victory_height - position.y)/max_victory_height
	position.y = lerpf(position.y, destination_height, weight)
