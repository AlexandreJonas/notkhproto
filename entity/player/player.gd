extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0

var bullet_path = preload("res://entity/bullet/bullet.tscn")


func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("move_left", "move_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		
	if Input.is_action_just_pressed("shoot_basic"):
		fire()

	move_and_slide()

func fire() -> void:
	var bullet = bullet_path.instantiate()
	bullet.direction = rotation
	bullet.pos = $BulletPosition.global_position
	bullet.bullet_rotation = global_rotation
	
	get_parent().add_child(bullet)
