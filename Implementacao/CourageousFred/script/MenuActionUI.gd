extends Control

func _on_Move_button_up():
	Super.selectedCharacter.setAction(Super.ACTIONS.MOVE)
 
func _on_Atack_button_up():
	Super.selectedCharacter.setAction(Super.ACTIONS.ATACK)
