extends Control

func _on_Move_button_up():
	Super.selectedCharacter.setAction(Super.ACTIONS.MOVE)
	$Actions/Atack.pressed = false
	$SubActions.hide() 
	
func _on_Atack_button_up():
	Super.selectedCharacter.setAction(Super.ACTIONS.ATACK)
	$Actions/Move.pressed = false 
	
func showSubActions(idChar) -> void: 
	for child in $SubActions.get_children():
		child.queue_free() 
	for skill in Super.SKILLS_CHAR[idChar]:
		var btnSkill = preload("res://ui/BtnSkillUI.tscn").instance()
		btnSkill.initButton(skill)
		btnSkill.id = skill    
		$SubActions.add_child(btnSkill) 
	$SubActions.show()	 
 
func showActions() -> void:
	show()
	$SubActions.hide()
	$Actions/Move.pressed = false 
	$Actions/Atack.pressed = false
	
func resetSkillButtons() -> void:
	for btn in $SubActions.get_children():
		btn.pressed = false	

