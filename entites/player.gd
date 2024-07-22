extends CharacterBody2D
class_name Player

#var velocity: Vector2 = Vector2.ZERO

func movment(delta):
	var input = Vector2(
		Input.get_action_strength("move_right") - Input.get_action_strength("move_left"),
		Input.get_action_strength("move_down") - Input.get_action_strength("move_up")
	).normalized()
	self.velocity = input * delta * 5000
	move_and_slide()
	print(input)

func _process(delta):
	movment(delta)
