extends Area2D
class_name Fire_ball

"""
A fire ball make 2 attack damage
"""

const RIGHT = Vector2.RIGHT
@export var SPEED:int = 100

var mana_cost = 10
var damage = 2

func _physics_process(delta):
	var movment = RIGHT.rotated(rotation) * SPEED * delta
	global_position += movment

# may need to be removed to let player hit out screen target
func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()

#destroy animation needed
func destory():
	queue_free()

func _on_body_entered(body):
	print(body)
	if not body is Player:
		destory()

