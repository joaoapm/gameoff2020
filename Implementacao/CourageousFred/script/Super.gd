extends Node
 
var camera:Camera
var navMap:Navigation
var menuAction:Control
var idSkillCurrent = null
var charactersNode

var selectedCharacter

enum ACTIONS {MOVE, ATACK}

enum TYPE_PROG_BAR {LIFE, COOLDONW}

enum CHARACTERS  { FRED, ESCAVADOR, PISTOLEIRO, DOCTOR, ROCKETER, SMOKER, GRANADIER  }

enum SKILLS { GER_ESC, GER_PIST, GER_DOC, GER_ROCKT, GER_SMOK, GER_GRANAD, GER_BARRIER, GUNS_SHOT }
 

const  SKILLS_CHAR = {
	CHARACTERS.FRED : { "ID" : CHARACTERS.FRED, "SKILLS" : [SKILLS.GER_ESC, SKILLS.GER_PIST, SKILLS.GER_DOC, SKILLS.GER_ROCKT, SKILLS.GER_SMOK, SKILLS.GER_GRANAD ]},
	CHARACTERS.ESCAVADOR :  { "ID" : CHARACTERS.ESCAVADOR, "SKILLS" : [SKILLS.GER_BARRIER ]},
	CHARACTERS.PISTOLEIRO : { "ID" : CHARACTERS.PISTOLEIRO, "SKILLS" : [SKILLS.GUNS_SHOT ]}
}

const  CHAR_ASSETS = {
	CHARACTERS.ESCAVADOR :  preload("res://assets/characters/digger/Digger.tscn"),
	CHARACTERS.PISTOLEIRO :  preload("res://assets/characters/gunslinger/gunslinger.tscn") 
}

var COOLDOWN = []

# Signals
signal on_click_btn_skill(idItem)
signal on_complete_skill(point)
signal on_verify_cooldown()
