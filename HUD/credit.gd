extends Control
class_name Credit

func _ready():
	$CanvasLayer/Button.grab_focus()

func _on_button_button_down():
	get_tree().change_scene_to_file("res://HUD/MainMenu.tscn")
