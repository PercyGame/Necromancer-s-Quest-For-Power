extends Node2D
class_name Spawner

@export var mob:PackedScene
@export var number_to_spawn: int
@export var spawn_time: float

@onready var spawn_timer = $spawn_timer

var is_spawning = false
var can_spawn = true
var spawned_number = 0

func _ready():
	spawn_timer.wait_time = spawn_time

func _process(delta):
	is_destory_needed()
	if is_spawning and can_spawn:
		spawn()

func _on_area_2d_body_entered(body):
	if body is Player:
		is_spawning = true
		

func spawn():
	var inst = mob.instantiate()
	owner.add_child(inst)
	inst.global_position = global_position
	spawned_number += 1
	can_spawn = false
	spawn_timer.start()

func is_destory_needed():
	if spawned_number >= number_to_spawn:
		queue_free()

func _on_spawn_timer_timeout():
	can_spawn = true
