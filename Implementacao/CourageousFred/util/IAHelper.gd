extends Node

var skillUtil = preload("res://util/SkillUtil.gd").new()
var	timer
func init(node) -> void:
	timer = Timer.new()
	timer.connect("timeout",self,"processIA") 
	timer.set_wait_time(2)
	node.add_child(timer) 
	#timer.start() 

func processIA() : 
	var target = Super.charactersNode.get_child(0)
	var charAtack = Super.enemyNode.get_child(0)
	if target != null && charAtack != null:
		skillUtil.IA_SHOT(charAtack,target) 

