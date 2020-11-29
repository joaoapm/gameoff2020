extends Spatial

var hp:int = 5

func init( point) -> void: 
	$ProgBar.setValueMax(hp)
	transform.origin = point

func _on_areaBullet_body_entered(body):
	if body.get("team") != null && body.get("team") == Super.TEAM.ENEMY:
		$AudioStreamPlayer.play()
		body.queue_free()
		hp = hp - 1
		$ProgBar.setValue(hp)
		if hp == 0:
			queue_free()
