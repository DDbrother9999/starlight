class_name Player extends CharacterBody2D

@export var speed: float = 500.0
@export var jump_velocity: float = -1000.0
@export var acceleration: float = 5000.0
@export var friction: float = 5000.0
@export var air_resistance: float = 600.0
var gravity: float = 3000.0

@onready var interaction_zone: Area2D = $InteractionZone

func _ready() -> void:
	add_to_group("players")
	global_position = GameController.player_position

func _physics_process(delta: float) -> void:
	handle_gravity(delta)
	handle_jump()

	var input_vector: Vector2 = Vector2.ZERO
	input_vector.x = Input.get_axis("move_left", "move_right")

	handle_move(input_vector, delta)

	move_and_slide()
	
	if Input.is_action_just_pressed("interact"):
		print("interaction detected")
		var interactable_objects = interaction_zone.get_overlapping_bodies()
		if not interactable_objects.is_empty():
			print("entity detected")
			var target = interactable_objects[0]
			print("Player detected object: ", target.name, " of type: ", target.get_class())


			if target.has_method("interact"):
				print("interact")
				target.interact()

func collect_coin():
	GameController.collect_coin(1)

func handle_gravity(delta: float) -> void:
	if not is_on_floor():
		velocity.y += gravity * delta
	else:
		velocity.y = 0.0

func handle_jump() -> void:
	if Input.is_action_pressed("jump") and is_on_floor():
		velocity.y = jump_velocity

func handle_move(input_vector: Vector2, delta: float) -> void:
	var target_speed = input_vector.x * speed
	if is_on_floor():
		velocity.x = move_toward(velocity.x, target_speed, friction * delta)
	else:
		velocity.x = move_toward(velocity.x, target_speed, air_resistance * delta)
