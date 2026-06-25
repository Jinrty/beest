@tool 
extends Area2D

@export var where:Area2D

var inside:bool = false
var player:Node2D = null

@export var sprite:Texture2D:
	set(value):
		sprite = value
		$Sprite2D.texture = value
	
	
func _process(delta: float) -> void:
	if(inside == true and Input.is_action_just_pressed("interact")):
		player.teleport(where)
		
func _ready() -> void:
	get_parent().set_editable_instance(self, true)
	$CollisionShape2D.shape = $CollisionShape2D.shape.duplicate()


func _on_body_entered(body: Node2D) -> void:
	if(body.name == "Player"):
		inside = true
		player = body
		var mat = ShaderMaterial.new()
		mat.shader = load("res://shaders/itemOutline.gdshader")
		$Sprite2D.material = mat


func _on_body_exited(body: Node2D) -> void:
	if(body.name == "Player"):
		inside = false
		player = body
		$Sprite2D.material = null
