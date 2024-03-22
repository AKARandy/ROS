extends CharacterBody2D

const ENTITY_TYPE = EntityRoles.Roles.PAPER
const ENTITY_TEAM = EntityRoles.Team.Red

var chase = false
const speed = 150
var the_chased = null

const CENTER = Vector2(450,300)
enum {FLEEING, ROAMING}
var state = ROAMING
var body_to_flee_from : Vector2
var random_target_pos : Vector2 = Vector2(450,300)

var stuck_timer: float = 0.0

func _physics_process(delta):
	var target_velocity = Vector2.ZERO

	if chase:
		target_velocity = (the_chased - self.position).normalized() * speed
	else:
		match state:
			FLEEING:
				target_velocity = -position.direction_to(body_to_flee_from) * speed
				if is_stuck(target_velocity, delta):
					state = ROAMING
					random_target_pos = Vector2(
						randf_range(0.0, get_viewport_rect().size.x),
						randf_range(0.0, get_viewport_rect().size.y)
					)
			ROAMING:
				stuck_timer += delta
				if position.distance_to(random_target_pos) <= speed * delta:
					random_target_pos = Vector2(
						randf_range(0.0, get_viewport_rect().size.x),
						randf_range(0.0, get_viewport_rect().size.y)
					)
					stuck_timer = 0.0  # Reset the stuck timer
				elif is_stuck(target_velocity, delta):
					random_target_pos = Vector2(
						randf_range(0.0, get_viewport_rect().size.x),
						randf_range(0.0, get_viewport_rect().size.y)
					)
					stuck_timer = 0.0
				else:
					target_velocity = position.direction_to(random_target_pos) * speed

	velocity = lerp(velocity, target_velocity, delta * 10.0)
	move_and_slide()

	# Clamp the mob's position within the game area
	position.x = clamp(position.x, 0.0, get_viewport_rect().size.x)
	position.y = clamp(position.y, 0.0, get_viewport_rect().size.y)

func is_stuck(target_velocity: Vector2, delta: float) -> bool:
	stuck_timer += delta
	if stuck_timer > 1.0 and target_velocity.length() < 1.0:
		return true
	return false

func _on_player_detection_body_entered(body):
	if body.has_method("get_entity_type") && body.has_method("get_entity_team"):
		var entity_type = body.get_entity_type()
		var entity_team = body.get_entity_team()
		if entity_team == EntityRoles.Team.Blue: 
			if entity_type == EntityRoles.Roles.ROCK:
				the_chased = body.position
				chase = true
			if entity_type == EntityRoles.Roles.SCISSOR:
				chase = false
				the_chased = null
				state = FLEEING
				body_to_flee_from = body.position

func _on_player_detection_body_exited(body):
	if body.has_method("get_entity_type") && body.has_method("get_entity_team"):
		var entity_type = body.get_entity_type()
		var entity_team = body.get_entity_team()
		if entity_team == EntityRoles.Team.Blue: 
			if entity_type == EntityRoles.Roles.ROCK:
				chase = false
				the_chased = null
			if entity_type == EntityRoles.Roles.SCISSOR:
				state = ROAMING
				random_target_pos = position


func _on_player_death_body_entered(body):
	if body.has_method("get_entity_type") && body.has_method("get_entity_team"):
		var entity_type = body.get_entity_type()
		var entity_team = body.get_entity_team()
		if entity_team == EntityRoles.Team.Blue: 
			if entity_type == EntityRoles.Roles.SCISSOR:
				chase = false
				the_chased = null
				self.queue_free()
				Tracker.redPaper -= 1
func get_entity_type():
	return ENTITY_TYPE

func get_entity_team():
	return ENTITY_TEAM
