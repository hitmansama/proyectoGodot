extends KinematicBody2D
export var gravedad = 200
export var velocidadMaxima = 100
var direccion = Vector2()
var dirViento = Vector2()
export var jugando = false

func _ready():
	set_physics_process(true)
	
func _physics_process(delta):
	direccion = Vector2()
	var g = Vector2.DOWN*gravedad
	direccion+=g+dirViento
	move_and_slide(direccion)
	$Label.text = String(direccion)
func setDirViento(nuevo):
	dirViento=nuevo
