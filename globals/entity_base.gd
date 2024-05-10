extends CharacterBody2D

@export var  ENTITY_TYPE: int = EntityRoles.Roles.UNKNOWN
@export var  ENTITY_TEAM: int = EntityRoles.Team.UNKNOWN

const SPEED: int = 100
const CENTER: Vector2 = Vector2(450, 300)

enum State { FLEEING, ROAMING }

var state: int = State.ROAMING
var chase: bool = false
var the_chased: Vector2 = Vector2.ZERO
var body_to_flee_from: Vector2 = Vector2.ZERO
var random_target_pos: Vector2 = CENTER
var stuck_timer: float = 0.0

func _physics_process(delta: float) -> void:
	var target_velocity: Vector2 = Vector2.ZERO

	if chase:
		target_velocity = (the_chased - position).normalized() * SPEED
	else:
		match state:
			State.FLEEING:
				target_velocity = -position.direction_to(body_to_flee_from) * SPEED
				if is_stuck(target_velocity, delta):
					state = State.ROAMING
					random_target_pos = Vector2(
						randf_range(0.0, get_viewport_rect().size.x),
						randf_range(0.0, get_viewport_rect().size.y)
					)
			State.ROAMING:
				stuck_timer += delta
				if position.distance_to(random_target_pos) <= SPEED * delta:
					random_target_pos = Vector2(
						randf_range(0.0, get_viewport_rect().size.x),
						randf_range(0.0, get_viewport_rect().size.y)
					)
					stuck_timer = 2  # Reset the stuck timer
				elif is_stuck(target_velocity, delta):
					random_target_pos = Vector2(
						randf_range(0.0, get_viewport_rect().size.x),
						randf_range(0.0, get_viewport_rect().size.y)
					)
					stuck_timer = 2
				else:
					target_velocity = position.direction_to(random_target_pos) * SPEED

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

func _on_player_detection_body_entered(body: Node) -> void:
	if body.has_method("get_entity_type") and body.has_method("get_entity_team"):
		var entity_type: int = body.get_entity_type()
		var entity_team: int = body.get_entity_team()
		if entity_team != ENTITY_TEAM:
			handle_body_entered(entity_type, body.position)

func _on_player_detection_body_exited(body: Node) -> void:
	if body.has_method("get_entity_type") and body.has_method("get_entity_team"):
		var entity_type: int = body.get_entity_type()
		var entity_team: int = body.get_entity_team()
		if entity_team != ENTITY_TEAM:
			handle_body_exited(entity_type)

func _on_player_death_body_entered(body: Node) -> void:
	if body.has_method("get_entity_type") and body.has_method("get_entity_team"):
		var entity_type: int = body.get_entity_type()
		var entity_team: int = body.get_entity_team()
		if entity_team != ENTITY_TEAM:
			handle_death(entity_type)

func handle_body_entered(_entity_type: int, _body_position: Vector2) -> void:
	# Subclasses should override this method to implement specific behavior
	pass

func handle_body_exited(_entity_type: int) -> void:
	# Subclasses should override this method to implement specific behavior
	pass

func handle_death(_entity_type: int) -> void:
	# Subclasses should override this method to implement specific behavior
	pass

func get_entity_type() -> int:
	return ENTITY_TYPE

func get_entity_team() -> int:
	return ENTITY_TEAM
