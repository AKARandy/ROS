extends CharacterBody2D

const SPEED = 125
const ACCELERATION = 950
const FRICTION = 625

var score = 0

@onready var _animated_sprite = $AnimatedSprite2D

func _ready():
	idle_animated_sprite()

func _physics_process(delta):
	player_movement(delta)

func get_input():
	return Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down").normalized()

func player_movement(delta):
	var input = get_input()
	
	direction_animated_sprite(input)
	
	if input == Vector2.ZERO:
		velocity = velocity.move_toward(Vector2.ZERO, FRICTION * delta)
		run_animated_sprite() if velocity != Vector2.ZERO else idle_animated_sprite()
	else:
		velocity = velocity.move_toward(input * SPEED, ACCELERATION * delta)
		run_animated_sprite()

	move_and_slide()

func increase_score():
	score += 1
	print("Score: ", score)
	
func idle_animated_sprite():
	var animations = {
		EntityRoles.Roles.ROCK: "idle_rock",
		EntityRoles.Roles.PAPER: "idle_paper",
		EntityRoles.Roles.SCISSOR: "idle_scissor"
	}
	
	if EntityRoles.role in animations.keys():
		_animated_sprite.play(animations[EntityRoles.role])
		
func run_animated_sprite():
	var animations = {
		EntityRoles.Roles.ROCK: "run_rock",
		EntityRoles.Roles.PAPER: "run_paper",
		EntityRoles.Roles.SCISSOR: "run_scissor"
	}
	
	if EntityRoles.role in animations.keys():
		_animated_sprite.play(animations[EntityRoles.role])

func direction_animated_sprite(direction):
	if direction < Vector2.ZERO:
		_animated_sprite.flip_h = false
	elif direction > Vector2.ZERO:
		_animated_sprite.flip_h = true

func _on_area_2d_body_entered(body):
	var valid_combinations = {
		EntityRoles.Roles.PAPER: "ai_rock",
		EntityRoles.Roles.ROCK: "ai_scissor",
		EntityRoles.Roles.SCISSOR: "ai_paper"
	}
	if EntityRoles.role in valid_combinations.keys() and body.name == valid_combinations[EntityRoles.role]:
		increase_score()

func get_entity_type():
	return EntityRoles.role
