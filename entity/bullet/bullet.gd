extends CharacterBody2D

var pos : Vector2
var bullet_rotation : float
var direction : float
var speed = 2000

@export var is_penetrate : bool = false

@onready
var deleteTimer = $DeleteTimer

@onready
var deleteOnHitTimer = $DeleteOnHitTimer

func _ready() -> void:
	global_position=pos
	global_rotation=bullet_rotation
	
func _physics_process(delta) -> void:
	velocity = Vector2(speed,0).rotated(bullet_rotation)
	move_and_slide()

func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	deleteTimer.start()
	
func _on_visible_on_screen_notifier_2d_screen_entered() -> void:
	deleteTimer.stop()
	
func _on_delete_timer_timeout() -> void:
	delete_bullet()


func _on_hurtbox_area_area_entered(area: Area2D) -> void:
	if not is_penetrate:
		deleteOnHitTimer.start()
	
func delete_bullet() -> void:
	#queue_free()
	pass
	
func _on_delete_on_hit_timer_timeout() -> void:
	delete_bullet()
