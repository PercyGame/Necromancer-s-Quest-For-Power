extends Area2D
class_name Door

@export var status:int

@onready var sprite = $Sprite2D

func _ready():
	sprite.frame = status
