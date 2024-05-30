extends CharacterBody3D

#const Atack = 2.5
var SPEED = 5.0
const JUMP_VELOCITY = 4.5
var player = null
var health = 10
const attack_range = 2.5
var state_machine
var coin = load("res://coin.tscn")
var nua = false
var low = 0
var cadd = false
var slow = false
#var bol = false
@export var player_path := "/root/world1/NavigationRegion3D/player"
@export var player_node : NodePath
@onready var nav_agent = $NavigationAgent3D
@onready var animtree = $AnimationTree
@onready var aud = $AudioStreamPlayer3D
var moving = true
# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")
func target_inrange():
	return global_position.distance_to(player.global_position) < attack_range
func _ready():
	nua = false
	player = get_node(player_path)
	state_machine = animtree.get("parameters/playback")
func _process(delta):
	$slowtime.wait_time = glob.fb
	if slow:
		SPEED = 1
	if !slow:
		SPEED = 5
	if glob.cpmax == 0:
		low = randi_range(0,1)
	if glob.cpmax == 1:
		low = glob.cp
	#if moving == true:
		#$AnimationPlayer.play("runn")
	#if moving == false:
		#$AnimationPlayer.play("faint")
	velocity = Vector3.ZERO
	#if moving == true:
	match state_machine.get_current_node():
			"runn":
				nav_agent.set_target_position(player.global_transform.origin)
				var next_nav_point = nav_agent.get_next_path_position()
				velocity = (next_nav_point - global_transform.origin).normalized() * SPEED
				#rotation.y = lerp_angle(rotation.y,atan2(-velocity.x,-velocity.y),delta*10)
				look_at(Vector3(player.global_position.x + velocity.x,global_position.y,player.global_position.z + velocity.z),Vector3.UP)
		#condition
		
			"attack":
				look_at(Vector3(player.global_position.x,global_position.y,player.global_position.z),Vector3.UP)
	animtree.set("parameters/conditions/attack",target_inrange())
	animtree.set("parameters/conditions/faint",nua)
		#animtree.set("parameters/playback")
#		match state_machine.get_current_node():
#			"runn":
#				nav_agent.set_target_position(player.global_transform.origin)
#				var next_nav_point = nav_agent.get_next_path_position()
#				velocity = (next_nav_point - global_transform.origin).normalized() * SPEED
#
		#animtree.set("parameters/conditions/jump",target_inrange())
		#animtree.set("parameters/conditions/run",!target_inrange())
		#look_at(Vector3(player.global_position.x,global_position.y,player.global_position.z),Vector3.UP)
	move_and_slide()
func hitt():
	#print("hello")
	var frz = randi_range(0,5)
	if glob.fb>0 and frz == 1:
		slow = true
	$slowtime.start()
	#velocity += bir * glob.knock
func _hit_finished():
	var dir = global_position.direction_to(player.global_position)
	player.hit(dir)
func _on_area_3d_body_part_hit(dmg):
	health -= dmg
	if health <= 0:
		#moving = false
#		coin = coin.instantiate()
#		coin.position = global_position + Vector3(0,1,0)
#		if randi_range(0,1) == 1:
#			get_parent().add_child(coin)
		#glob.score += 1
		nua = true
		#queue_free()
		#bol = true
		#AnimationPlayer.play("faint")
		# Replace with function body.


func _on_animation_player_animation_finished(anim_name):
	if anim_name == "faint":
		coin = coin.instantiate()
		coin.position = global_position + Vector3(0,1,0)
		#if low == 0.5:
		if low == 1:
			print(low)
			get_parent().add_child(coin)
#		if low == 1:
#			print("super")
#			get_parent().add_child(coin)
		
		queue_free() # Replace with function body.


func _on_animation_tree_animation_finished(anim_name):
	if anim_name == "faint":
		coin = coin.instantiate()
		coin.position = global_position + Vector3(0,1,0)
		glob.score += 1
#		if randi_range(0,1) == 1:
#			get_parent().add_child(coin)
		if low == 1:
			#print(low)
			
			get_parent().add_child(coin)
		
		glob.enem -=1
		queue_free() # Replace with function body.


func _on_slowtime_timeout():
	slow = false
	$slowtime.stop() # Replace with function body.


func _on_animation_tree_animation_started(anim_name):
	if anim_name == "faint":
		glob.con = true
		aud.play()# Replace with function body.
