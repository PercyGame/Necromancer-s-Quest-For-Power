extends CharacterBody2D
class_name Player

@export var FIRE_BALL: PackedScene
@export var HIT_PROVIDER: PackedScene
@export var DECAY: PackedScene

@onready var aiming_indicator = $aiming_indicator
@onready var dash_timer = $dash_timer
@onready var pause_menu = $PauseHUD
@onready var animation_tree = $AnimationTree

""" to deal with player health, please use globals.player_health, it allow the
game to syncronize player health among levels
Same for player score """
var base_speed = 100
var dash_speed = 600
var speed = 100
var paused = false
var mana_reloading_speed = 15

#__________/MAIN FUNCTION\__________

# main function that run at  every game tick
func _process(delta):
	
	if globals.Obsidian_of_Shadows == true:
		get_tree().change_scene_to_file("res://map/transission_texted/temp_end.tscn" )
	
	if get_input_values(0) == Vector2.ZERO:
		animation_tree.get("parameters/playback").travel("Idle")
	else:
		animation_tree.get("parameters/playback").travel("Walk")
		animation_tree.set("parameters/Idle/BlendSpace1D/blend_position", get_input_values(0).x)
		animation_tree.set("parameters/Walk/BlendSpace1D/blend_position", get_input_values(0).x)
		animation_tree.set("parameters/Damage/BlendSpace1D/blend_position", get_input_values(0).x)
	
	if get_input_values(1) == Vector2.ZERO:
		pass
	else:
		animation_tree.set("parameters/Cast/BlendSpace1D/blend_position", get_input_values(1).x)
	
	if globals.player_health <= 0:
		globals.player_health = globals.player_max_health
		globals.player_mana = globals.player_max_mana
		get_tree().change_scene_to_file("res://HUD/MainMenu.tscn")
	direction_indicator()
	movment()
	if Input.is_action_just_pressed("cast_fire_ball"):
		cast_fire_ball()
	if Input.is_action_just_pressed("hit"):
		hit()
	if Input.is_action_just_pressed("cast_dacay"):
		cast_dacay()
	if Input.is_action_just_pressed("pause"):
		pauseMenu()



#__________/FUNCTION DEFINITION\__________

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
func movment():
	# compute the player velocity (for the move_and_slide() function)
	self.velocity = get_input_values(0) * speed
	move_and_slide()
	#position += self.velocity # godot build-in function that move stuff around
	if Input.is_action_just_pressed("dash"):
		dash()
	

func cast_fire_ball():
	var input_aiming = get_input_values(1)
	if input_aiming != Vector2.ZERO:
		if FIRE_BALL:
			if globals.player_mana >= FIRE_BALL.instantiate().mana_cost:
				var fire_ball: Area2D = FIRE_BALL.instantiate()
				owner.add_child(fire_ball)
				globals.player_mana -= fire_ball.mana_cost
				fire_ball.global_position = global_position
				fire_ball.global_rotation = input_aiming.angle()
				animation_tree.get("parameters/playback").travel("Cast")

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
			if globals.player_mana >= DECAY.instantiate().mana_cost:
				var decay: CharacterBody2D = DECAY.instantiate()
				owner.add_child(decay)
				globals.player_mana -= decay.mana_cost
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

func dash():
	globals.is_player_hittable = false
	speed = dash_speed
	dash_timer.start()

func _on_mana_regen_timeout():
	if globals.player_mana < globals.player_max_mana:
		globals.player_mana += mana_reloading_speed
	if globals.player_mana > globals.player_max_mana:
		globals.player_mana = globals.player_max_mana


func _on_dash_timer_timeout():
	globals.is_player_hittable = true
	speed = base_speed


func pauseMenu():
	if paused:
		pause_menu.hide()
		Engine.time_scale = 1
	else:
		pause_menu.show()
		Engine.time_scale = 0
	paused = !paused
