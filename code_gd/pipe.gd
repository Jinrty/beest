@tool
extends Node2D

@export var where:Node2D

var player:Node2D = null

func _ready() -> void:
	get_parent().set_editable_instance(self, true)
	$Area2D/CollisionShape2D.shape = $Area2D/CollisionShape2D.shape.duplicate()
	$StaticBody2D/CollisionShape2D.shape = $StaticBody2D/CollisionShape2D.shape.duplicate()

func _on_area_2d_body_entered(body: Node2D) -> void:
	if(body.name == "Player") and (Flags.pipe_block == false):
		player = body
		var wherewhere = where.get_node("Exit")
		player.teleport(wherewhere)
		Flags.pipe_block = true
		$CanPass.start()
		  


func _on_can_pass_timeout() -> void:
	Flags.pipe_block = false
