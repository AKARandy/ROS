extends CharacterBody2D

const speed = 200
const accel = 1500
const friction = 600
var input = Vector2.ZERO
var role

func _physics_process(delta):
	player_movement(delta)

func get_input():
	input = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	return input.normalized()

func player_movement(delta):
	input = get_input()
	
	if input == Vector2.ZERO:
		if (velocity.length() > friction * delta):
			velocity -= velocity.normalized() * (friction * delta)
		else:
			velocity = Vector2.ZERO 
	else:
		velocity += (input * accel * delta)
		velocity = velocity.limit_length(speed)
	
	move_and_slide()
