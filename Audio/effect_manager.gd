extends Node
class_name EffectManager

var sound_effects:Array = [preload("res://Audio/Sound Effects/N-Water_01.ogg"), preload("res://Audio/Sound Effects/N-Water_02.ogg"),  preload("res://Audio/Sound Effects/N-Water_04.ogg"),  preload("res://Audio/Sound Effects/N-Water_06.ogg"), preload("res://Audio/Sound Effects/N-Water_07.ogg")]

func _ready():
	pass

func _play_fx():
	var effect = sound_effects.pick_random()
	var new_audio_player = AudioStreamPlayer3D.new()
	self.add_child(new_audio_player)
	var audio_player = self.get_child(0)
	audio_player.stream = effect
	audio_player.play()
	await audio_player.finished
	audio_player.queue_free()

func sellect_effect() -> AudioStreamOggVorbis:
	var effect = sound_effects.pick_random()
	print()
	return effect
