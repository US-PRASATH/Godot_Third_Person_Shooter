extends Node3D

const speed = 40
@onready var mesh = $MeshInstance
@onready var ray = $RayCast
@onready var ray2 = $RayCast3D2
@onready var ray3 = $RayCast3D3
@onready var particles = $GPUParticles3D
@onready var player = $/root/world1/NavigationRegion3D/player
#@onready var char = $/root/world_1/
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

#func _physics_process(delta):
	#await get_tree().create_timer(0.01).timeout
	#set_physics_process(false)
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	position+= transform.basis * Vector3(0,0,-speed) * delta
	if ray.is_colliding():
		mesh.visible = false
		particles.emitting = true
		ray.enabled = false
		if ray.get_collider().is_in_group("enemy"):
			
			#var dir = player.global_position.direction_to(ray.get_collider().global_position)
			#if ray.get_collider().has_method("hitt"):
			if ray.get_collider().get_parent().get_parent().get_parent().get_parent().has_method("hitt"):
				ray.get_collider().get_parent().get_parent().get_parent().get_parent().hitt()
			ray.get_collider().hit()
		await get_tree().create_timer(1.0).timeout
		queue_free()

	
func _yeah():
	pass
func _on_timer_timeout():
	queue_free() # Replace with function body.
