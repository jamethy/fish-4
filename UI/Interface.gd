extends Control
@onready var wiggle_count = $MarginContainer/HBoxContainer/VBoxContainer/WiggleCount
@onready var health_count = $MarginContainer/HBoxContainer/VBoxContainer/HealthCount
@onready var game_over = $GameOver



# Called when the node enters the scene tree for the first time.
func _ready():
	Events.player_wiggled.connect(_on_player_wiggled)
	Events.player_health_changed.connect(_on_player_health_changed)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _on_player_wiggled(d:Dictionary):
	wiggle_count.text = "Wiggles Remaining-%s" % d.bubble_count

func _on_player_health_changed(d:Dictionary):
	health_count.text = "Health - %s" % d.player_health
