extends Spatial

var level
var currentMap

func _ready():
	for child in get_children():
		child.queue_free() 
	if Super.level == 1:
		currentMap = load("res://assets/maps/map1/Map1.tscn").instance()	
		add_child(currentMap)
	elif Super.level == 2:
		currentMap = load("res://assets/maps/map2/Map2.tscn").instance()	
		add_child(currentMap)
	elif Super.level == 3:
		currentMap = load("res://assets/maps/map3/Map3.tscn").instance()	
		add_child(currentMap)
		
func getNavMap() -> Node :
	return currentMap  

func getEnemyGenerator() -> Node :
	return currentMap.get_node("EnemyGenerator") 
		
func getCamera() -> Node :
	return currentMap.get_node("Camera") 
	
func getCharactersNode() -> Node :
	return currentMap.get_node("Characters") 

func _unhandled_input(event): 
	
		if event is InputEventMouseButton and event.button_index == BUTTON_LEFT and event.pressed: 
			var character =  clickedCharacter()
			
			if character != null:
				if Super.selectedCharacter != null:
					var from = Super.camera.project_ray_origin(event.position)	 
					var to = from + Super.camera.project_ray_normal(event.position)*1000
					var p = Super.navMap.get_closest_point_to_segment(from, to)
					var distanceRange = Super.selectedCharacter.get_global_transform().origin.distance_to(p)
					if Super.selectedCharacter.idSkillCurrent != null && distanceRange <= Super.selectedCharacter.rangeSkillCurrent && Super.selectedCharacter.isCharTargetSkillCurrent == true: 
						Super.emit_signal("on_complete_skill",p)
					else:	
						Super.selectedCharacter.setSelected(false)	
						Super.selectedCharacter	 = character
						Super.selectedCharacter.setSelected(true)	
				else:		
					Super.selectedCharacter	 = character
					Super.selectedCharacter.setSelected(true)	
				
			elif Super.selectedCharacter != null:
				var from = Super.camera.project_ray_origin(event.position)	 
				var to = from + Super.camera.project_ray_normal(event.position)*1000
				var p = Super.navMap.get_closest_point_to_segment(from, to)
				var distanceRange = Super.selectedCharacter.get_global_transform().origin.distance_to(p)
				if Super.selectedCharacter.idSkillCurrent != null && distanceRange <= 10 && Super.selectedCharacter.isCharTargetSkillCurrent == false: 
					Super.emit_signal("on_complete_skill",p)
				else :
								
					var begin = Super.navMap.get_closest_point(Super.selectedCharacter.get_translation())
					var end = p
								
					var p2 = Super.navMap.get_simple_path(begin, end, true)
					var path = Array(p2)  
					
					Super.selectedCharacter.doAction(path)	


func clickedCharacter() -> Node :
	var mouse_pos = get_viewport().get_mouse_position()
	var ray_from = Super.camera.project_ray_origin(mouse_pos)
	var ray_to = ray_from + Super.camera.project_ray_normal(mouse_pos) * 1000
	var space_state = get_world().direct_space_state
	var selection = space_state.intersect_ray(ray_from, ray_to)

	if selection.size() > 0:
		return selection.collider
	else :
		return null
