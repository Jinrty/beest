@tool
extends StaticBody2D

@export var sprite:Texture2D:
	set(value):
		sprite = value
		$Sprite2D.texture = value
		
		
func _ready() -> void:
	get_parent().set_editable_instance(self, true)
	$CollisionShape2D.shape = $CollisionShape2D.shape.duplicate()
