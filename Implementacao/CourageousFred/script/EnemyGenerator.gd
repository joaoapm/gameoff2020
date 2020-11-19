extends Spatial
 
var skillUtil = preload("res://util/SkillUtil.gd").new()

var	timer

var nbLevel1 = 1;

func init():
	timer = Timer.new()
	timer.connect("timeout",self,"processIA") 
	timer.set_wait_time(2)
	add_child(timer) 
	timer.start() 
	
	var characterAdd = load("res://comp/Character.tscn").instance()	
	characterAdd.isEnemy = true
	characterAdd.init(Super.CHARACTERS.TOWER,$p3.transform.origin) 
	$enemies.add_child(characterAdd)	
	characterAdd.look_at($p5.transform.origin, Vector3(0,1,0))

func processIA() : 
	var target = getRandomChar()
	var charAtack = getRandomEnemy()
	if target != null && charAtack != null:
		skillUtil.IA_SHOT(charAtack,target) 
 
func getRandomEnemy() -> Node:
	randomize() 
	var random = rand_range(0, $enemies.get_child_count())
	var enemySel = $enemies.get_child(random)
	if enemySel != null && enemySel.hp > 0 :
		return enemySel 
	return null	 
	
func getRandomChar() -> Node:
	randomize() 
	var random = rand_range(0, Super.charactersNode.get_child_count()) 
	var charSel = Super.charactersNode.get_child(random)
	if charSel != null && charSel.hp > 0 :
		return charSel 
	return null	 

func verifyEndLevel():
	nbLevel1 = nbLevel1 -1;
	if nbLevel1 == 0:
		Super.transitionUI.fadein_transition("res://scenes/LevelComplete.tscn")
