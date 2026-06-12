@tool
extends Area2D

func _on_body_entered(body: Node2D) -> void:
	if (body.name == "Player") and body.velocity.y > 50:
		body.velocity.y = -700
		body.time_in_air = 0
		

func _ready() -> void:
	get_parent().set_editable_instance(self, true)
