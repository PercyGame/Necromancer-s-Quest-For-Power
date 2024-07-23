extends HBoxContainer
@onready var bar = $bar

func _process(delta):
	bar.value = 100*globals.player_health/globals.player_max_health
