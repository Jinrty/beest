@tool
extends Area2D

@export var sprite:Texture2D:
	set(value):
		$Sprite2D.texture = value
		
var inside:bool = false
var player:Node2D

func interact() -> void:
	for i in get_children():
		if i.has_method("on_interact"):
			i.on_interact()


func _ready() -> void:
	get_parent().set_editable_instance(self, true)
	$CollisionShape2D.shape = $CollisionShape2D.shape.duplicate()

func _process(delta: float) -> void:
	if(inside == true and Input.is_action_just_pressed("interact")):
		interact()

func _on_body_entered(body: Node2D) -> void:
	if(body.name == "Player"):
		inside = true
		player = body


func _on_body_exited(body: Node2D) -> void:
	if(body.name == "Player"):
		inside = false
		player = body
