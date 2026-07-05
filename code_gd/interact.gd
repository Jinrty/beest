@tool
extends Area2D

@export var answer:String
@export var sprite:Texture2D:
	set(value):
		$Sprite2D.texture = value
@export var already_has_line:String

var inside:bool = false
var player:Node2D

func send_signal() -> void:
	for i in get_children():
		if i.has_method("on_interact"):
			i.on_interact()

func _process(delta: float) -> void:
	if(inside == true and Input.is_action_just_pressed("interact")):
		if(has_node("Item holder_component")):
			send_signal()
			return
		player.say(answer)
		

func _on_body_entered(body: Node2D) -> void:
	if(body.name == "Player"):
		inside = true
		player = body
		var mat = ShaderMaterial.new()
		mat.shader = load("res://shaders/itemOutline.gdshader")
		$Sprite2D.material = mat

func _ready() -> void:
	get_parent().set_editable_instance(self, true)
	$CollisionShape2D.shape = $CollisionShape2D.shape.duplicate()
	

func _on_body_exited(body: Node2D) -> void:
	if(body.name == "Player"):
		inside = false
		player = body
		$Sprite2D.material = null
		
		
		
