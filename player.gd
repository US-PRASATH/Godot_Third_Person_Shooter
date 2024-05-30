extends CharacterBody3D

@onready var sprinttimer = $sprinttimer
var SPEED
const JUMP_VELOCITY = 6
var valu = 0
var can_fire = true
var sh = 0
var fi = 0
var yesshoot = false
#var prospeed = 10
var prospeed = 5
#var sped = 5.0
var sprinting = true
var sval = 0
var moving = false
var health = 10
var can_move = true
var hit_stagger = 10.0
var shotgun = load("res://view_model_camera.tscn")
var guna = true
var touchsprint = false
##var rara = load("res://ray_cast_3d.tscn")
@onready var mark = $Marker3D
#var sub = 0
#var su = 0
# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")
var idle = true
var mouse_sense = 0.1
var bullet = load("res://bullet.tscn")
var instance
var instance2
var instance3
var can_fire2 = true
var can_fire3 = true
@onready var gun = $head/view_model_camera/fps_rig/shotgun/RayCast3D
@onready var gun2 = $head/view_model_camera/fps_rig/shotgun/RayCast3D2
@onready var gun3 = $head/view_model_camera/fps_rig/shotgun/RayCast3D3
@onready var head = $head
@onready var camera = $head/Camera2D
@onready var gunshot = $AudioStreamPlayer
@onready var ran = $ran
@onready var co = $AudioStreamPlayer2
@onready var runa = $AudioStreamPlayer3
@onready var bonk = $AudioStreamPlayer4
@onready var fant = $AudioStreamPlayer5
var avlue = true
#var one = true
func get_coin():
	co.play()
	glob.coins += 1
func _ready():
	#hides the cursor
#	if glob.mous:
	#Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
#	if !glob.mous:
#		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	pass

func _input(event):
	#get mouse input for camera rotation
	if glob.mous:
		if event is InputEventMouseMotion:
			rotate_y(deg_to_rad(-event.relative.x * mouse_sense))
			head.rotate_x(deg_to_rad(-event.relative.y * mouse_sense))
			head.rotation.x = clamp(head.rotation.x, deg_to_rad(-89), deg_to_rad(89))

func _physics_process(delta):
	
#	if one:
#		$AnimationPlayer2.play("faint")
	if !touchsprint:
		sval = 0
	if touchsprint:
		sprinttimer.start()
		sval = 1
	##if glob.score >=10 and guna:
		##rara = rara.instantiate()
		##rara.position = mark.global_position
		##guna = false
	if glob.bnlvl >= 2:
		gun2.show()
	if glob.bnlvl >=3:
		gun3.show()
	if glob.one and health<=0:
		$AnimationPlayer2.play("faint")
		glob.one = false
	if is_on_floor_only() and !moving and idle:
		$AnimationPlayer2.play("idle")
		
	#if !moving and is_on_floor_only():
		#$AnimationPlayer2.play("idle")
	if moving and is_on_floor_only() and !idle:
		
		$AnimationPlayer2.play("runn")
	#if sprinting:
		#$AnimationPlayer2.play("runn")
	SPEED = glob.sp
	idle = true
	moving = false
	if sprinting and touchsprint:
		runa.play()
#		ran.play()

		SPEED = glob.sp + prospeed
	if !touchsprint:
		runa.stop()
	#print(str(valu) + " " + str(sh))
	# Add the gravity.
	#if valu == 1:
		#$head/AnimationPlayer.play("gun")
#	if Input.is_action_just_pressed("sprint"):
#		#$AnimationPlayer2.play("runn")
#		sprinttimer.start()
#		sval = 1
#	if Input.is_action_just_released("sprint"):
#
#
#		sval = 0
	#if Input.is_action_just_pressed("slide"):
		#$AnimationPlayer2.play("slide")
#	if Input.is_action_pressed("sprint") and sprinting:
#		#sprinttimer.start()
#		#sprinting = true
#	#if Input.is_action_just_released("sprint"):
#		#sprinting = false
#	#if sprinting:
#		#sprinttimer.start()
#		SPEED = glob.sp + prospeed
	if not is_on_floor():
		avlue = false
		velocity.y -= gravity * delta
	
	# Handle Jump.
