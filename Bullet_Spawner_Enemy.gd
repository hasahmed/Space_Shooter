extends Node2D

var firerate=1
var reloading=0

var bullet


func _ready():
	bullet = load("res://Bullets/Bullet_Enemy_Basic.tscn")
	
func _process(delta):
	if(reloading<=0):
		fire()
	reloading-=delta

func fire():
	var bullet_instance = bullet.instance()
	get_tree().root.add_child(bullet_instance)
	bullet_instance.position=get_parent().get_parent().position+self.position
	bullet_instance.offset=get_parent().get_parent().offset
	reloading = firerate
	
	