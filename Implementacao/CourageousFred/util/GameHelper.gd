extends Node
 
func createTimer(node,method) -> void:
	var	timer = Timer.new()
	timer.connect("timeout",node,method) 
	timer.set_wait_time( 1 )
	node.add_child(timer) 
	timer.start() 
