extends Node

const PICKUP = "res://pickup/Pickup.tscn"

const BULLET := {
	PLASMA = "res://bullets/plasma/Plasma.tscn",
	CANNON_BALL = "res://bullets/cannon_ball/CannonBall.tscn",
	BALL_MEDIUM = "res://bullets/ball_medium/BallMedium.tscn",
}

const EFFECT := {
	HIT = "res://effects/hit/HitEffect.tscn",
	DEATH = "res://effects/death/DeathEffect.tscn",
}

const ENEMY := {
	HEXAGON = "res://enemies/hexagon/Hexagon.tscn",
	TANK = "res://enemies/tank/Tank.tscn",
	CHASER = "res://enemies/chaser/ChaserGroup.tscn",
	TRIANGLE = "res://enemies/triangle/Triangle.tscn",
	LITTLESTAR = "res://enemies/little_star/LittleStar.tscn",
	SNIPER = "res://enemies/sniper/Sniper.tscn",
}

const ABILITY := {
	SHIELD = "res://abilities/shield/Shield.tscn",
	SLOW_MOTION = "res://abilities/slow_motion/SlowMotion.tscn",
	LASERONE = "res://abilities/LASERONE/LASERONE.tscn",
	YOU_ARE_THE_BULLET = "res://abilities/you_are_the_bullet/YouAreTheBullet.tscn",
	MULTI_GUN = "res://abilities/multi_gun/MultiGun.tscn",
	MEDKIT = "res://abilities/medkit/Medkit.tscn",
}

const SPRITE := {
	ABILITY = {
		SHIELD = "res://assets/abilities/shield/AB_shield.png",
		SLOW_MOTION = "res://assets/abilities/slow_motion/AB_clock.png",
		LASERONE = "res://assets/abilities/LASERONE/Begin.png",
		YOU_ARE_THE_BULLET = "res://assets/abilities/you_are_the_bullet/AB_bullet.png",
		MULTI_GUN = "res://assets/abilities/multi_gun/AB_crosshair.png",
		MEDKIT = "res://assets/abilities/medkit/AB_medkit.png",
	}
}
