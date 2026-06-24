@tool
extends StaticBody2D

@export var sprite:Texture2D:
	set(value):
		sprite = value
		$Sprite2D.texture = value

func send_signal() -> void:
	for i in get_children():
		if i.has_method("on_signal"):
			i.on_signal()
		
func _ready() -> void:
	get_parent().set_editable_instance(self, true)
	$CollisionShape2D.shape = $CollisionShape2D.shape.duplicate()
	$Area2D/CollisionShape2D.shape = $Area2D/CollisionShape2D.shape.duplicate()

func _on_area_2d_body_entered(body: Node2D) -> void:
	if(body.name == "Player") and (has_node("Levitating_component")):
		send_signal()
		print(body.velocity.y)
		#get_tree().paused = true
