extends KinematicBody2D

var direccion = Vector2()
var viento = Vector2()
export var gravedad = 200
export var jugando = false
var exploto = false

var spawn: Vector2
var auraSpawn: AnimationPlayer
var tactual
export var esperar = 1

export var vMax = 400
func _ready():
	set_physics_process(true)
	spawn =  position

func _physics_process(delta):
	#calculamos gravedad gravedad
	
	var g = Vector2.DOWN*gravedad*delta
	var v = 0
	
	if jugando and !exploto:
		#calculamos la direccion del globo afecatdo
		#por la gravedad y viento
		direccion+=g+viento
		#calculamos la velocdad lineal
		v = sqrt((direccion.x*direccion.x)+(direccion.y*direccion.y))
		#limitamos la velocidad lineal
		if v>vMax:
			direccion = direccion.normalized()*vMax
		direccion = move_and_slide(direccion)
		detectarColisionTileSets()
	else:
		if exploto:
			tactual+=delta
			if !auraSpawn:
				reaparecerSinSpawn(tactual)
			else:
				reaparecerConSpawn(tactual)
	
func reaparecerSinSpawn(transcurrido):
	if $AnimatedSprite.animation=="idle":
		$AnimatedSprite.play("boom")
	#al terminar explotar, debe esperar 1 segundo para reaparecer y reiniciar instancias
	if $AnimatedSprite.animation=="boom" and $AnimatedSprite.frame==6 and tactual>esperar:
		position=spawn
		$AnimatedSprite.play("idle")
		visible = true
		direccion=Vector2()
		exploto=false
		jugando=false

func reaparecerConSpawn(transcurrido):
	if $AnimatedSprite.animation=="idle":
		$AnimatedSprite.play("boom")
	if transcurrido>esperar:
		if auraSpawn.current_animation=="rotando":
			visible =false
			position=spawn
			auraSpawn.play("reviviendo")
		if auraSpawn.current_animation=="reviviendo" and auraSpawn.current_animation_position>=0.7:
			$AnimatedSprite.play("idle")
			$".".z_index = 1
			visible = true
			direccion=Vector2()
			exploto=false
			jugando=false
#actualiza la direccion del viento del abanico
func setViento(nuevo):
	viento=nuevo

#actualiza el checkpoint
func setSpawn(nuevoSpawn:Vector2,aura:AnimationPlayer):
	spawn = nuevoSpawn
	auraSpawn = aura

#detecta colicion con objetos que pertenecen al grupo obstaculo
#y explota el globo.

func detectarColisionTileSets():
	if !exploto:
		for i in get_slide_count():
			var collision = get_slide_collision(i)
			if collision:
				if collision.collider.is_in_group("obstaculos"):
					exploto=true
					tactual=0
				collision=null
func colission(body):
	if  body.is_in_group("obstaculos"):
		exploto=true
		tactual=0
