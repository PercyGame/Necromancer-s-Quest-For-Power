extends Area2D
class_name Hit_provider
@onready var dispawn_timer = $"dispawn timer"

func _on_dispawn_timer_timeout():
	queue_free()
