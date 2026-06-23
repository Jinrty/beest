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
var move_y:bool = false
var offset_y:float = 0
var direction:String = ""


func _physics_process(delta: float) -> void:
	if(move_x == true):
		if(direction == "left" and player.velocity.x < 0):
			global_position.x = player.position.x + offset_x
		elif(direction == "right" and player.velocity.x > 0):
			global_position.x = player.position.x + offset_x
	if(move_y == true):
		if(direction == "down" and player.velocity.y > 0):
			global_position.y = player.position.y + offset_y
		elif(direction == "up" and player.velocity.y < 0):
			global_position.y = player.position.y + offset_y
		
		

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


func _on_down_body_entered(body: Node2D) -> void:
	if(body.name == "Player") and type == Type.Movable_y:
		direction = "down"
		player = body
		move_y = true
		offset_y = global_position.y - body.global_position.y


func _on_down_body_exited(body: Node2D) -> void:
	if(body.name == "Player") and type == Type.Movable_y:
		move_y = false


func _on_top_body_entered(body: Node2D) -> void:
	if(body.name == "Player") and type == Type.Movable_y:
		direction = "up"
		player = body
		move_y = true
		offset_y = global_position.y - body.global_position.y
		print("s")


func _on_top_body_exited(body: Node2D) -> void:
	if(body.name == "Player") and type == Type.Movable_y:
		move_y = false
