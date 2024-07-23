extends CharacterBody2D
class_name Player

@export var FIRE_BALL: PackedScene
@export var HIT_PROVIDER: PackedScene
@export var DECAY: PackedScene

@onready var aiming_indicator = $aiming_indicator

""" to deal with player health, please use globals.player_health, it allow the
game to syncronize player health among levels
Same for player score """
var max_health = 10
var speed = 100

	

# function that return the asked current input value
func get_input_values(input_type:int):
	if input_type == 0:
		# generate a normalized vector(0 or 1 in x and y) from the players's input
		var input_movment = Vector2(
			Input.get_action_strength("move_right") - Input.get_action_strength("move_left"),
			Input.get_action_strength("move_down") - Input.get_action_strength("move_up")
		).normalized()
		return input_movment # return the generated vector
	if input_type == 1:
		# generate a normalized vector(0 or 1 in x and y) from the players's input
		var input_aiming = Vector2(
			Input.get_action_strength("aim_right") - Input.get_action_strength("aim_left"),
			Input.get_action_strength("aim_down") - Input.get_action_strength("aim_up")
		)
		return input_aiming # return the generated vector

# function that manage player's movments
func movment(delta):
	# compute the player velocity (for the move_and_slide() function)
	self.velocity = get_input_values(0) * delta * speed
	position += self.velocity # godot build-in function that move stuff around
	"""
	if Input.is_action_just_pressed("dash"):
		dash(delta)
	"""

func cast_fire_ball():
	var input_aiming = get_input_values(1)
	if input_aiming != Vector2.ZERO:
		if FIRE_BALL:
			var fire_ball: Area2D = FIRE_BALL.instantiate()
			owner.add_child(fire_ball)
			fire_ball.global_position = global_position
			fire_ball.global_rotation = input_aiming.angle()

func hit():
	var input_aiming = get_input_values(1)
	if input_aiming != Vector2.ZERO:
		if HIT_PROVIDER:
			var hit_provider: Area2D = HIT_PROVIDER.instantiate()
			add_child(hit_provider)
			hit_provider.global_rotation = input_aiming.angle()

func cast_dacay():
	var input_aiming = get_input_values(1)
	if input_aiming != Vector2.ZERO:
		if DECAY:
			var decay: CharacterBody2D = DECAY.instantiate()
			owner.add_child(decay)
			decay._create(input_aiming)
			decay.global_position = global_position

# need to be finished. Shoult trace a line, to indicate where the player is aiming at
func direction_indicator():
	var direction = get_input_values(1)
	if direction != Vector2.ZERO:
		aiming_indicator.global_rotation = direction.angle()
		aiming_indicator.show()
	else:
		aiming_indicator.hide()

# not finished yet (need to be finetuned
func dash(delta):
	self.velocity = get_input_values(0) * delta * 500000
	move_and_slide()

# main function that run at  every game tick
func _process(delta):
	direction_indicator()
	movment(delta)
	if Input.is_action_just_pressed("cast_fire_ball"):
		cast_fire_ball()
	if Input.is_action_just_pressed("hit"):
		hit()
	if Input.is_action_just_pressed("cast_dacay"):
		cast_dacay()
