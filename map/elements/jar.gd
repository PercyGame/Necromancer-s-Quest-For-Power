extends Area2D
class_name Jar

@onready var anim = $AnimationPlayer

@export var item_to_spawn_on_break: PackedScene

var breacked = false

func break_jar():
	breacked = true
	anim.play("break")
	if item_to_spawn_on_break != null:
		var inst = item_to_spawn_on_break.instantiate()
		owner.add_child(inst)
		inst.global_position = global_position
	else:
		print("no scene")


func _on_area_entered(area):
	if area is Hit_provider and not breacked:
		break_jar()

