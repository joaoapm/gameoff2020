extends Spatial

var skillUtil = preload("res://util/SkillUtil.gd").new()

var idChar = Super.CHARACTERS.FRED 
var hp:int = 15

var action
var actionChanged
var player

var atacking:bool = false
var finalPoint
var actualPoint
var path
var actualPath:int
var changePath:bool 
var movSpeed:int = 20
var turnSpeed:int = 8
var isDead = false
var enemyPlace 
var typeBullet
var canDodge = false

var isAutoMove = false
var velocity = Vector3.ZERO
var muzzle_velocity = 5 
const lifespan = 20
var time_alive = 0.0 
var hilicopter = false
var soundAtack
var voiceExplosion = true

var idSkillCurrent = null
var isCharTargetSkillCurrent = false
var rangeSkillCurrent = 0
 
export(bool) onready var isEnemy
export(bool) onready var isImortal
export(Resource) onready var node

func _ready():
	Super.connect("on_click_btn_skill",self,"on_click_btn_skill")
	Super.connect("on_complete_skill",self,"on_complete_skill")
	
	if node != null:
		self.get_node("mesh").add_child(node.instance())
		player  = get_node("mesh").get_child(0).get_node("AnimationPlayer")
		$ProgBarLIfe.setValueMax(hp)
	
	if isAutoMove:
		velocity = transform.basis.z * muzzle_velocity
		
	if isImortal:
		$ProgBarLIfe.hide()	
		$ProgBarCoolDown.hide()	

func init(character, point) -> void: 
	var assetAdd =  Super.CHAR_ASSETS[character].instance() 
	hp = 3
	idChar = character
	$mesh.add_child(assetAdd) 
	player  = get_node("mesh").get_child(0).get_node("AnimationPlayer")
	transform.origin = point 
	$ProgBarLIfe.setValueMax(hp)
	
func _process(delta):

	if isAutoMove:
		transform.origin += 4 *  velocity * delta
		time_alive += delta	
		if time_alive > lifespan:
			queue_free() 
		
	elif actualPoint:
		var dir = (actualPoint - get_global_transform().origin).normalized()
		global_translate(dir*(delta * movSpeed ))
		 
		var quatDirLook = Quat(get_global_transform().looking_at(actualPoint, Vector3(0,1,0)).basis)
		var quatVlDirLook = Quat(get_global_transform().basis).slerp(quatDirLook, (turnSpeed * delta))
		transform.basis = Basis(quatVlDirLook)		

	if path!= null and path.size() > 1:
		player.play("MOVENDO")	
		var d = get_global_transform().origin.distance_to(path[actualPath]) 
		if d <= delta * movSpeed:
			actualPath += 1
			actualPoint = null
			
		if  (changePath) or (actualPath < path.size()): 
			if !(actualPath > path.size()) :
				actualPoint = path[actualPath]
				changePath = false
	 
		else: if 	actualPath == path.size():
			actualPath = 1 
			path = null
			set_process(false)
			player.play("ESPERANDO")

func setAction(newAction) -> void:
	if !atacking && !isEnemy && !isDead:
		action = newAction 
	
func doAction(pathMove) -> void:
	if !isEnemy && action == Super.ACTIONS.MOVE && !atacking && !isDead:
		move(pathMove) 
	 
func move(pathMove): 
	if !atacking && !isEnemy && !actionChanged && !isDead:
		changePath = true 
		actualPath = 1		
		path = pathMove	
		set_process(true)		
		
func setSelected(isSelected:bool) -> void :
	if !isEnemy:
		action = Super.ACTIONS.MOVE
		$selected.visible = isSelected;	
		Super.menuAction.showSubActions()
		if !isSelected:
			$selected/range.hide()
			rangeSkillCurrent = 0
		else: 
			var sfx
			randomize() 
			var random = int(rand_range(0, 100))
			if random > 0 && random < 33: 
				sfx = load( "res://assets/effects/zapsplat_science_fiction_alien_vocalisation_clicks_001_13076.wav") 
			elif random > 33 && random < 66: 
				sfx = load("res://assets/effects/zapsplat_science_fiction_alien_vocalisation_clicks_002_13077.wav" ) 
			elif random > 66 && random < 100: 
				sfx = load( "res://assets/effects/zapsplat_science_fiction_alien_vocalisation_clicks_003_13078.wav") 
			$SoundSelect.stream  = sfx
			$SoundSelect.play()	
	
func on_click_btn_skill(idSkill) -> void :
	if !atacking && self == Super.selectedCharacter:
		skillUtil.process(self,idSkill, null,null) 
		
func on_complete_skill(point,target) -> void :
	if !atacking && self == Super.selectedCharacter:
		skillUtil.process(self,idSkillCurrent,point,target)	
		$selected/range.hide()	
		rangeSkillCurrent = 0
		set_process(false)

func resetActions() -> void:
	idSkillCurrent = null
	$selected/range.hide()
	rangeSkillCurrent = 0
	
func doAtack(point,block,sound): 
	if !atacking:
		if point != null:
			look_at(point,Vector3(0,1,0))
		if block:
			atacking = true
		player.play("ATAQUE") 
		if sound != null:
			get_node(sound).play()
			soundAtack = sound
	
func endAtack():
	atacking = false
	player.play("ESPERANDO")	
	if soundAtack != null:
		get_node(soundAtack).stop()
	
func showAtackProgress(time):
	$ProgBarCoolDown.start(time)	

func showRange(size):
	if size == 1:
		$selected/range.show()
		rangeSkillCurrent = 10
	elif size == 2:
		rangeSkillCurrent = 20
		$selected/range2.show()	
	
func getAtackPos():
	return $mesh.get_child(0).get_node("posAtaque")		
	
func getTarget():
	return $mesh.get_child(0).get_node("target")							

func _on_damageArea_body_entered(body):
	if body != null && body.get("team") != null &&  body != self && ((isEnemy && body.team == Super.TEAM.PLAYER) || (!isEnemy && body.team == Super.TEAM.ENEMY)) && hp >= 1:
		if body.isArea:
			body.isArea = false
			body.processAreaAtack() 
			return
		body.queue_free()
		var particle = load("res://comp/Particles.tscn").instance()
		Super.charactersNode.get_parent().add_child(particle) 
		particle.init(self.voiceExplosion)
		particle.global_transform.origin = $mesh.global_transform.origin
		
		particle.emitting = true
		hp = hp - 1 
		$ProgBarLIfe.setValue(hp)
		if hp == 0:
			if atacking:
				idSkillCurrent = null 
			set_process(false)
			isDead = true
			player.play("MORTO") 
			var timer = Timer.new()
			timer.connect("timeout",self,"afterHit") 
			timer.set_wait_time(1)
			add_child(timer) 
			timer.start() 
	
func afterHit():
	queue_free()
	if idChar == Super.CHARACTERS.FRED:
		Super.transitionUI.fadein_transition("res://scenes/EngGame.tscn")
	if isEnemy:
		Super.enemyNode.verifyEndLevel(self)	
	else:
		Super.menuAction.hide()		

func addLife(vlAdd):
	hp += 1 
	$ProgBarLIfe.setValue(hp)		
