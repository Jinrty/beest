extends Node2D
class_name DialogueComponent

@export var lines:Array[DialogueLine] = []

var current_path:int 
var player:Node2D
var path_chosen:bool = false
var lines_array:Array = []
var item_give:Node2D
var item_remove:String
var if_remove:bool

var imp_var:bool

func on_interact() -> void:
	shut_up()
	player = get_parent().player
	lines_array = []
	item_give = null
	
	for x in lines:
		if(path_chosen == false):
			if(check_requirment(x.requirement, x.condition)):
				current_path = x.path
				path_chosen = true
		if(current_path == x.path) and (path_chosen == true) and check_requirment(x.requirement, x.condition):
			lines_array.append(x.line)
			Flags.set(x.variable, !Flags.get(x.variable))
			if(x.item != null):
				item_give = get_node(x.item)
				item_remove = x.requirement
				if_remove = x.taking_item
				imp_var = x.imp_var
	path_chosen = false
	get_parent().togle_collision()
	player.shut_up()
	for i in lines_array:
		await say(i)
	get_parent().togle_collision()
	
	if(imp_var):
		player.remove_item(item_remove)
		player.change_item()
	if(item_give != null):
		player.add_item(item_give)
		if(if_remove):
			player.remove_item(item_remove)
	#That is adding hover shader but it shouldnt be here
	var mat = ShaderMaterial.new()
	mat.shader = load("res://shaders/itemOutline.gdshader")
	get_parent().get_node("Sprite2D").material = mat

func check_requirment(req:String, cond:bool):
	if(req == ""):
		return true
	if(req == player.item_name()):
		return true 
	if(Flags.get(req) == cond):
		return true
	
	return false

func shut_up():
	$Sprite2D.visible = false
	$Text.visible = false

func say(text: String, speed: float = 40):
	$Sprite2D.visible = true
	$Text.visible = true
	$Text.text = text
	
	if(text.length() < 12):
		$Text.add_theme_font_size_override("font_size", 20)
	else:
		$Text.add_theme_font_size_override("font_size", 12)
	
	for i in text.length() + 1:
		$Text.visible_characters = i
		await get_tree().create_timer(1 / speed).timeout
		
	await get_tree().create_timer(2).timeout
	shut_up()
