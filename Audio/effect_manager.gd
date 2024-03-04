extends Node
class_name EffectManager


var music_theme = preload("res://Audio/Underwater_Theme.wav")
var sound_effects:Array = [preload("res://Audio/Sound Effects/N-Water_01.ogg"), preload("res://Audio/Sound Effects/N-Water_02.ogg"),  preload("res://Audio/Sound Effects/N-Water_04.ogg"),  preload("res://Audio/Sound Effects/N-Water_06.ogg"), preload("res://Audio/Sound Effects/N-Water_07.ogg")]
@onready var music_player = $MusicPlayer

func _ready():
	pass

func _play_random_fx():
	var effect = sound_effects.pick_random()
	var new_audio_player = AudioStreamPlayer3D.new()
	self.add_child(new_audio_player)
	var audio_player = self.get_child(0)
	audio_player.stream = effect
	audio_player.pitch_scale= randf_range(.4,1.4)
	audio_player.play()
	await audio_player.finished
	audio_player.queue_free()
#


func _play_wind():
	var effect = preload("res://Audio/Sound Effects/N-Wind_01.ogg")
	var new_audio_player = AudioStreamPlayer3D.new()
	self.add_child(new_audio_player)
	var audio_player = self.get_child(0)
	audio_player.stream = effect
	audio_player.pitch_scale= randf_range(.4,1.4)
	audio_player.play()
	await audio_player.finished
	audio_player.queue_free()
#func _play_music():
	#music_player.play()
	#
	
