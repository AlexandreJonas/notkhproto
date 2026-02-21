extends State

@export
var fall_state: State
@export
var idle_state: State
@export
var jump_state: State
@export
var move_state: State
@export
var playerScene : CharacterBody2D
@export
var bulletPositionScene : Node2D

@onready var bullet_path = preload("res://entity/bullet/bullet.tscn")
var bullet_position

func enter() -> void:
	super()
	bullet_position = bulletPositionScene
	fire()

func process_input(event: InputEvent) -> State:
	#if Input.is_action_just_pressed('shoot_basic'):
		#return self
	if Input.is_action_just_pressed('jump') and parent.is_on_floor():
		return jump_state
	if Input.is_action_pressed('move_left') or Input.is_action_pressed('move_right'):
		return move_state
	return null

func process_physics(delta: float) -> State:
	#parent.velocity += parent.get_gravity() * delta
	parent.velocity.y = 0
	
	#if Input.is_action_just_pressed('shoot_basic'):
		#return self
	
	var movement = Input.get_axis('move_left', 'move_right') * move_speed
	
	if movement == 0:
		if parent.is_on_floor():
			return idle_state
		return fall_state
	
	#parent.animations.flip_h = movement < 0
	parent.velocity.x = movement
	parent.move_and_slide()
	
	return null

func fire() -> void:
	var bullet = bullet_path.instantiate()
	bullet.direction = playerScene.rotation
	bullet.pos = bullet_position.global_position
	bullet.bullet_rotation = playerScene.global_rotation
	
	playerScene.get_parent().add_child(bullet)
