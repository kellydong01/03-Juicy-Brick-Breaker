extends StaticBody2D

var score = 0
var new_position = Vector2.ZERO
var dying = false
export var time_appear = 0.5
export var time_fall = 0.8
export var time_rotate = 1.0
export var time_a = 0.8
export var time_s = 1.2
export var time_v = 1.5

export var sway_amplitude = 3.0

var colors = [
	Color8(150,242,215)
	,Color8(64,192,87)
	,Color8(92,148,13)
	,Color8(245,159,25)
	,Color8(255,192,120)
	,Color8(59,201,219)
	,Color8(103,65,217)
	,Color8(76,110,245)
]
var color_index = 0
var color_initial_position = Vector2.ZERO
var color_randomizer = Vector2.ZERO

func _ready():
	randomize()
	position.x = new_position.x
	position.y = -100
	$Tween.interpolate_property(self, "position", position, new_position, 0.5 + randf()*2, Tween.TRANS_BOUNCE, Tween.EASE_IN_OUT)
	$Tween.start()
	if score >= 100: color_index = 0
	elif score >= 90: color_index = 1
	elif score >= 80: color_index = 2
	elif score >= 70: color_index = 3 
	elif score >= 60: color_index=  4
	elif score >= 50: color_index = 5
	elif score >= 40: color_index = 6
	else: color_index = 7
	$ColorRect.color = colors[color_index]
	color_initial_position = $ColorRect.rect_position
	color_randomizer = Vector2(randf()*6-3.0, randf()*6-3.0)

func _physics_process(_delta):
	if dying and not $Stars.emitting and not $Tween.is_active():
		queue_free()

func hit(_ball):
	var brick_sound = get_node_or_null("/root/Game/Brick_Sound")
	if brick_sound != null:
		brick_sound.play()
	die()

func die():
	dying = true
	collision_layer = 0
	$ColorRect.hide()
	Global.update_score(score)
	get_parent().check_level()
	$Stars.emitting = true
	$Tween.interpolate_property(self, "position", position, Vector2(position.x, 1000), time_fall, Tween.TRANS_EXPO, Tween.EASE_IN)
	$Tween.interpolate_property(self, "rotation", rotation, -PI + randf()*2*PI, time_rotate, Tween.TRANS_QUAD, Tween.EASE_IN_OUT)
	$Tween.interpolate_property($ColorRect, "color:a", $ColorRect.color.a, 0, time_a, Tween.TRANS_ELASTIC, Tween.EASE_IN_OUT)
	$Tween.interpolate_property($ColorRect, "color:s", $ColorRect.color.s, 0, time_s, Tween.TRANS_ELASTIC, Tween.EASE_IN_OUT)
	$Tween.interpolate_property($ColorRect, "color:v", $ColorRect.color.v, 0, time_v, Tween.TRANS_ELASTIC, Tween.EASE_IN_OUT)
	$Tween.start()
