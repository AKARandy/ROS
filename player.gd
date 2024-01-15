extends CharacterBody2D

const speed = 200

@onready var _animated_sprite = $AnimatedSprite2D

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
	
	if Global.role == "rock":
		_animated_sprite.play("idle_rock")
	if Global.role == "paper":
		_animated_sprite.play("idle_paper")
	if Global.role == "scissor":
		_animated_sprite.play("idle_scissor")
	move_and_slide()
