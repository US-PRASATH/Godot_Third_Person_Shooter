extends Panel

var number = 0
# Called when the node enters the scene tree for the first time.
func _ready():
	$/root/mainmenu/Timer.start() # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	set_rotation(number)


func _on_timer_timeout():
	number += 0.1 # Replace with function body.
