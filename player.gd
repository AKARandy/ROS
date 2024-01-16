extends CharacterBody2D

const speed = 200
const accel = 1500
const friction = 600
var input = Vector2.ZERO
var score = 0

@onready var _animated_sprite = $AnimatedSprite2D

func _physics_process(delta):
	player_movement(delta)
	if Global.role == "rock":
		_animated_sprite.play("idle_rock")
	elif Global.role == "paper":
		_animated_sprite.play("idle_paper")
	elif Global.role == "scissor":
		_animated_sprite.play("idle_scissor")

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

func increase_score():
	score += 1
	print("Score: ", score)

func _on_area_2d_body_entered(body):
	if Global.role == "paper":
		if body.name == "ai_rock":
			increase_score()
			body.queue_free()
	if Global.role == "rock":
		if body.name == "ai_scissor":
			increase_score()
			body.queue_free()
	if Global.role == "scissor":
		if body.name == "ai_paper":
			increase_score()
			body.queue_free()
