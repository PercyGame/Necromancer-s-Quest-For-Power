extends Area2D
class_name Hit_provider
@onready var dispawn_timer = $"dispawn timer"

"""
A hit make 4 attack damage
"""

var damage = 4

func _on_dispawn_timer_timeout():
	queue_free()
