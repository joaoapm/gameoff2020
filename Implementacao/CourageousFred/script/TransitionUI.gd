extends Control
 
export(String, FILE, "*.tscn") var next_scene_path
 
onready var _anim_player := $AnimationPlayer

func fadein_transition(_next_scene) -> void: 
	$FADEIN.show()
	$AnimationPlayer.play("FADEIN")
	yield(_anim_player, "animation_finished") 
	$FADEIN.hide()
	if _next_scene != null:
		get_tree().change_scene(_next_scene)
	 
func fadeout_transition(_next_scene) -> void: 
	$FADEOUT.show()
	$AnimationPlayer.play("FADEOUT")
	yield(_anim_player, "animation_finished") 
	$FADEOUT.hide()
	if _next_scene != null:
		get_tree().change_scene(_next_scene)
