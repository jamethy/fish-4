extends Control
@onready var wriggle_count = $MarginContainer/HBoxContainer/VBoxContainer/WriggleCount
@onready var health_count = $MarginContainer/HBoxContainer/VBoxContainer/HealthCount
@onready var game_over = $GameOver



# Called when the node enters the scene tree for the first time.
func _ready():
	game_over.visible = false
	Events.player_wriggled.connect(_on_player_wriggled)
	Events.player_health_changed.connect(_on_player_health_changed)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _on_player_wriggled(d:Dictionary):
	wriggle_count.text = "Wriggles Remaining-%s" % d.bubble_count

func _on_player_health_changed(d:Dictionary):
	print("update")
	health_count.text = "Health - %s" % d.player_health
	if d.player_health <= 0:
		game_over.visible = true
