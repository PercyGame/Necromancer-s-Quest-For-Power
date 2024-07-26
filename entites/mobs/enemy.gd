extends CharacterBody2D
class_name Enemy

@export var decay_duration: float # how many second the mob stay decayed
@export var devay_value: int # number of decay needed to be decayed
@export var health: float
@export var speed: float
@export var damage: float
var decayed = false
var stuned = false
var is_player_detected = false
var is_player_attackable = false
var is_player_in_attack_range = false


#to change to add animation
func destory():
	queue_free()

func hit_area(body, decayed_timer:Timer):
	if body is Decay:
		var decay:Decay = body as Decay
		decayed = true
		stuned = true
		decayed_timer.start()
	if body is Fire_ball:
		var fire_ball:Fire_ball = body as Fire_ball
		if decayed:
			health -= fire_ball.damage
	
	if body is Hit_provider:
		var hit_provider:Hit_provider = body as Hit_provider
		if decayed:
			health -= hit_provider.damage

func detection_area():
	pass
