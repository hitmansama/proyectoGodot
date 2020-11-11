extends Area2D

var miSprite = Sprite
var activado = false

func _ready():
	miSprite = $Sprite




func _on_Area2D_body_entered(body):
	if body.name == "pjPrincipal" and !activado:
		$Sprite.self_modulate = Color(0,1,0)
		if !activado:
			body.setSpawn(position,$AnimationPlayer)
			activado=true


func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name=="reviviendo":
		$AnimationPlayer.play("rotando")
