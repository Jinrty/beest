extends Camera2D

enum Type {
	Still,
	Movable_x,
	Movable_y
}

var player:Node2D = null
@export var type:Type

var move_x:bool = false
var offset_x:float = 0
var direction:String = ""


func _physics_process(delta: float) -> void:
	if(move_x == true):
		if(direction == "left" and player.velocity.x < 0):
			global_position.x = player.position.x + offset_x
		elif(direction == "right" and player.velocity.x > 0):
			global_position.x = player.position.x + offset_x

func _on_area_2d_body_entered(body: Node2D) -> void:
	if(body.name == "Player"):
		make_current()


func _on_left_body_entered(body: Node2D) -> void:
	if(body.name == "Player") and type == Type.Movable_x:
		direction = "left"
		player = body
		move_x = true
		offset_x = global_position.x - body.global_position.x


func _on_right_body_entered(body: Node2D) -> void:
	if(body.name == "Player") and type == Type.Movable_x:
		direction = "right"
		player = body
		move_x = true
		offset_x = global_position.x - body.global_position.x


func _on_left_body_exited(body: Node2D) -> void:
	if(body.name == "Player") and type == Type.Movable_x:
		move_x = false


func _on_right_body_exited(body: Node2D) -> void:
	if(body.name == "Player") and type == Type.Movable_x:
		move_x = false
