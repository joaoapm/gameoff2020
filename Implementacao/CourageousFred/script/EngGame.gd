extends Control

func _ready():
	$TransitionUI.fadeout_transition(null)
 
func _on_nextLevel_button_up():
	$TransitionUI.fadein_transition("res://scenes/Game.tscn")
