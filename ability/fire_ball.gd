extends Area2D
class_name Fire_ball

const RIGHT = Vector2.RIGHT
@export var SPEED:int = 1000

func _physics_process(delta):
	var movment = RIGHT.rotated(rotation) * SPEED * delta
	global_position += movment

# may need to be removed to let player hit out screen target
func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()
