extends CharacterBody3D

@export var look_sensitivity : float = 0.006
@export var jump_velocity : = 6.0
@export var auto_bhop : = true
@export var walk_speed := 10.0
@export var sprint_speed := 16.0
@export var ground_accel := 14.0
@export var ground_decel:= 10.0
@export var ground_friction := 4.0

const HEADBOB_MOVE_AMOUNT = 0.06
const HEADBOB_FREQUENCY = 2.4
var headbob_time: =0.0  


@export var air_cap := 0.85
@export var air_accel := 800.0
@export var air_move_speed := 500

var wish_dir:= Vector3.ZERO
var is_crouching = false
var is_standing = true

func get_move_speed() -> float:
	return sprint_speed if Input.is_action_pressed("sprint") else walk_speed

func _ready():
	for child in %WorldModel.find_children("*", "VisualInstance3D"):
		child.set_layer_mask_value(1, false)
		child.set_layer_mask_value(2, true)
	
func _unhandled_input(event):
	if event is InputEventMouseButton:
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	elif event.is_action_pressed("ui_cancel"):
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		
	if Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:
		if event is InputEventMouseMotion:
			rotate_y(-event.relative.x * look_sensitivity)
			%Camera3D.rotate_x(-event.relative.y * look_sensitivity)
			%Camera3D.rotation.x = clamp(%Camera3D.rotation.x, deg_to_rad(-90), deg_to_rad(90))
			
func _headbob_effect(delta):
	headbob_time += delta * self.velocity.length()
	%Camera3D.transform.origin = Vector3(
		cos(headbob_time * HEADBOB_FREQUENCY * 0.5) * HEADBOB_MOVE_AMOUNT,
		sin(headbob_time * HEADBOB_FREQUENCY) * HEADBOB_MOVE_AMOUNT,
		0
	)
			
func _process(delta):
	if get_interactable_object_at_shapecast():
		$Label2.visible = false
		$Label.visible = true
		if Input.is_action_just_pressed("interact"):
			$Control/RightHand.frame = 1
			$Timer.start()
			get_interactable_object_at_shapecast().interact_with()
	else:
		$Label2.visible = true
		$Label.visible = false
		
	if $Head/Camera3D/DoorInteract.is_colliding():
		var hitObj =$Head/Camera3D/DoorInteract.get_collider()
		if hitObj.has_method("interact"):
			$Label2.visible = false
			$Label.visible = true
			if Input.is_action_just_pressed("interact"):
				hitObj.interact()
				$Control/RightHand.frame = 1
				$Timer.start()
		else:
			$Label2.visible = true
			$Label.visible = false
	if velocity.x != 0 or velocity.z != 0 or velocity.y != 0:
		$Control/LeftRun.visible = true
		$"Control/LeftHand".visible = false
		$"Control/RightRun".visible = true
		$Control/RightHand.visible = false
	else:
		$Control/LeftRun.visible = false
		$"Control/LeftHand".visible = true
		$"Control/RightRun".visible = false
		if get_interactable_object_at_shapecast():
			if Input.is_action_just_pressed("interact"):
				$Control/RightHand.visible = false
		
		$Control/RightHand.visible = true		
	
	
func clip_velocity(normal: Vector3, overbounce : float, delta : float) -> void:
	var backoff:= self.velocity.dot(normal) * overbounce
	if backoff >= 0: return
	var change := normal *backoff
	self.velocity -= change
	
	var adjust := self.velocity.dot(normal)
	if adjust < 0.0:
		self.velocity -= normal * adjust
func is_surface_too_steep(normal: Vector3) -> bool:
	var max_slope_ang_dot = Vector3(0, 1, 0).rotated(Vector3(1.0,0,0), self.floor_max_angle).dot(Vector3(0,1,0))
	if normal.dot(Vector3(0,1,0)) < max_slope_ang_dot:
		return true
	return false
	
func _handle_air_physics(delta) -> void:
	self.velocity.y -= ProjectSettings.get_setting("physics/3d/default_gravity") * delta
	
	var cur_speed_in_wish_dir = self.velocity.dot(wish_dir)
	var capped_speed = min((air_move_speed * wish_dir).length(), air_cap)
	var add_speed_till_cap = capped_speed - cur_speed_in_wish_dir
	if add_speed_till_cap > 0:
		var accel_speed = air_accel * air_move_speed * delta
		accel_speed = min(accel_speed, add_speed_till_cap)
		self.velocity += accel_speed * wish_dir
	if is_on_wall():
		if is_surface_too_steep(get_wall_normal()):
			self.motion_mode = CharacterBody3D.MOTION_MODE_FLOATING
		else:
			self.motion_mode = CharacterBody3D.MOTION_MODE_GROUNDED
		clip_velocity(get_wall_normal(), 1, delta)


func _handle_ground_physics(delta) -> void:
	var cur_speed_in_wish_dir = self.velocity.dot(wish_dir)
	var add_speed_till_cap = get_move_speed() - cur_speed_in_wish_dir
	if add_speed_till_cap > 0:
		var accel_speed = ground_accel * delta * get_move_speed()
		accel_speed = min(accel_speed, add_speed_till_cap)
		self.velocity += accel_speed * wish_dir
	
	var control = max(self.velocity.length(), ground_decel)
	var drop = control * ground_friction * delta
	var new_speed = max(self.velocity.length() - drop, 0.0)
	if self.velocity.length() > 0:
		new_speed /= self.velocity.length()
	self.velocity *= new_speed
	
	_headbob_effect(delta)
		
		
func _physics_process(delta):
	var input_dir = Input.get_vector("left", "right", "up", "down").normalized()
	wish_dir = self.global_transform.basis * Vector3(input_dir.x, 0, input_dir.y)
	if Input.is_action_just_pressed("Crouch"):
		if is_crouching == false:
			movement_state_change("crouch")
		elif is_crouching == true:
			movement_state_change("uncrouch")
		
	if is_on_floor():
		if Input.is_action_just_pressed("jump") or (auto_bhop and Input.is_action_pressed("jump")):
			self.velocity.y = jump_velocity
		
		_handle_ground_physics(delta)
	else:
		_handle_air_physics(delta)
		
	move_and_slide()
	
func get_interactable_object_at_shapecast() -> InteractableObject:
	for i in %InteractShapeCast3D.get_collision_count():
		if i> 0 and %InteractShapeCast3D.get_collider(0) != $'.':
			return null
		if %InteractShapeCast3D.get_collider(i).get_node_or_null("InteractableObject") is InteractableObject:
			return %InteractShapeCast3D.get_collider(i).get_node_or_null("InteractableObject")
	return null

func movement_state_change(changeType):
	match changeType:
		"crouch":
			if is_standing:
				$AnimationPlayer.play("standing_to_crouch")
			is_crouching = true
			is_standing = false
			change_collision_shape("crouch")
		"uncrouch":
			$AnimationPlayer.play_backwards("standing_to_crouch")
			is_crouching = false
			is_standing = true
			change_collision_shape("stand")
			
func change_collision_shape(shape):
	match shape:
		"crouch":
			%CrouchingCollisionShape.disabled = false
			%CollisionShape3D.disabled = true
		"stand":
			%CrouchingCollisionShape.disabled = true
			%CollisionShape3D.disabled = false
	


func _on_timer_timeout() -> void:
	$Control/RightHand.frame = 0
