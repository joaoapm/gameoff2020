extends Control

func showSubActions() -> void: 
	for child in $SubActions.get_children():
		child.queue_free() 
	for skill in Super.SKILLS_CHAR[Super.selectedCharacter.idChar]["SKILLS"]:
		var btnSkill = preload("res://ui/BtnSkillUI.tscn").instance()
		btnSkill.initButton(skill)
		btnSkill.id = skill    
		$SubActions.add_child(btnSkill)   

func unPress():
	for child in $SubActions.get_children():
		if child.id != Super.idSkillCurrent:
			child.pressed = false
			break
	
