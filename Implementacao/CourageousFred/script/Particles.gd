extends Particles


func init(voiceExplosion):
	if voiceExplosion:
		$voiceExplosion.play()
	else:
		$explosion.play()
