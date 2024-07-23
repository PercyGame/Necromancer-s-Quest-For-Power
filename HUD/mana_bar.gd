extends HBoxContainer
@onready var bar = $bar

func _process(delta):
	bar.value = 100*globals.player_mana/globals.player_max_mana
