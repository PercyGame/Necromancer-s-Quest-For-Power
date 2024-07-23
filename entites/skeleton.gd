extends CharacterBody2D
class_name Skeleton

"""
A skeleton take 1 decay to be attackable
it stay attackable for 5s after the decay
"""

@onready var hit_area = $hit_Area
@onready var decayed_timer = $decayed_timer

var decayed = false
var health = 10

#to change to add animation
func destory():
	queue_free()

func _process(delta):
	if health <= 0:
		destory()

func _on_hit_area_body_entered(body: Node2D):	
	if body is Decay:
		var decay:Decay = body as Decay
		decayed = true
		decayed_timer.start()

func _on_decayed_timer_timeout():
	decayed = false


func _on_hit_area_area_entered(area):
	if area is Fire_ball:
		var fire_ball:Fire_ball = area as Fire_ball
		if decayed:
			health -= fire_ball.damage