#	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
#		#$AnimationPlayer2.play("jump")
#		$AnimationPlayer2.play("fall")
#		#moving = true
#		velocity.y = glob.j
	#if Input.is_action_just_pressed("aim"):
		#valu = 1
		
		#$head/AnimationPlayer.play("gun")
		#sh = 1
		#su = 1
		#if Input.is_action_pressed("shoot") and can_fire:
			#instance = bullet.instantiate()
			#instance.position = gun.global_position
			#instance.transform.basis = gun.global_transform.basis
			#get_parent().add_child(instance)
			#can_fire = false
			#await get_tree().create_timer(0.2).timeout
			#can_fire = true
			#$head/bullet.show()
			#$head/AnimationPlayer.play("shoot")
			#valu = 1
			#$head/AnimationPlayer.play("recoil")
	if !is_on_floor():
		
		$AnimationPlayer2.play("fall")
	if is_on_floor_only():
		avlue = true
	if yesshoot:
		if can_move and can_fire:
			moving = true
			instance = bullet.instantiate()
			gunshot.play()
			instance.position = gun.global_position
			#instance.scale.x = glob.fb
			#instance.scale.y = glob.fb
			instance.transform.basis = gun.global_transform.basis
			get_parent().add_child(instance)
			can_fire = false
			await get_tree().create_timer(glob.fr).timeout
			can_fire = true
			if gun2.visible:
				instance2 = bullet.instantiate()
				
				instance2.position = gun2.global_position
				instance2.transform.basis = gun2.global_transform.basis
				get_parent().add_child(instance2)
				can_fire2 = false
				await get_tree().create_timer(glob.fr).timeout
				can_fire2 = true
			if gun3.visible:
				instance3 = bullet.instantiate()
				instance3.position = gun3.global_position
				instance3.transform.basis = gun3.global_transform.basis
				get_parent().add_child(instance3)
				can_fire3 = false
				await get_tree().create_timer(glob.fr).timeout
				can_fire3 = true
				#$head/bullet.show()
				#$head/AnimationPlayer.play("shoot")
			#valu = 1
			$head/AnimationPlayer.play("recoil")
	if can_move:
		#moving = true
		#if Input.is_action_pressed("shoot") and can_fire:
			#_shooting()
			# and sh == 1:
#			
#			moving = true
#			instance = bullet.instantiate()
#			instance.position = gun.global_position
#			#instance.scale.x = glob.fb
#			#instance.scale.y = glob.fb
#			instance.transform.basis = gun.global_transform.basis
#			get_parent().add_child(instance)
#			can_fire = false
#			await get_tree().create_timer(glob.fr).timeout
#			can_fire = true
#			if gun2.visible:
#				instance2 = bullet.instantiate()
#				instance2.position = gun2.global_position
#				instance2.transform.basis = gun2.global_transform.basis
#				get_parent().add_child(instance2)
#				can_fire2 = false
#				await get_tree().create_timer(glob.fr).timeout
#				can_fire2 = true
#			if gun3.visible:
#				instance3 = bullet.instantiate()
#				instance3.position = gun3.global_position
#				instance3.transform.basis = gun3.global_transform.basis
#				get_parent().add_child(instance3)
#				can_fire3 = false
#				await get_tree().create_timer(glob.fr).timeout
#				can_fire3 = true
#				#$head/bullet.show()
#				#$head/AnimationPlayer.play("shoot")
#			#valu = 1
#			$head/AnimationPlayer.play("recoil")
		#if Input.is_action_just_released("shoot") or Input.is_action_just_released("aim"):
	#		#valu = 0
	#	if Input.is_action_just_released("shoot"):
	#		# and Input.is_action_just_released("aim"):
	#		valu = 0
	#		#$head/AnimationPlayer.play("RESET")
	#
	#
	#	if Input.is_action_just_released("aim"):
	#		sh = 0
	#		valu = 0
	#		#sub = 1
	#		#$head/AnimationPlayer.play("RESET")
	#	if valu == 0 and not sh == 1:
	#		#$head/AnimationPlayer.play("RESET")
	#		valu = 2
	#	if valu == 2 and sh == 0:
	#		#$head/AnimationPlayer.play("RESET")
	#		valu = 3
		#if sub == 1:
			#$head/AnimationPlayer.play("RESET")
			#sub = 2
		#if Input.is_action_just_pressed("but"):
		#	$AnimationPlayer.play("sand")
		#if Input.is_action_just_pressed("buto"):
			#$head/AnimationPlayer.play("ok")
		# Get the input direction and handle the movement/deceleration.
		# As good practice, you should replace UI actions with custom gameplay actions.
		var input_dir = Input.get_vector("left", "right", "forward", "backward")
		var direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
		if direction:
			
			moving = true
			idle = false
			velocity.x = direction.x * SPEED
			velocity.z = direction.z * SPEED
		else:
			#if is_on_floor_only():
			if avlue and is_on_floor_only():
				ran.play()
			velocity.x = move_toward(velocity.x, 0, SPEED)
			velocity.z = move_toward(velocity.z, 0, SPEED)

		move_and_slide()

