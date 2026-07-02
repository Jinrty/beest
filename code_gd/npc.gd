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
			$Sprite2D.material = null


func _ready() -> void:
	get_parent().set_editable_instance(self, true)
	$CollisionShape2D.shape = $CollisionShape2D.shape.duplicate()

func _process(delta: float) -> void:
	if(inside == true and Input.is_action_just_pressed("interact") and player.can_move == true):
		interact()
	

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


func _on_player_changed_item() -> void:
	if(self.name == "Pink Shortie") and (player != null):
		if(player.item_name() != "Gentleman hat"):
			interact()
