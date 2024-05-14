extends CharacterBody2D

signal life_changed(player_hearts)
var max_hearts: int = 3
var hearts: int = max_hearts
const SPEED = 300.0
const JUMP_VELOCITY = -400.0
# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var syncPos = Vector2(0,0)
var syncRot = 0
@export var bullet :PackedScene

func _ready():
	$MultiplayerSynchronizer.set_multiplayer_authority(str(name).to_int())

func _physics_process(delta):
	if $MultiplayerSynchronizer.get_multiplayer_authority() == multiplayer.get_unique_id():
		# Add the gravity.
		if not is_on_floor():
			velocity.y += gravity * delta
			
		$GunRotation.look_at(get_viewport().get_mouse_position())
		# Handle Jump.
		if Input.is_action_just_pressed("ui_accept") and is_on_floor():
			velocity.y = JUMP_VELOCITY
		
		syncPos = global_position
		syncRot = rotation_degrees
		if Input.is_action_just_pressed("Fire"):
			fire.rpc()
		# Get the input direction and handle the movement/deceleration.
		# As good practice, you should replace UI actions with custom gameplay actions.
		var direction = Input.get_axis("ui_left", "ui_right")
		if direction:
			velocity.x = direction * SPEED
		else:
			velocity.x = move_toward(velocity.x, 0, SPEED)
		move_and_slide()
		
		for i in get_slide_collision_count():
			var collision = get_slide_collision(i)
			if collision.get_collider().has_method("hit"):
				hearts -= 1
				print("Emiting signal...")
				emit_signal("life_changed", hearts)
				if hearts <= 0:
					dead.rpc()
					print("Gameeee Oveeeeeer :X")
				collision.get_collider().hit.rpc()

	else:
		global_position = global_position.lerp(syncPos, .5)
		rotation_degrees = lerpf(rotation_degrees, syncRot, .5)



@rpc("any_peer","call_local")
func fire():
	var b = bullet.instantiate()
	b.global_position = $GunRotation/BulletSpawn.global_position
	b.rotation_degrees = $GunRotation.rotation_degrees
	get_tree().root.add_child(b)
	
@rpc("any_peer","call_local")
func dead():
	queue_free()

