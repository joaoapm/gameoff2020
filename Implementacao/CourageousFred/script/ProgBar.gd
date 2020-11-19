extends Spatial

export(preload("res://script/Super.gd").TYPE_PROG_BAR)  var type

var timer

func _ready():  
	if type == Super.TYPE_PROG_BAR.LIFE :
		$Viewport/ProgBarLife.show()

func start(time):
	$Viewport/ProgBarCoolDown.value = 0
	$Viewport/ProgBarCoolDown.max_value  = (2 * time)
	$Viewport/ProgBarCoolDown.show()
	timer = Timer.new()
	timer.connect("timeout",self,"_on_timer_timeout")  
	timer.set_wait_time(0.5)
	add_child(timer)  
	timer.start()  

func _on_timer_timeout():
	$Viewport/ProgBarCoolDown.value += 1
	
	if $Viewport/ProgBarCoolDown.value >= $Viewport/ProgBarCoolDown.max_value :
		$Viewport/ProgBarCoolDown.hide()
		timer.stop()

func setValue(value):
	$Viewport/ProgBarLife.value = value

func setValueMax(value):
	$Viewport/ProgBarLife.max_value = value
