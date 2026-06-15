extends Node2D
class_name DialogueComponent

@export var lines:Array[String] = []

func on_interact() -> void:
	for i in lines:
		print(i)
