extends CharacterBody2D

const speed = 200
var role

func _physics_process(delta):
	# Nolkan vektor kecepatan
	velocity = Vector2()  

	if Input.is_action_pressed("ui_right"):
		velocity.x += speed
	if Input.is_action_pressed("ui_left"):
		velocity.x -= speed
	if Input.is_action_pressed("ui_up"):
		velocity.y -= speed
	if Input.is_action_pressed("ui_down"):
		velocity.y += speed

	move_and_slide()
