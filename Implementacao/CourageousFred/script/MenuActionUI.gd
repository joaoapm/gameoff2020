extends Control

func showSubActions() -> void: 
	for child in $SubActions.get_children():
		child.queue_free() 
	var skills = Super.SKILLS_CHAR[Super.selectedCharacter.idChar]["SKILLS"]
	if Super.level == 1:
		skills = Super.SKILLS_CHAR[Super.selectedCharacter.idChar]["SKILLS"]
	elif Super.level == 2:
		if Super.SKILLS_CHAR[Super.selectedCharacter.idChar].get("SKILLS_2") != null:
			skills = Super.SKILLS_CHAR[Super.selectedCharacter.idChar].get("SKILLS_2")
	elif Super.level == 3:
		if Super.SKILLS_CHAR[Super.selectedCharacter.idChar].get("SKILLS_3") != null:
			skills = Super.SKILLS_CHAR[Super.selectedCharacter.idChar].get("SKILLS_3")
	
	for skill in skills:
		var btnSkill = preload("res://ui/BtnSkillUI.tscn").instance()
		btnSkill.initButton(skill)
		btnSkill.id = skill    
		$SubActions.add_child(btnSkill)   

func unPress():
	for child in $SubActions.get_children():
		if child.id != Super.selectedCharacter.idSkillCurrent:
			child.pressed = false 

func hide():
	for child in $SubActions.get_children():
		child.queue_free() 	
