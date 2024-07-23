extends CharacterBody2D
class_name Decay

var DIRECTION = Vector2.ZERO
@export var SPEED:int = 100

func _create(direction:Vector2):
	DIRECTION = direction.normalized()

func _physics_process(delta):
	var movment = DIRECTION * SPEED * delta
	global_position += movment



func _on_dispawn_timer_timeout():
	queue_free()
