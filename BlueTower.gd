extends StaticBody2D
#blue tower\
var health = 3
@onready var anim = $AnimatedSprite2D
func _on_player_touched_body_entered(body):
		if body.has_method("get_entity_type") && body.has_method("get_entity_team"):
			var entity_type = body.get_entity_type()
			var entity_team = body.get_entity_team()
			if entity_team == EntityRoles.Team.Red: 
				body.position = Vector2(250, 950)
				health -=1
func _process(delta):
	if health == 3:
		anim.play("full")
	if health == 2:
		anim.play("damaged")
	if health == 1:
		anim.play("dying")
