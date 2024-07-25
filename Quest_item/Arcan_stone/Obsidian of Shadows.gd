extends StaticBody2D

func _on_area_2d_body_entered(body):
	if body is Player:
		globals.Obsidian_of_Shadows = true
		queue_free()
