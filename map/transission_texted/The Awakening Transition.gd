extends Node2D

@onready var timer = $Timer

@onready var scene = load("res://map/the_awakening.tscn")

func _on_timer_timeout():
	get_tree().change_scene_to_packed(scene)
