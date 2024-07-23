extends CharacterBody2D
class_name Armoured_Knight

"""
An Armoured knight take 5 decay to be attackable
it stay attackable for 15s after the last decay, but when decayed, it enter in
super aggressive mod
"""

@onready var hit_area = $hit_Area
@onready var decayed_timer = $decayed_timer

var decay_count = 0
var decayed = false
var health = 25

#to change to add animation
func destory():
	queue_free()

func _process(delta):
	if health <= 0:
		destory()

func _on_hit_area_body_entered(body: Node2D):	
	if body is Decay:
		if not decayed:
			var decay:Decay = body as Decay
			decay_count += 1
			if decay_count >= 5:
				decay_count = 0
				decayed = true
				decayed_timer.start()

func _on_decayed_timer_timeout():
	decayed = false


func _on_hit_area_area_entered(area):
	if area is Fire_ball:
		var fire_ball:Fire_ball = area as Fire_ball
		if decayed:
			health -= fire_ball.damage
