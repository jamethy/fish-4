extends Node3D
class_name Bubble

@onready var bubble = $CSGSphere3D
@onready var bubble_life:float 
@onready var bubble_life_max = .3
@onready var bubble_speed = .3

func _ready():
	bubble_life = bubble_life_max

func _physics_process(delta):
	bubble_life -= delta
	bubble.radius += bubble_speed
	if bubble_life <= 0:
		print("bubble pop")
		queue_free()

