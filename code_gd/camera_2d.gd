extends Camera2D

enum Type {
	Still,
	Movable_x,
	Movable_y
}

var player:Node2D = null
@export var type:Type
@export var cheat:bool = false

var move_x:bool = false
var offset_x:float = 0
var move_y:bool = false
var offset_y:float = 0
var direction:String = ""

var stop_r:bool = false
var stop_l:bool = false
var stop_n:bool = false

func _physics_process(delta: float) -> void:
	if(move_x == true):
		if(direction == "left" and player.velocity.x < 0):
			if stop_l:
				return
			global_position.x = player.position.x + offset_x
		elif(direction == "right" and player.velocity.x > 0):
			if stop_r:
				return
			global_position.x = player.position.x + offset_x
	elif(move_y == true):
		if(direction == "down" and player.velocity.y > 0):
			global_position.y = player.position.y + offset_y
		elif(direction == "up" and player.velocity.y < 0):
			print(self.get_path(), " | physics_process: ", stop_n)
			if stop_n:
				return
			global_position.y = player.position.y + offset_y
	
		
		

func _on_area_2d_body_entered(body: Node2D) -> void:
	if(body.name == "Player"):
		make_current()
		if(self.cheat == true and Flags.blue_rom_quest_completed == true):
			get_tree().change_scene_to_file("res://scenes/ending.tscn")


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


func _on_top_body_exited(body: Node2D) -> void:
	if(body.name == "Player") and type == Type.Movable_y:
		move_y = false


func _on_wewe_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		var vert = get_parent().get_node_or_null("VerticalCamera")
		if vert != null:
			vert.make_current()
			vert.global_position.x = body.global_position.x


func _on_pierd_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		print("Help")
		var vert = get_node_or_null("../../Rand_room/Camera2D")
		if vert != null:
			vert.make_current()
			vert.global_position.y = body.global_position.y - 50
			print("HUH")




func _on_stop_r_body_entered(body: Node2D) -> void:
	if(body.name == "Player"):
		player = body
		stop_r = true


func _on_stop_r_body_exited(body: Node2D) -> void:
	if(body.name == "Player"):
		stop_r = false


func _on_stop_l_body_entered(body: Node2D) -> void:
	if(body.name == "Player"):
		player = body
		stop_l = true

func _on_stop_l_body_exited(body: Node2D) -> void:
	if(body.name == "Player"):
		stop_l = false


func _on_stop_n_body_entered(body: Node2D) -> void:
	if(body.name == "Player"):
		player = body
		stop_n = true
		print(self.get_path(), " | entered!")
		print(stop_n)


func _on_stop_n_body_exited(body: Node2D) -> void:
	if(body.name == "Player"):
		stop_n = false
		pass
