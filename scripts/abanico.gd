extends Node2D

export var fuerzaViento = 500
var animar = false
var objetivo

func _ready():
	set_physics_process(true)
	#guardamos el objeto globo para llamar a su funciones despues
	objetivo = get_parent().get_node("pjPrincipal")
	
func _physics_process(delta):
	controlAnimar()
	#creamos una variable viento que empieza siempre en 0
	var viento = Vector2()
	#solo si se esta abanicando se ahra lo siguiente
	if $AnimatedSprite.animation == "start":
		#se indica que el globo ya le afecte la gravedad
		objetivo.jugando=true
		#movemos el abanico en posicion de la pantalla con el touch o mouse
		global_position = get_global_mouse_position()
		#el abanico mira hacia el globo, dandole un grado
		look_at(objetivo.global_position)
		#se calcula la direccion del viento en base al angulo del abanico.
		viento = Vector2.RIGHT.rotated(rotation)*fuerzaViento*delta
	#se le pasa el viento al globo
	objetivo.setViento(viento)
#funcion que controa el la animacion del abanico
func controlAnimar():
	var touch = Input.is_action_pressed("mouseClic")
	$AnimatedSprite.play("start" if touch else "stop")
