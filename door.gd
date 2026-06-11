extends Sprite2D

@export var where:Node2D

var inside:bool = false
var player:Node2D = null

func _on_area_2d_body_entered(body: Node2D) -> void:
	if(body.name == "Player"):
		inside = true
		player = body
		
func _on_area_2d_body_exited(body: Node2D) -> void:
	if(body.name == "Player"):
		inside = false
		player = body


func _process(delta: float) -> void:
	if(inside == true and Input.is_action_just_pressed("interact")):
		player.teleport(where)
