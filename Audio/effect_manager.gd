extends Node
class_name EffectManager

var sound_effects:Array = [preload("res://Audio/Sound Effects/N-Water_01.ogg"), preload("res://Audio/Sound Effects/N-Water_02.ogg"), preload("res://Audio/Sound Effects/N-Water_03.ogg"), preload("res://Audio/Sound Effects/N-Water_04.ogg"), preload("res://Audio/Sound Effects/N-Water_05.ogg"), preload("res://Audio/Sound Effects/N-Water_06.ogg"), preload("res://Audio/Sound Effects/N-Water_07.ogg"), preload("res://Audio/Sound Effects/N-Water_08.ogg"), preload("res://Audio/Sound Effects/N-Water_09.ogg"), preload("res://Audio/Sound Effects/N-Water_10.ogg")]

func sellect_effect() -> AudioStreamOggVorbis:
	var effect = sound_effects.pick_random()
	print()
	return effect
