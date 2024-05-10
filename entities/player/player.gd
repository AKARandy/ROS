extends CharacterBody2D

const SPEED = 65
const ACCELERATION = 950
const FRICTION = 625

var score = 0

@onready var _animated_sprite = $AnimatedSprite2D
var paused = false

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
	if EntityRoles.team == EntityRoles.Team.Blue:
		var animations = {
			EntityRoles.Roles.ROCK: "blue_idle_rock",
			EntityRoles.Roles.PAPER: "blue_idle_paper",
			EntityRoles.Roles.SCISSOR: "blue_idle_scissor"
		}
		if EntityRoles.role in animations.keys():
			_animated_sprite.play(animations[EntityRoles.role])
			
	if EntityRoles.team == EntityRoles.Team.Red:
		var animations = {
			EntityRoles.Roles.ROCK: "red_idle_rock",
			EntityRoles.Roles.PAPER: "red_idle_paper",
			EntityRoles.Roles.SCISSOR: "red_idle_scissor"
		}
		if EntityRoles.role in animations.keys():
			_animated_sprite.play(animations[EntityRoles.role])
func run_animated_sprite():
	if EntityRoles.team == EntityRoles.Team.Blue:
		var animations = {
			EntityRoles.Roles.ROCK: "blue_run_rock",
			EntityRoles.Roles.PAPER: "blue_run_paper",
			EntityRoles.Roles.SCISSOR: "blue_run_scissor"
		}
		if EntityRoles.role in animations.keys():
			_animated_sprite.play(animations[EntityRoles.role])
	if EntityRoles.team == EntityRoles.Team.Red:
		var animations = {
			EntityRoles.Roles.ROCK: "red_run_rock",
			EntityRoles.Roles.PAPER: "red_run_paper",
			EntityRoles.Roles.SCISSOR: "red_run_scissor"
		}
		if EntityRoles.role in animations.keys():
			_animated_sprite.play(animations[EntityRoles.role])

func direction_animated_sprite(direction):
	if direction < Vector2.ZERO:
		_animated_sprite.flip_h = false
	elif direction > Vector2.ZERO:
		_animated_sprite.flip_h = true

func _on_area_2d_body_entered(body):
	var myRole_wdt = { #This is my role, i will die to...
		EntityRoles.Roles.PAPER: EntityRoles.Roles.SCISSOR,
		EntityRoles.Roles.ROCK: EntityRoles.Roles.PAPER,
		EntityRoles.Roles.SCISSOR: EntityRoles.Roles.ROCK
	}
	if body.has_method("get_entity_type") && body.has_method("get_entity_team"):
		var entity_type = body.get_entity_type()
		var entity_team = body.get_entity_team()
		if entity_team != EntityRoles.team: 
			if entity_type == myRole_wdt[EntityRoles.role]:
				self.queue_free()
				Tracker.playerDead = true
			elif entity_type != myRole_wdt[EntityRoles.role] and entity_type == EntityRoles.role:
				increase_score()

func get_entity_type():
	return EntityRoles.role

func get_entity_team():
	return EntityRoles.team
	
func _process(delta):
	pass
