extends Node2D

var label_counter = 1
@onready var label1 = $CanvasLayer/Label
@onready var label2 = $CanvasLayer/Label2
@onready var label3 = $CanvasLayer/Label3


func _process(delta):
	print(label_counter)
	if label_counter == 1:
		label1.show()
		label2.hide()
		label3.hide()
	elif label_counter == 2:
		label1.hide()
		label2.show()
		label3.hide()
	elif label_counter == 3:
		label1.hide()
		label2.hide()
		label3.show()
	else:
		get_tree().change_scene_to_file("res://map/main_hall.tscn")

func _on_transition_timer_timeout():
	label_counter += 1
	print("timeout")

