extends Area2D
export var siguienteMapa=""
func _ready():
	pass # Replace with function body.


func entrarCuerpo(body):
	if(body.name=="pjPrincipal"):
		get_tree().change_scene(siguienteMapa)
