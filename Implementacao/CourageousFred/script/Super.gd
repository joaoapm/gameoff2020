extends Node
 
var camera:Camera
var navMap:Navigation
var menuAction:Control
var charactersNode
var enemyNode
var inimigo
var transitionUI
var level = 2

var selectedCharacter

enum TYPE_BULLET {BULLET, ROCKET}

enum TEAM {PLAYER, ENEMY}

enum ACTIONS {MOVE, ATACK}

enum TYPE_PROG_BAR {LIFE, COOLDONW}

enum CHARACTERS  { FRED, DIGGER, GUNSLINGER, DOCTOR, ROCKETER, SMOKER, GRANADIER, TOWER, CANNON, HELICOPTER  }

enum SKILLS { GER_ESC, GER_GUNS, GER_DOC, GER_ROCKT, GER_SMOK, GER_GRANAD, GER_BARRIER, GUNS_SHOT, ROCKET_SHOOT, CURE, AERIAL_ATACK }
 
const COOLDOWN_SKILL = 2

const  SKILLS_CHAR = {
	CHARACTERS.FRED : { "ID" : CHARACTERS.FRED, "SKILLS" : [SKILLS.GER_ESC, SKILLS.GER_GUNS], "SKILLS_2" : [SKILLS.GER_ESC, SKILLS.GER_GUNS, SKILLS.GER_DOC, SKILLS.GER_ROCKT ], "SKILLS_3" : [SKILLS.GER_ESC, SKILLS.GER_GUNS, SKILLS.GER_DOC, SKILLS.GER_ROCKT, SKILLS.GER_GRANAD ]},
	CHARACTERS.DIGGER :  { "ID" : CHARACTERS.DIGGER, "SKILLS" : [SKILLS.GER_BARRIER ]},
	CHARACTERS.GUNSLINGER : { "ID" : CHARACTERS.GUNSLINGER, "SKILLS" : [SKILLS.GUNS_SHOT ]},
	CHARACTERS.DOCTOR : { "ID" : CHARACTERS.DOCTOR, "SKILLS" : [SKILLS.CURE ]},
	CHARACTERS.ROCKETER : { "ID" : CHARACTERS.ROCKETER, "SKILLS" : [SKILLS.AERIAL_ATACK ]}
}

const  CHAR_ASSETS = {
	CHARACTERS.DIGGER :  preload("res://assets/characters/digger/Digger.tscn"),
	CHARACTERS.GUNSLINGER :  preload("res://assets/characters/gunslinger/gunslinger.tscn"),
	CHARACTERS.TOWER :  preload("res://assets/characters/tower/tower.tscn"),
	CHARACTERS.CANNON :  preload("res://assets/characters/cannon/cannon.tscn"),
	CHARACTERS.DOCTOR :  preload("res://assets/characters/doctor/doctor.tscn") ,
	CHARACTERS.ROCKETER :  preload("res://assets/characters/rocketeer/rocketeer.tscn"),
	CHARACTERS.HELICOPTER :  preload("res://assets/characters/helicopter/helicopter.tscn")    
}

var COOLDOWN = []

# Signals
signal on_click_btn_skill(idItem)
signal on_complete_skill(point,target)
signal on_verify_cooldown()
signal on_hit_target(target,body)
