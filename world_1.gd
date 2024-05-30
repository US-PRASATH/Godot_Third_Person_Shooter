extends Node3D
@onready var player = $NavigationRegion3D/player
@onready var game = $scrennode
@onready var ui = $UI
@onready var spawns = $spawns
@onready var navigation_region = $NavigationRegion3D
var enemy = load("res://character.tscn")
@onready var enemtimer = $enemi
@onready var smenu = $smenu
var num = 0
var numm = 0
var fblock = true
var cplock = true
var bnlock = true
var instance
@onready var imenu = $imenu
@onready var cpbut = $smenu/ScrollContainer/VBoxContainer/cpn/cpbutton
@onready var aud = $AudioStreamPlayer
@onready var aud1 = $AudioStreamPlayer2
@onready var aud2 = $AudioStreamPlayer3
@onready var fant = $AudioStreamPlayer5
@onready var toco = $toco

# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
	
	
	
	ui.get_node("wav").show()
	ui.get_node("AnimationPlayer").play("wave") # Replace with function body.
	aud.play()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
#	if glob.con:
#		fant.play()
#	if game.visible:
#		glob.player_name = game.LineEdit.text
	if fant.playing:
		glob.con = false
	if glob.hplvl >=5 or glob.splvl >=5 or glob.jlvl >=5 or glob.frlvl >= 5:
		fblock = false
	if glob.score>= 25:
		cplock = false
	if glob.score>=16:
		bnlock = false
	if cplock:
		smenu.get_node("ScrollContainer/VBoxContainer/cpn/clvl").hide()
		smenu.get_node("ScrollContainer/VBoxContainer/cpn/cpcost").hide()
		smenu.get_node("ScrollContainer/VBoxContainer/cpn/cpbutton").hide()
		smenu.get_node("ScrollContainer/VBoxContainer/cpn/cp").hide()
	if !cplock:
		smenu.get_node("ScrollContainer/VBoxContainer/cpn/clvl").show()
		smenu.get_node("ScrollContainer/VBoxContainer/cpn/cpcost").show()
		smenu.get_node("ScrollContainer/VBoxContainer/cpn/cpbutton").show()
		smenu.get_node("ScrollContainer/VBoxContainer/cpn/cp").show()
		smenu.get_node("ScrollContainer/VBoxContainer/cpn/cplock").hide()
	if fblock:
		smenu.get_node("ScrollContainer/VBoxContainer/fbn/fblvl").hide()
		smenu.get_node("ScrollContainer/VBoxContainer/fbn/fbcost").hide()
		smenu.get_node("ScrollContainer/VBoxContainer/fbn/fbbutton").hide()
		smenu.get_node("ScrollContainer/VBoxContainer/fbn/fb").hide()
	if !fblock:
		smenu.get_node("ScrollContainer/VBoxContainer/fbn/fblvl").show()
		smenu.get_node("ScrollContainer/VBoxContainer/fbn/fbcost").show()
		smenu.get_node("ScrollContainer/VBoxContainer/fbn/fbbutton").show()
		smenu.get_node("ScrollContainer/VBoxContainer/fbn/fb").show()
		smenu.get_node("ScrollContainer/VBoxContainer/fbn/fblock").hide()
	if bnlock:
		smenu.get_node("ScrollContainer/VBoxContainer/bn/bnlvl").hide()
		smenu.get_node("ScrollContainer/VBoxContainer/bn/bncost").hide()
		smenu.get_node("ScrollContainer/VBoxContainer/bn/bnbutton").hide()
		smenu.get_node("ScrollContainer/VBoxContainer/bn/bn").hide()
	if !bnlock:
		smenu.get_node("ScrollContainer/VBoxContainer/bn/bnlvl").show()
		smenu.get_node("ScrollContainer/VBoxContainer/bn/bncost").show()
		smenu.get_node("ScrollContainer/VBoxContainer/bn/bnbutton").show()
		smenu.get_node("ScrollContainer/VBoxContainer/bn/bn").show()
		smenu.get_node("ScrollContainer/VBoxContainer/bn/bnlock").hide()
	if glob.hplvl >=3 or glob.splvl >=3 or glob.jlvl >=3 or glob.frlvl >= 3:
		enemtimer.wait_time = 2
	if glob.hplvl >=7 or glob.splvl >=7 or glob.jlvl >=7 or glob.frlvl >= 6:
		enemtimer.wait_time = 1
	if Input.is_action_just_pressed("skillmenu"):
		if num==0:
			smenu.show()
			num=1
			Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
		else:
			smenu.hide()
			num=0
			Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
			
	if Input.is_action_just_pressed("pause"):
		if numm==0:
			imenu.show()
			numm=1
			Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
		else:
			imenu.hide()
			numm=0
			Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	if player.health>=0:
		ui.get_node("health").text = "Health: " + str(player.health)
	ui.get_node("score").text = "Score: " + str(glob.score)
	ui.get_node("coins").text = "Coins: " + str(glob.coins)
	ui.get_node("ene").text = "Enemies: " + str(glob.enem)
	ui.get_node("wav").text = "Wave " + str(glob.wav)
	
	#skill menu
	smenu.get_node("ScrollContainer/VBoxContainer/hpn/hp").text = "HP: " + str(glob.hp)
	smenu.get_node("ScrollContainer/VBoxContainer/hpn/hpcost").text = "Cost: " + str(glob.hpcost)
	smenu.get_node("ScrollContainer/VBoxContainer/hpn/hplvl").text = "LVL: " + str(glob.hplvl)
	smenu.get_node("ScrollContainer/VBoxContainer/spn/sp").text = "SPEED: " + str(glob.sp)
	smenu.get_node("ScrollContainer/VBoxContainer/spn/spcost").text = "Cost: " + str(glob.spcost)
	smenu.get_node("ScrollContainer/VBoxContainer/spn/splvl").text = "LVL: " + str(glob.splvl)
	smenu.get_node("ScrollContainer/VBoxContainer/jn/j").text = "JUMP: " + str(glob.j)
	smenu.get_node("ScrollContainer/VBoxContainer/jn/jcost").text = "Cost: " + str(glob.jcost)
	smenu.get_node("ScrollContainer/VBoxContainer/jn/jlvl").text = "LVL: " + str(glob.jlvl)
	smenu.get_node("ScrollContainer/VBoxContainer/frn/fr").text = "FIRE RT: " + str(glob.fr)
	smenu.get_node("ScrollContainer/VBoxContainer/frn/frcost").text = "Cost: " + str(glob.frcost)
	smenu.get_node("ScrollContainer/VBoxContainer/frn/frlvl").text = "LVL: " + str(glob.frlvl)
	smenu.get_node("ScrollContainer/VBoxContainer/fbn/fb").text = "FRZ BLT: " + str(glob.fb)
	smenu.get_node("ScrollContainer/VBoxContainer/fbn/fbcost").text = "Cost: " + str(glob.fbcost)
	smenu.get_node("ScrollContainer/VBoxContainer/fbn/fblvl").text = "LVL: " + str(glob.fblvl)
	smenu.get_node("ScrollContainer/VBoxContainer/cpn/cp").text = "CN PRB: " + str(glob.cp)
	smenu.get_node("ScrollContainer/VBoxContainer/cpn/cpcost").text = "Cost: " + str(glob.cpcost)
	smenu.get_node("ScrollContainer/VBoxContainer/cpn/clvl").text = "LVL: " + str(glob.cplvl)
	smenu.get_node("ScrollContainer/VBoxContainer/bn/bn").text = "BLT SPR: " + str(glob.bn)
	smenu.get_node("ScrollContainer/VBoxContainer/bn/bncost").text = "Cost: " + str(glob.bncost)
	smenu.get_node("ScrollContainer/VBoxContainer/bn/bnlvl").text = "LVL: " + str(glob.bnlvl)
	if player.health == 0:
		gover()
		
