extends Spatial
 
var skillUtil = preload("res://util/SkillUtil.gd").new()

var nbLevel1 = 15;
var maxLvl1 = 3

var nbLevel2 = 2;
var maxLvl2 = 6

var nbLevel3 = 3
var maxLvl3 = 9

var places = [$p1,$p2,$p3,$p4,$p6,$p7,$p8,$p9]

func init():
	
	spawEnemy()
	spawEnemy()
	
	var timer = Timer.new()
	timer.connect("timeout",self,"spawEnemy") 
	timer.set_wait_time(5)
	add_child(timer) 
	timer.start() 

	var timerAtack = Timer.new()
	timerAtack.connect("timeout",self,"atack") 
	timerAtack.set_wait_time(2)
	add_child(timerAtack) 
	timerAtack.start() 	
 
func spawEnemy():
	if Super.level == 1 && $enemies.get_child_count() == maxLvl1 || Super.level == 2 && $enemies.get_child_count() == maxLvl2 || Super.level == 3 && $enemies.get_child_count() == maxLvl3:
		return
	var place = getRandomPlace()
	if place != null:
		places.erase(place)
		var characterAdd = load("res://comp/Character.tscn").instance()	
		characterAdd.isEnemy = true
		characterAdd.init(Super.CHARACTERS.TOWER,place.transform.origin) 
		characterAdd.enemyPlace = place
		$enemies.add_child(characterAdd)	
		characterAdd.look_at($p5.transform.origin, Vector3(0,1,0))

func atack():
	for i in $enemies.get_child_count():
		randomize() 
		var random = rand_range(0, 150)
		if random < 50:
			var target = getRandomChar()
			var charAtack = getRandomEnemy()
			if target != null && charAtack != null:
				skillUtil.IA_SHOT(charAtack,target) 

func getRandomPlace():
	if places.size() == 0:
		return null
	randomize() 
	var random = rand_range(0, places.size())
	return places[int(random)]
			
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

func verifyEndLevel(deadEnemy):
	 
	places.append(deadEnemy.enemyPlace)
	
	if Super.level == 1:
		nbLevel1 = nbLevel1 -1; 
		if  nbLevel1 == 0:
			Super.transitionUI.fadein_transition("res://scenes/LevelComplete.tscn")
			Super.level += 1

	elif Super.level == 2:
		nbLevel2 = nbLevel2 -1; 
		if  nbLevel2 == 0:
			Super.transitionUI.fadein_transition("res://scenes/LevelComplete.tscn")
			Super.level += 1		
	
	elif Super.level == 3:
		nbLevel3 = nbLevel3 -1; 
		if  nbLevel3 == 0:
			Super.transitionUI.fadein_transition("res://scenes/LevelComplete.tscn")
			Super.level += 1
