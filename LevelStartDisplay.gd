extends Control


func show_for_level_start(level: int):
	$CenterContainer/LevelStartLabel.text = "LEVEL %d START" % level
	visible = true
	$Timer.start()
	

func _on_timer_timeout():
	visible = false
