extends CharacterBody3D
class_name Player

@onready var bubble_timer = $BubbleTimer
@onready var fish_model = $FishModel
@onready var i_frame_timer = $IFrameTimer
@onready var animation_player = $AnimationPlayer

const BUBBLE = preload("res://Player/bubble.tscn")

#Speed Variables
var lerp_speed = 8.0
@export_range(0,20,.5) var SPEED = 5.0
#const JUMP_VELOCITY = 4.5

#Health Variables
var health_max = 5
var health_current:int

#Bursting Variables
var has_burst = true
var is_bursting = false
var burst_timer = 0.0
@export_range(0,5,.1) var burst_timer_max:float = 3.0
@export_range(0,100,1) var burst_velocity:float = 5.0
var burst_vector = Vector2.ZERO

@export_range(0.001, 0.05) var fish_impact_force: float = 0.007

#Bubble
var has_bubble = true
@export var bubble_count:int = 5
@export_range(0,5.0,.5) var bubble_timout:float = 5.0

#Input Variables
var direction = Vector3.ZERO
var mouse_sensitivity = 0.2

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

func _ready():
	_set_health()
	Events.player_took_damage.connect(_update_health)


func  _unhandled_input(event):
	if event is InputEventMouseMotion:
		rotate_y(deg_to_rad(event.relative.x * mouse_sensitivity * -1))
	if Input.is_action_just_pressed("Bubble") and has_bubble and bubble_count > 0:
		_create_bubble()
	

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
		if  burst_timer <= 1:
			is_bursting = false
			has_burst = true
	
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir = Input.get_vector("Left", "Right", "Forward", "Backward")
	var direction = lerp(direction ,(transform.basis * Vector3(input_dir.x, 0, -input_dir.y)).normalized(),delta*lerp_speed)
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
		if is_bursting:
			velocity.x = direction.x * burst_velocity * burst_timer
			velocity.z = direction.z * burst_velocity * burst_timer
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)

	# TODO why can't I trust velocity
	var previous_pos = position
	move_and_slide()
	
	if get_slide_collision_count() == 0:
		return
	var speed = ((position - previous_pos) / delta).length()
	
	for i in get_slide_collision_count():
		var c = get_slide_collision(i)
		if c.get_collider() is RigidBody3D:
			if c.get_collider().name == "GoalFish":
				Events.emit("player_found_goal_fish")
			c.get_collider().apply_central_impulse(-c.get_normal() * speed * fish_impact_force)

func  _create_bubble():
	has_bubble = false
	bubble_count -= 1
	Events.emit("player_wiggled",{"player_pos":self.global_position,"bubble_count":bubble_count})
	animation_player.play("Wiggle")
	bubble_timer.wait_time = bubble_timout
	bubble_timer.start()
	var scene = BUBBLE.instantiate()
	self.add_child(scene)
	Effects._play_random_fx()
	

func _on_bubble_timer_timeout():
	has_bubble = true
	print("has bubble")

func _set_health():
	health_current = health_max
	Events.emit("player_health_changed",{"player_health":health_current})

func _update_health(d:Dictionary):
	if i_frame_timer.is_stopped():
		i_frame_timer.start()
		health_current -= d.damage
		animation_player.play("damage")
		var backward = global_transform.origin - (self.basis.z * 2)
		var damage_tween = get_tree().create_tween().set_trans(Tween.TRANS_LINEAR).set_ease(Tween.EASE_OUT)
		damage_tween.tween_property(self,"global_transform:origin",backward,.2)
		Events.emit("player_health_changed",{"player_health":health_current})
	


