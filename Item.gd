@tool
extends Node2D

var size_of_sway:float = 5.0

@export var title: String
@export var sprite: Texture2D:
	set(value):
		sprite = value
		$Sprite2D.texture = value

func _ready() -> void:
	get_parent().set_editable_instance(self, true)
	$Pickable/CollisionShape2D.shape = $Pickable/CollisionShape2D.shape.duplicate()
	
func _physics_process(delta: float) -> void:
	var smth = $Timer.time_left * 2.5
	var target = sin(2 * smth) / 2 * size_of_sway;
	$Sprite2D.position.y = lerp($Sprite2D.position.y, target, 5 * delta)

func _on_area_2d_body_entered(body: Node2D) -> void:
	if(body.name == "Player"):
		var copy = self.duplicate()
		body.add_item(copy)
		queue_free()
