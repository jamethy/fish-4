extends Control
@onready var wiggle_count = $MarginContainer/HBoxContainer/VBoxContainer/WiggleCount
@onready var heart_container = $MarginContainer/HBoxContainer/VBoxContainer/HeartContainer


@export var health_full:AtlasTexture
@export var health_empty:AtlasTexture
var max_health:int = 5
var current_health:int


# Called when the node enters the scene tree for the first time.
func _ready():
	Events.player_wiggled.connect(_on_player_wiggled)
	Events.player_health_changed.connect(_on_player_health_changed)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _on_player_wiggled(d:Dictionary):
	wiggle_count.text = "Wiggles Remaining-%s" % d.bubble_count

func _on_player_health_changed(d:Dictionary):
	current_health = d.player_health
	for child in heart_container.get_children():
		child.queue_free()
	for i in max_health:
		var heart = TextureRect.new()
		if i < current_health:
			heart.texture = health_full
		else:
			heart.texture = health_empty
		
		heart_container.add_child(heart)
