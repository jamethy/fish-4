extends Camera3D


@export var lerp_speed = 3.0
@export var target: Node3D
@export var offset = Vector3.ZERO



#func _ready():
	#Events.screen_shake.connect(_screen_shake)

func _physics_process(delta):
	if !target:
		return

	var target_xform = target.global_transform.translated_local(offset)
	global_transform = global_transform.interpolate_with(target_xform, lerp_speed * delta)

	look_at(target.global_transform.origin, target.transform.basis.y)

#func _screen_shake(d:Dictionary):
	#var amp = d.amplitude
	#var rand = Vector2()
	#rand.x = randf_range(-amp,amp)
	#rand.y = randf_range(-amp,amp)
	#
	#var shake_tween = get_tree().create_tween().set_trans(Tween.TRANS_LINEAR).set_ease(Tween.EASE_OUT)
	#shake_tween.tween_property(self,"frustum_offset",rand,d.duration)
