extends Area2D
class_name Teleporteur

@export var target_scene: PackedScene
@export var can_teleport:bool


func _on_body_entered(body):
	if body is Player:
		if can_teleport:
			get_tree().change_scene_to_packed(target_scene)
