extends Spatial

var hp:int = 10

func _ready():
	pass 
 
func init( point) -> void: 
	transform.origin = point
