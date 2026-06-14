@tool
extends Area2D

@export var number:int

func _on_body_entered(body: Node2D) -> void:
	if (body.name == "Player") and body.velocity.y > 50:
		if(number == 1):
			$Sprite2D.play("set1")
		else:
			$Sprite2D.play("set2")
		body.velocity.y = -700
		body.time_in_air = 0
		

func _ready() -> void:
	get_parent().set_editable_instance(self, true)
