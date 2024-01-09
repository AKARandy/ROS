extends CharacterBody2D

const speed = 200
var role

func _physics_process(delta):
	if Input.is_action_pressed("ui_right"):
		velocity.x = speed
		velocity.y = 0
	elif Input.is_action_pressed("ui_left"):
		velocity.x = -speed
		velocity.y = 0
	elif Input.is_action_pressed("ui_up"):
		velocity.x = 0
		velocity.y = -speed
	elif Input.is_action_pressed("ui_down"):
		velocity.x = 0
		velocity.y = speed
	else:
		velocity.x = 0
		velocity.y = 0
	
	move_and_slide()
	
