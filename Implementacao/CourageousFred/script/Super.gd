extends Node
 
var camera:Camera
var navMap:Navigation
var menuAction:Control
var idSkillCurrent = null

var selectedCharacter

enum ACTIONS {MOVE, ATACK}

enum CHARACTERS  { FRED, ESCAVADOR, PISTOLEIRO }

enum SKILLS { GER_ESC, GER_PIST }
 

const  SKILLS_CHAR = {
	CHARACTERS.FRED : [SKILLS.GER_ESC, SKILLS.GER_PIST]
}


# Signals
signal on_click_btn_skill(idItem)
signal on_complete_skill(point)
