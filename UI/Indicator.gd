extends Node2D

var modulate_target = 0.5
var mod = 0
var scale_target = Vector2(0.25,0.25)
var sca = Vector2(0.10,0.10)

func _ready():
	$Tween.interpolate_property($Highlight, "scale", $Highlight.scale, scale_target, 0.75, Tween.TRANS_SINE, Tween.EASE_IN_OUT)
	$Tween.interpolate_property($Highlight, "modulate:a", $Highlight.modulate.a, modulate_target, 0.75, Tween.TRANS_SINE, Tween.EASE_IN_OUT)
	$Tween.start()


func _on_Tween_tween_all_completed():
	mod = 0.0 if mod == modulate_target else modulate_target
	sca = Vector2(0.5,0.5) if sca == scale_target else scale_target
	$Tween.interpolate_property($Highlight, "scale", $Highlight.scale, sca, 0.75, Tween.TRANS_SINE, Tween.EASE_IN_OUT)
	$Tween.interpolate_property($Highlight, "modulate:a", $Highlight.modulate.a, mod, 0.75, Tween.TRANS_SINE, Tween.EASE_IN_OUT)
	$Tween.start()
