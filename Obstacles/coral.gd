extends StaticBody3D


@export var coral_damage = 2

# Called when the node enters the scene tree for the first time.
func _ready():
	pass



func _on_area_3d_body_shape_entered(body_rid, body, body_shape_index, local_shape_index):
	if body is Player:
		Events.emit("player_took_damage",{"damage":coral_damage})
	else:
		pass
