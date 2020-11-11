extends Camera2D

func _ready():
	set_process(true
	)
func _process(delta):
		global_position =  lerp(global_position,get_parent().get_node("pjPrincipal").global_position,1) 


func contactoCuerpo(body):
	print(body.name)
