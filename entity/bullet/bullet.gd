extends CharacterBody2D

var pos : Vector2
var bullet_rotation : float
var direction : float
var speed = 2000

func _ready() -> void:
	global_position=pos
	global_rotation=bullet_rotation
	
func _physics_process(delta) -> void:
	velocity = Vector2(speed,0).rotated(bullet_rotation)
	move_and_slide()