func gover():
	game.show()
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE

func _get_random_child(parent_node):
	var rand_id = randi() % parent_node.get_child_count()
	return parent_node.get_child(rand_id)
func _on_button_pressed():
	player.can_move = true
	player.health = 10
	get_tree().change_scene_to_file("res://world_1.tscn")
	game.hide()
	glob.score = 0
	glob.coins = 0
	glob.hp = 10
	glob.sp = 5
	glob.j = 6
	glob.fr = 0.2 # Replace with function body.
	glob.hpcost = 5
	glob.spcost = 5
	glob.jcost = 5
	glob.frcost = 5
	glob.hplvl = 1
	glob.splvl = 1
	glob.jlvl = 1
	glob.frlvl = 1
	glob.cpmax = 0
	glob.cp = 0.5
	glob.fb = 0.5
	glob.knock = 0
	glob.bn = 1
	glob.fblvl = 1
	glob.cplvl = 1
	glob.bnlvl = 1
	glob.cpcost = 25
	glob.fbcost = 15
	glob.bncost = 25
	glob.enem = 0
	glob.wav = 1
	glob.curr = 0
	glob.cpcount = 3
func _on_enemi_timeout():
	if glob.enem <= 13:
		if glob.curr <= glob.cpcount:
			var spawn_point = _get_random_child(spawns).global_position
			instance = enemy.instantiate()
			var ra = randf_range(0.1,0.25)
			instance.scale.x = ra
			instance.scale.y = ra
			instance.scale.z = ra
			instance.position = spawn_point
			navigation_region.add_child(instance)
			glob.curr+=1
			glob.enem +=1
		if glob.enem == 0 and glob.curr == glob.cpcount+1:
			glob.wav +=1
			ui.get_node("wav").show()
			ui.get_node("AnimationPlayer").play("wave")
			glob.cpcount +=2
			glob.curr = 0
