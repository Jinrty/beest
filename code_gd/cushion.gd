@tool
extends Area2D

@export var number:int

func _on_body_entered(body: Node2D) -> void:
	if (body.name == "Player") and body.velocity.y > 50:
		if(number == 1):
			$Sprite2D.play("set1")
		elif(number == 2):
			$Sprite2D.play("set2")
		elif(number == 3):
			$Sprite2D.play("set3")
			body.velocity.y = -1150
			body.time_in_air = 0
			return
		body.velocity.y = -700
		body.time_in_air = 0
		

func _ready() -> void:
	get_parent().set_editable_instance(self, true)
