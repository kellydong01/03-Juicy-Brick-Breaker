extends KinematicBody2D

var rot_d = [3.5, -3.5]
var direction = [Vector2(3.5, 1.25), Vector2(-3.5, -1.25), Vector2(-3.5, 1.25), Vector2(3.5, -1.25)]
var r = 0
var d = 0

func _ready():
	randomize()
	r = rot_d[randi() % rot_d.size()]
	d = direction[randi() % direction.size()]

func _physics_process(_delta):
	rotation_degrees += r
	position += d
	position.x = wrapf(position.x, 0, 1024)
	position.y = wrapf(position.y, 0, 800)
