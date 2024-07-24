extends CanvasLayer
class_name PauseMenu

@onready var resume_button = $Control/MarginContainer/VBoxContainer/resume
@onready var parameters_button = $Control/MarginContainer/VBoxContainer/parametres
@onready var quit_button = $Control/MarginContainer/VBoxContainer/quit
@onready var visible_on_screen_notifier = $VisibleOnScreenNotifier2D

func _ready():
	visible_on_screen_notifier.screen_entered.connect(_on_visible_on_screen)

func _on_visible_on_screen():
	resume_button.grab_focus()
