extends StaticBody2D

var decay = 0.005

func _ready():
	pass

func _physics_process(_delta):
	if $ColorRect.color.s > 0:
		$ColorRect.color.s -= decay
	if $ColorRect.color.v < 1:
		$ColorRect.color.v += decay

func hit(_ball):
	$ColorRect.color = Color8(64,158,68)
	var wall_sound = get_node_or_null("/root/Game/Wall_Sound")
	if wall_sound != null:
		wall_sound.play()
	$Fire.emitting = true
