extends Node2D

var speed = 30
var reloading = 1
export var health = 3
export var firerate = 2.0
export var animation_name = "Sine"
export var explosion_texture = "res://Sprites/Explosion_small.png"
export var backward_anim = false
export var explosion_power = .45


var particle
var bullet
var explosion
onready var flasher = $Sprite/Flasher
signal camera_shake_requested(amount)

func _ready():
	
	particle = load("res://Particle_Effects/Basic_Hit.tscn")
	bullet = load("res://Bullets/Bullet_Enemy_Basic.tscn")
	explosion = load("res://Particle_Effects/Explosion.tscn")
	
	if(backward_anim):
		$Sprite/AnimationPlayer.play_backwards(animation_name)
	else:
		$Sprite/AnimationPlayer.play(animation_name)
	
	for gun in $Sprite/Guns.get_children():
		gun.firerate = self.firerate
		
#func fire():
#	var bullet_instance = bullet.instance()
#	get_tree().root.add_child(bullet_instance)
#	bullet_instance.position=self.position
#	reloading = firerate

func _process(delta):
	self.position.y+=delta*speed
	
	#if(reloading <=0):
#		fire()
	#reloading -= delta

func _on_Hurtbox_area_entered(area):
	flasher.play("flash")
	var particle_instance=particle.instance()
	get_tree().root.add_child(particle_instance)
	particle_instance.position=area.get_parent().position
	particle_instance.emitting=true
	
	#kill the bullet 
	area.get_parent().queue_free()
	health -= 1 # Replace with function body.
	if health <=0:
		var expl_instance = explosion.instance()
		get_tree().root.add_child(expl_instance)
		expl_instance.set_texture(load(explosion_texture))
		expl_instance.position=$Sprite.get_global_transform().origin
		emit_signal("camera_shake_requested",explosion_power)
		queue_free()
