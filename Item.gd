@tool
extends Node2D

@export var title: String
@export var sprite: Texture2D:
	set(value):
		sprite = value
		$Sprite2D.texture = value

func _ready() -> void:
	get_parent().set_editable_instance(self, true)
	$Pickable/CollisionShape2D.shape = $Pickable/CollisionShape2D.shape.duplicate()


func _on_area_2d_body_entered(body: Node2D) -> void:
	if(body.name == "Player"):
		var copy = self.duplicate()
		body.add_item(copy)
		queue_free()
