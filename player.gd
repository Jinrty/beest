extends CharacterBody2D

const SPEED:float = 350.0
const JUMP_VELOCITY:float = -500.0
var can_jump:bool = true
var proccesing_coyote:bool = false
var already_on_floor:bool = false
var buffer_jump:bool = false
var gravity:int = 1700
var time_in_air:float = 0.0
var direction:int
var jump_pause:bool = false

func take_input() -> void:
	direction = Input.get_axis("move_left", "move_right")

	if Input.is_action_pressed("jump"):
		if can_jump == true:
			jump()
		elif not is_on_floor():
			$Jump_buffering.start()
			buffer_jump = true
	

func jump() -> void:
	if(jump_pause == false):
		buffer_jump = false
		velocity.y = JUMP_VELOCITY
		can_jump = false
		already_on_floor = false


func _physics_process(delta: float) -> void:
	take_input()

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
