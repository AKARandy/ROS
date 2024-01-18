extends CharacterBody2D

var chase = false
const speed = 100
var the_chased = null

const CENTER = Vector2(450,300)
enum {FLEEING, ROAMING}
var state = ROAMING
var body_to_flee_from : Vector2
var random_target_pos : Vector2 = Vector2(450,300)

func _physics_process(delta):
	if chase == true:
		var direction = (the_chased - self.position).normalized()
		velocity.x = direction.x * speed
		velocity.y = direction.y * speed
		
	if chase == false:
		match state:
			FLEEING:
				position -= position.direction_to(body_to_flee_from) * speed * delta
			ROAMING:
				if position.distance_to(random_target_pos) <= speed * delta:
					random_target_pos = CENTER + Vector2(0,300).rotated(randf() * 2 * PI)
				else:
					position += position.direction_to(random_target_pos) * speed * delta
	
	move_and_slide()

func _on_player_detection_body_entered(body):
	if body.name == "player":
		if EntityRoles.role == EntityRoles.Roles.ROCK:
			the_chased = body.position
			chase = true
		if EntityRoles.role == EntityRoles.Roles.SCISSOR:
			chase = false
			the_chased = null
			state = FLEEING
			body_to_flee_from = body.position
	if body.name == "ai_rock":
		the_chased = body.position
		chase = true
	if body.name == "ai_scissor":
		chase = false
		the_chased = null
		state = FLEEING
		body_to_flee_from = body.position

func _on_player_detection_body_exited(body):
	if body.name == "player":
		if EntityRoles.role == EntityRoles.Roles.ROCK:
			chase = false
			the_chased = null
		if EntityRoles.role == EntityRoles.Roles.SCISSOR:
			state = ROAMING
			random_target_pos = position
	if body.name == "ai_rock":
		chase = false
		the_chased = null
	if body.name == "ai_scissor":
		state = ROAMING
		random_target_pos = position


func _on_player_death_body_entered(body):
	if body.name == "player":
		if EntityRoles.role == EntityRoles.Roles.SCISSOR:
			chase = false
			the_chased = null
			self.queue_free()
	if body.name == "ai_scissor":
		chase = false
		the_chased = null
		self.queue_free()
