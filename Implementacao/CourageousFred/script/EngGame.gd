extends Control

func _ready():
	$TransitionUI.fadeout_transition(null)
	
	if Super.level == 1 :
		$lvl1.show()
	elif Super.level == 2 :
		$lvl2.show()
	elif Super.level == 3 :
		$lvl3.show()
				 
func _on_nextLevel_button_up():
	$TransitionUI.fadein_transition("res://scenes/Game.tscn")
