extends Sprite

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

func _process(delta):
	if not $AnimationPlayer.is_playing():
		queue_free()