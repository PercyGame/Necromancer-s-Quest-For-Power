extends CharacterBody2D
class_name Decay

var DIRECTION = Vector2.ZERO
@export var SPEED:int = 100
@onready var sprite = $Sprite2D
var mana_cost = 25

func _create(direction:Vector2):
	DIRECTION = direction.normalized()
	if direction.x > 0:
		sprite.frame = 0
	else:
		sprite.frame = 12

func _physics_process(delta):
	var movment = DIRECTION * SPEED * delta
	global_position += movment



func _on_dispawn_timer_timeout():
	queue_free()