#
#func _on_animation_player_animation_finished(anim_name):
#	#if anim_name == "":
#		#su = 1
#	if anim_name == "recoil" and valu == 3:
#		$head/AnimationPlayer.play("RESET")
		#$head/AnimationPlayer.play("recoil")
		#$head/view_model_camera/fps_rig/shotgun/uploads_files_4367404_hand/hand.rotate_x(0)
		#$head/view_model_camera/fps_rig/shotgun/uploads_files_4367404_hand/hand.rotate_y(0)
		#$head/view_model_camera/fps_rig/shotgun/uploads_files_4367404_hand/hand.rotate_z(0)
		# Replace with function body.


#func _on_animation_player_animation_started(anim_name):
	#if anim_name == "recoil":
		#su = 0 # Replace with function body.
#func _shooting():
#	if can_move and can_fire:
#		moving = true
#		instance = bullet.instantiate()
#		instance.position = gun.global_position
#		#instance.scale.x = glob.fb
#		#instance.scale.y = glob.fb
#		instance.transform.basis = gun.global_transform.basis
#		get_parent().add_child(instance)
#		can_fire = false
#		await get_tree().create_timer(glob.fr).timeout
#		can_fire = true
#		if gun2.visible:
#			instance2 = bullet.instantiate()
#			instance2.position = gun2.global_position
#			instance2.transform.basis = gun2.global_transform.basis
#			get_parent().add_child(instance2)
#			can_fire2 = false
#			await get_tree().create_timer(glob.fr).timeout
#			can_fire2 = true
#		if gun3.visible:
#			instance3 = bullet.instantiate()
#			instance3.position = gun3.global_position
#			instance3.transform.basis = gun3.global_transform.basis
#			get_parent().add_child(instance3)
#			can_fire3 = false
#			await get_tree().create_timer(glob.fr).timeout
#			can_fire3 = true
#			#$head/bullet.show()
#			#$head/AnimationPlayer.play("shoot")
#		#valu = 1
#		$head/AnimationPlayer.play("recoil")
func hit(dir):
	bonk.play()
	print("hit")
	velocity += dir * hit_stagger
	health -= 1
	if health <= 0:
		$AnimationPlayer2.play("faint")
		#one = true
		if glob.one:
			fant.play()
#			$AnimationPlayer2.play("faint")
			glob.one = false
		can_move = false
		
func _on_sprinttimer_timeout():
	sprinting = false# Replace with function body.
	$sprintwait.start()


func _on_sprintwait_timeout():
	sprinting = true
	if sval == 1:
		sprinttimer.start() # Replace with function body.

func _jump():
	if is_on_floor():
		#$AnimationPlayer2.play("jump")
#		$AnimationPlayer2.play("fall")
		#moving = true
		velocity.y = glob.j
#func _sprintt():
	#touchsprint = true
		#$AnimationPlayer2.play("runn")
#	sprinttimer.start()
#	sval = 1
	#if Input.is_action_just_released("sprint"):
		
		
		
	
#func _sprintrelease():
	#touchsprint = false
#	sval = 0
	
func _on_animation_player_2_animation_finished(anim_name):
	if anim_name=="jump":
		$AnimationPlayer2.play("fall")
	if anim_name == "faint":
		glob.one = false # Replace with function body.
