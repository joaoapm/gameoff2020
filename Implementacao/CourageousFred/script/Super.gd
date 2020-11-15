extends Node
 
var camera:Camera
var navMap:Navigation
var menuAction:Control
var idSkillCurrent = null
var charactersNode

var selectedCharacter

enum ACTIONS {MOVE, ATACK}

enum CHARACTERS  { FRED, ESCAVADOR, PISTOLEIRO }

enum SKILLS { GER_ESC, GER_PIST, GER_BARRIER }
 

const  SKILLS_CHAR = {
	CHARACTERS.FRED : [SKILLS.GER_ESC, SKILLS.GER_PIST],
	CHARACTERS.ESCAVADOR : [SKILLS.GER_BARRIER]
}

const  CHAR_ASSETS = {
	CHARACTERS.ESCAVADOR :  preload("res://assets/characters/digger/Digger.tscn") 
}

# Signals
signal on_click_btn_skill(idItem)
signal on_complete_skill(point)