#		if glob.curr > glob.cpcount:
#			glob.cpcount += 2
#			glob.curr = 0 # Replace with function body.


func _on_hbutton_pressed():
	if glob.hpcost <= glob.coins:
		glob.hp += 2
		player.health = glob.hp
		glob.coins -= glob.hpcost
		glob.hpcost +=5
		glob.hplvl += 1
		aud1.play() # Replace with function body.


func _on_spbutton_pressed():
	if glob.spcost <= glob.coins:
		glob.sp += 1
		
		glob.coins -= glob.spcost
		glob.spcost +=5
		glob.splvl += 1
		aud1.play() # Replace with function body.


func _on_frbutton_pressed():
	if glob.frcost <= glob.coins:
		glob.fr -= 0.02
		
		glob.coins -= glob.frcost
		glob.frcost +=5
		glob.frlvl += 1
		aud1.play() # Replace with function body.


func _on_jbutton_pressed():
	if glob.jcost <= glob.coins:
		glob.j += 1
		
		glob.coins -= glob.jcost
		glob.jcost +=5
		glob.jlvl += 1
		aud1.play() # Replace with function body.


func _on_res_pressed():
	player.can_move = true
	player.health = 10
	get_tree().change_scene_to_file("res://world_1.tscn")
	game.hide()
	glob.score = 0
	glob.coins = 0
	glob.hp = 10
	glob.sp = 5
	glob.j = 6
	glob.fr = 0.2 # Replace with function body.
	glob.hpcost = 5
	glob.spcost = 5
	glob.jcost = 5
	glob.frcost = 5
	glob.hplvl = 1
	glob.splvl = 1
	glob.jlvl = 1
	glob.frlvl = 1 # Replace with function body.
	glob.cp = 0.5
	glob.fb = 0.5
	glob.knock = 0
	glob.bn = 1
	glob.fblvl = 1
	glob.cplvl = 1
	glob.bnlvl = 1
	glob.cpcost = 25
	glob.fbcost = 15
	glob.bncost = 25
	glob.cpmax = 0
	glob.enem = 0
	glob.wav = 1
	glob.curr = 0
	glob.cpcount = 3
	if get_tree().paused == true:
		get_tree().paused = false
		numm=0
