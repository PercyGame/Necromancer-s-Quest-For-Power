extends CharacterBody2D
class_name Skeleton

"""
A skeleton take 1 decay to be attackable
it stay attackable for 5s after the decay
"""

"""NOTE: need to code the stune mecanique"""

@onready var hit_area = $hit_Area
@onready var decayed_timer = $decayed_timer
@onready var attack_timer = $"attack_timer"
@onready var player = get_tree().get_first_node_in_group("player")

var decayed = false
var stuned = false
var health = 10
var is_player_detected = false
var is_player_attackable = false
var is_player_in_attack_range = false
var speed = 75
var damage = 2


#to change to add animation
func destory():
	queue_free()

func _process(delta):
	if is_player_attackable and not stuned:
		attack_player()
	if is_player_detected and not stuned:
		follow_player()
	if health <= 0:
		destory()

func _on_hit_area_body_entered(body: Node2D):	
	if body is Decay:
		var decay:Decay = body as Decay
		decayed = true
		stuned = true
		decayed_timer.start()

func _on_decayed_timer_timeout():
	decayed = false
	stuned = false


func _on_hit_area_area_entered(area):
	if area is Fire_ball:
		var fire_ball:Fire_ball = area as Fire_ball
		if decayed:
			health -= fire_ball.damage
	
	if area is Hit_provider:
		var hit_provider:Hit_provider = area as Hit_provider
		if decayed:
			health -= hit_provider.damage


func _on_detection_area_body_entered(body):
	if body is Player:
		is_player_detected = true


func _on_detection_area_body_exited(body):
	if body is Player:
		is_player_detected = false

func follow_player():
	if not is_player_attackable:
		var direction = global_position.direction_to(player.global_position)
		self.velocity = direction * speed
		move_and_slide()

func attack_player():
	if globals.is_player_hittable:
		attack_timer.start()
		is_player_attackable = false

func _on_attaque_area_body_entered(body):
	if body is Player:
		is_player_attackable = true
		is_player_in_attack_range = true

func _on_attaque_area_body_exited(body):
	if body is Player:
		is_player_attackable = false
		is_player_in_attack_range = false

func _on_attack_timer_timeout():
	if is_player_in_attack_range:
		globals.player_health -= damage
		is_player_attackable = true
