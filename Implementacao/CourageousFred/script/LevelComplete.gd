extends Control

func _ready():
	$TransitionUI.fadeout_transition(null)
	if Super.level == 1 :
		$infos/lvl1.show()
	elif Super.level == 2 :
		$infos/lvl2.show()
	elif Super.level == 3 :
		$infos/lvl3.show()

	 
func _on_nextLevel_button_up():
	$TransitionUI.fadein_transition("res://scenes/Game.tscn")
 
func _on_instruction_button_up():
	$infos.hide()
	$instructions.show()
 
func _on_back_button_up():
	$infos.show()
	$instructions.hide()