func _on_res_2_pressed():
	get_tree().quit() # Replace with function body.


func _on_fbbutton_pressed():
	if glob.fbcost <= glob.coins:
		glob.fb += 0.2
		glob.knock += 30
		glob.coins -= glob.fbcost
		glob.fbcost +=5
		glob.fblvl += 1 # Replace with function body.
		aud1.play()

func _on_cpbutton_pressed():
	if glob.cpmax == 0:
		if glob.cpcost <= glob.coins:
			glob.cp = 1
			glob.cpmax = 1
			print(glob.cp)
			glob.coins -= glob.cpcost
			glob.cpcost = "-"
			glob.cplvl = "MAX" # Replace with function body.
			aud1.play()

func _on_bnbutton_pressed():
	if glob.bnlvl<3:
		if glob.bncost <= glob.coins:
			glob.bn += 1
			
			glob.coins -= glob.bncost
			glob.bncost +=10
			glob.bnlvl += 1
			aud1.play() # Replace with function body.


func _on_tshoot_pressed():
	player.yesshoot = true# Replace with function body.


func _on_pbut_pressed():
	if numm==0:
		aud2.play()
		imenu.show()
		get_tree().paused = true
		numm=1
		#Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	else:
		aud2.play()
		imenu.hide()
		get_tree().paused = false
		numm=0
		#Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	# Replace wiefsth function body.


func _on_skbut_pressed():
	if num==0:
		aud2.play()
		smenu.show()
		num=1
		#Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	else:
		aud2.play()
		smenu.hide()
		num=0
		#Input.mouse_mode = Input.MOUSE_MODE_CAPTURED # Replace with function body.

func _unpause():
	numm=0
	imenu.hide()
	get_tree().paused = false
	aud2.play()
func _on_sprbut_pressed():
	player.touchsprint = true # Replace with function body.


func _on_jumbut_pressed():
	player._jump() # Replace with function body.


func _on_sprbut_released():
	player.touchsprint = false # Replace with function body.


func _on_tshoot_released():
	player.yesshoot = false # Replace with function body.


func _on_animation_player_animation_finished(anim_name):
	if anim_name == "wave":
		ui.get_node("wav").hide()# Replace with function body.


func _on_area_2d_mouse_entered():
	glob.mous = true # Replace with function body.


func _on_area_2d_mouse_exited():
	glob.mous = false # Replace with function body.


func _on_res_23_pressed():
	get_tree().change_scene_to_file("res://mainmenu.tscn") # Replace with function body.
	player.can_move = true
	player.health = 10
	#get_tree().change_scene_to_file("res://world_1.tscn")
	game.hide()
	glob.score = 0
	glob.coins = 0
	glob.hp = 10
	glob.sp = 5
	glob.j = 6
	glob.fr = 0.2 # Replace with function body.
	glob.hpcost = 5
	glob.spcost = 5
	glob.jcost = 5
	glob.frcost = 5
	glob.hplvl = 1
	glob.splvl = 1
	glob.jlvl = 1
	glob.frlvl = 1
	glob.cpmax = 0
	glob.cp = 0.5
	glob.fb = 0.5
	glob.knock = 0
	glob.bn = 1
	glob.fblvl = 1
	glob.cplvl = 1
	glob.bnlvl = 1
	glob.cpcost = 25
	glob.fbcost = 15
	glob.bncost = 25
	glob.enem = 0
	glob.wav = 1
	glob.curr = 0
	glob.cpcount = 3

func _on_button_2_pressed():
	glob.player_name = game.get_node("LineEdit").text # Replace with function body.
	SilentWolf.Scores.save_score(glob.player_name, glob.score)
	game.get_node("LineEdit").text = ""
