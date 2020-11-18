extends RigidBody
  
var velocity = Vector3.ZERO
 
func _physics_process(delta):
	var dir =  (Super.inimigo.get_global_transform().origin -  get_global_transform().origin).normalized()
	global_translate(dir*(150 * delta))	
	
	if self.transform.origin.distance_to(Super.inimigo.get_global_transform().origin) <= 2:
		queue_free()
  
func init(charShot):
	Super.charactersNode.add_child(self)
	transform = charShot.getAtackPos().global_transform 
