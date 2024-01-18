extends CharacterBody2D

var chase = false
const speed = 150
var the_chased

const CENTER = Vector2(450,300)
enum {FLEEING, ROAMING}
var state = ROAMING
var body_to_flee_from : CharacterBody2D
var random_target_pos : Vector2 = Vector2(450,300)

func _physics_process(delta):
	if chase == true:
		var direction = (the_chased.position - self.position).normalized()
		velocity.x = direction.x * speed
		velocity.y = direction.y * speed

	if chase == false:
		match state:
			FLEEING:
				position -= position.direction_to(body_to_flee_from.position) * speed * delta
			ROAMING:
				if position.distance_to(random_target_pos) <= speed * delta:
					random_target_pos = CENTER + Vector2(0,300).rotated(randf() * 2 * PI)
				else:
					position += position.direction_to(random_target_pos) * speed * delta
	
	move_and_slide()

func _on_player_detection_body_entered(body):
	if body.name == "player":
		if EntityRoles.role == EntityRoles.Roles.PAPER:
			the_chased = body
			chase = true
		if EntityRoles.role == EntityRoles.Roles.ROCK:
			chase = false
			state = FLEEING
			body_to_flee_from = body
	if body.name == "ai_paper":
		the_chased = body
		chase = true
	if body.name == "ai_rock":
		chase = false
		state = FLEEING
		body_to_flee_from = body

func _on_player_detection_body_exited(body):
	if body.name == "player":
		if EntityRoles.role == EntityRoles.Roles.PAPER:
			chase = false
		if EntityRoles.role == EntityRoles.Roles.ROCK:
			state = ROAMING
			random_target_pos = position
	if body.name == "ai_paper":
		chase = false
	if body.name == "ai_rock":
		state = ROAMING
		random_target_pos = position
