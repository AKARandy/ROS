extends EntityBase

func _init() -> void:
	ENTITY_TYPE = EntityRoles.Roles.SCISSOR
	ENTITY_TEAM = EntityRoles.Team.Blue

func handle_body_entered(entity_type: int, body_position: Vector2) -> void:
	if entity_type == EntityRoles.Roles.PAPER:
		the_chased = body_position
		chase = true
	elif entity_type == EntityRoles.Roles.ROCK:
		chase = false
		the_chased = Vector2.ZERO
		state = State.FLEEING
		body_to_flee_from = body_position

func handle_body_exited(entity_type: int) -> void:
	if entity_type == EntityRoles.Roles.PAPER:
		chase = false
		the_chased = Vector2.ZERO
	elif entity_type == EntityRoles.Roles.ROCK:
		state = State.ROAMING
		random_target_pos = position

func handle_death(entity_type: int) -> void:
	if entity_type == EntityRoles.Roles.ROCK:
		chase = false
		the_chased = Vector2.ZERO
		queue_free()
		Tracker.blueScissor -= 1
