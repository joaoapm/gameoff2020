extends Control

func _ready():
	$TransitionUI.fadeout_transition(null)
 
func _on_continueButton_button_up():
	$TransitionUI.fadein_transition("res://scenes/Intro.tscn")
