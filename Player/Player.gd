extends CharacterBody3D

@onready var mesh_instance_3d = $MeshInstance3D
@onready var collision_shape_3d = $CollisionShape3D
@onready var camera = $SpringArm3D/Camera3D

#Speed Variables
var lerp_speed = 8.0
@export_range(0,20,.5) var SPEED = 5.0
#const JUMP_VELOCITY = 4.5

var has_burst = true
var is_bursting = false
var burst_timer = 0.0
@export_range(0,5,.1) var burst_timer_max:float = 3.0
@export_range(0,1) var burst_velocity = 5.0
var burst_vector = Vector2.ZERO

#Input Variables
var direction = Vector3.ZERO
var mouse_sensitivity = 0.2
var mouse_visible = false
var input_dir:Vector2 = Vector2.ZERO

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	mouse_visible = false


func _input(event):
	if event is InputEventMouseMotion:
		rotate_y(deg_to_rad(event.relative.x * mouse_sensitivity * -1))
		#camera.rotate_x(deg_to_rad(event.relative.y * mouse_sensitivity * -1))
		#camera.rotation.x = clamp(camera.rotation.x,deg_to_rad(-89),deg_to_rad(89))


func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y -= gravity * delta

	# Handle jump.
	#if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		#velocity.y = JUMP_VELOCITY

	# Handle Burst
	if Input.is_action_just_pressed("Burst") and has_burst:
		print("Burst")
		is_bursting = true
		burst_timer = burst_timer_max
		has_burst = false
		
	
	#Bursting
	if is_bursting:
		burst_timer -= delta
		if  burst_timer <= 0:
			is_bursting = false
			has_burst = true
	
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir = Input.get_vector("Left", "Right", "Forward", "Backward")
	var direction = lerp(direction ,(transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized(),delta*lerp_speed)
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
		if is_bursting:
			velocity.x = direction.x * burst_velocity * burst_timer
			velocity.z = direction.z * burst_velocity * burst_timer
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)

	move_and_slide()