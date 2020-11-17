extends Control

func showSubActions() -> void: 
	for child in $SubActions.get_children():
		child.queue_free() 
	for skill in Super.SKILLS_CHAR[Super.selectedCharacter.idChar]:
		var btnSkill = preload("res://ui/BtnSkillUI.tscn").instance()
		btnSkill.initButton(skill)
		btnSkill.id = skill    
		$SubActions.add_child(btnSkill)   
