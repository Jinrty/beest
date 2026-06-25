@tool 
extends Area2D

@export var where:Area2D
@export var requires_item_use:bool = false

@export var requires_item_npc:bool = false
@export var npc_gate:Node2D = null
@export var refuse_line:String = ""

var inside:bool = false
var player:Node2D = null

const DOOR = preload("res://sprites/corridor2/door.png")

@export var sprite:Texture2D:
	set(value):
		sprite = value
		$Sprite2D.texture = value
	
	
func _process(delta: float) -> void:
	if(inside == true and Input.is_action_just_pressed("interact")):
		if(player == null):
			return
		if(requires_item_use == false) and (requires_item_npc == false):
			player.teleport(where)
			return
		
		if(requires_item_use == true):
			if(player.item_name() == "Crowbar"):
				$Sprite2D.texture = DOOR
				player.say("Yeah!")
				requires_item_use = false
			else:
				player.say("I can't go here!")
				
		elif(requires_item_npc == true):
			if(player.item_name() == "Gentleman hat"):
				player.teleport(where)
			else:
				npc_gate.get_node("DialogueComponent").say(refuse_line)
			
		
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
