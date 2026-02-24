extends CharacterBody2D

const JUMP_VELOCITY = -400.0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if not is_on_floor():
		velocity += get_gravity() * delta
		
	move_and_slide()


func _on_area_2d_body_entered(body: Node2D) -> void:
	# Handle jump.
	velocity.y = JUMP_VELOCITY
	
	delete_incoming_projectile(body)

func delete_incoming_projectile(projectile : Node2D) -> void:
	if 'is_penetrate' in projectile:
		if not projectile.is_penetrate:
			projectile.queue_free()
