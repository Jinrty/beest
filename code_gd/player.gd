extends CharacterBody2D

signal changed_item

const SPEED:float = 320.0
const JUMP_VELOCITY:float = -500.0
var can_jump:bool = true
var proccesing_coyote:bool = false
var already_on_floor:bool = false
var buffer_jump:bool = false
var gravity:int = 1700
var time_in_air:float = 0.0
var direction:int
var jump_pause:bool = false
var can_move:bool = true

var inventory:Array = ["Nothing"]
var current_item:int = 0


func take_input() -> void:
	if (can_move == false):
		return
	
	if Input.is_action_just_pressed("change_item"):
		change_item()
		
	direction = Input.get_axis("move_left", "move_right")

	if Input.is_action_pressed("jump"):
		if can_jump == true:
			jump()
		elif not is_on_floor():
			$Jump_buffering.start()
			buffer_jump = true
	
func add_item(item):
	inventory.append(item)
	current_item = inventory.size() -1
	hold_item(item)
	say(item.title, 80, 1.5)

func hold_item(item):
	$Holded_item.visible = true
	$Holded_item.texture = item.sprite

func item_name() -> String:
	if(current_item == 0):
		return ""
	else:
		return inventory[current_item].title

func change_item():
	if (inventory.is_empty()):
		return
	if (current_item == inventory.size() - 1):
		current_item = 0
	else:
		current_item += 1
	
	if(current_item != 0):
		hold_item(inventory[current_item])
		ui_item_name(item_name())
	else:
		$Holded_item.visible = false
	changed_item.emit()
		
func ui_item_name(item_title:String):
	$UI/Item_name.start()
	$"UI/Item title".text = item_title
	
	
func say(text: String, speed: float = 40, wait:float = 2):
	$Sprite2D.visible = true
	$Text.visible = true
	$Text.text = text
	$Speach.stop()
	
	if(text.length() < 12):
		$Text.add_theme_font_size_override("font_size", 20)
	else:
		$Text.add_theme_font_size_override("font_size", 12)
	
	for i in text.length() + 1:
		$Text.visible_characters = i
		await get_tree().create_timer(1 / speed).timeout
		
	$Speach.wait_time = wait
	$Speach.start()

func shut_up():
	$Sprite2D.visible = false
	$Text.visible = false
	


func jump() -> void:
	if(jump_pause == false):
		buffer_jump = false
		velocity.y = JUMP_VELOCITY
		can_jump = false
		already_on_floor = false
		
		
func teleport(where) -> void:
	global_position = where.global_position

func animate_player():
	if(velocity.x > 0):
		$Player_sprite.flip_h = false
	elif(velocity.x < 0):
		$Player_sprite.flip_h = true
	if(velocity.y < 0):
		$Player_sprite.animation = "jump"
	elif(velocity.y > 0):
		$Player_sprite.animation = "fall"
	else:
		if(velocity.x == 0):
			$Player_sprite.animation = "standing"
		else:
			$Player_sprite.animation = "walk"
		
	

func _physics_process(delta: float) -> void:
	take_input()
	animate_player()

	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	if not is_on_floor():

		time_in_air += delta / 2.5
		velocity.y += gravity * delta * (1.0 + time_in_air * 0.5)

		if proccesing_coyote == false:
			$Coyot.start()
			proccesing_coyote = true
			already_on_floor = false
		
	if is_on_floor():
		if(jump_pause == false):
			jump_pause = true
			$Pause_in_jumps.start()
		can_jump = true
		time_in_air = 0
		proccesing_coyote = false
		already_on_floor = true
		if buffer_jump == true:
			jump()
			$Jump_buffering.stop()
	
	move_and_slide()

func _on_coyot_timeout() -> void:
	can_jump = false

func _on_jump_buffering_timeout() -> void:
	buffer_jump = false

func _on_pause_in_jumps_timeout() -> void:
	jump_pause = false

func _on_item_name_timeout() -> void:
	$"UI/Item title".text = ""


func _on_speach_timeout() -> void:
	shut_up()
