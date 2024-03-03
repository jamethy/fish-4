extends Node

signal player_found_goal_fish(d)
signal player_wriggled(d)
#wriggle count
signal player_took_damage(d)
#damage
signal player_health_changed(d)
#health_current
signal screen_shake(d)
#duration,frequency,amplitude(PIXELS)

func emit(signal_name: String, args: Dictionary = {}):
	log_signal(signal_name, args)
	emit_signal(signal_name, args)

func log_signal(signal_name: String, args: Dictionary):
	print("signal: %s " % signal_name, args)
