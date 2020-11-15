extends Control

func _on_Move_button_up():
	Super.selectedCharacter.setAction(Super.ACTIONS.MOVE)
 
func _on_Atack_button_up():
	Super.selectedCharacter.setAction(Super.ACTIONS.ATACK)
	
func showSubActions(idChar) -> void: 
	for child in $SubActions.get_children():
		child.queue_free() 
	for skill in Super.SKILLS_CHAR[idChar]:
		var btnSkill = preload("res://ui/BtnSkillUI.tscn").instance()
		btnSkill.setLabel(String(skill))
		btnSkill.id = skill    
		$SubActions.add_child(btnSkill)
	$Actions.hide()
	$SubActions.show()	
	$X.show()
 
func _on_X_button_up():
	$Actions.show()
	$SubActions.hide()	
	$X.hide()
