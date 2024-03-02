extends Node

signal player_found_goal_fish(d)
signal player_wriggled(d)
	#logs current player position to create bubble

func emit(signal_name: String, args: Dictionary = {}):
	log_signal(signal_name, args)
	emit_signal(signal_name, args)

func log_signal(signal_name: String, args: Dictionary):
	print("signal: %s " % signal_name, args)
