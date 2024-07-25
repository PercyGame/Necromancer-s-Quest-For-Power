extends Control
class_name Main_menu

@onready var play_button = $MarginContainer/VBoxContainer/play
@onready var credits_button = $MarginContainer/VBoxContainer/credits
@onready var parameters_button = $MarginContainer/VBoxContainer/parameters
@onready var quit_button = $MarginContainer/VBoxContainer/quit

var main_scene = load("res://map/transission_texted/intro1.tscn")

func _ready():
	play_button.grab_focus() #init the controleur menu control on play button
	play_button.button_down.connect(_on_play_button_pressed)
	credits_button.button_down.connect(_on_credits_button_pressed)
	parameters_button.button_down.connect(_on_parameters_button_pressed)
	quit_button.button_down.connect(_on_quit_button_pressed)

func _on_play_button_pressed():
	#launch the game
	get_tree().change_scene_to_packed(main_scene)

func _on_credits_button_pressed():
	pass
	#open the credit menu

func _on_parameters_button_pressed():
	pass
	#onpen the parameters menu

func _on_quit_button_pressed():
	get_tree().quit()
