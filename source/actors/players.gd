extends KinematicBody2D
class_name player

export var score = 0
export var hiscore = 0
export var speed: =  Vector2(400, 500)
export var gravity: = 9000.0

const UP = Vector2(0, -1)

onready var _animated_sprite = $AnimatedSprite

var Velocity: = Vector2.ZERO
var jump = false
var alive = true
var time = 0
var spawnbirds = false
var spawnspikes = false

func reset():
	Velocity.y = 0
	#player.position.x = 80
	score = 0
	time = 0
	
func _process(delta):
	var scorelbl = $'../Score'
	var hiscorelbl = $'../HiScore'
	
	if alive:
		_animated_sprite.play("Run")
		if time < 0.15:
			time += delta
		if time >= 0.15:
			score += 1
			time  = 0
			
		if score >= hiscore:
			hiscore = score
	scorelbl.text = str("SCORE ", score)
	hiscorelbl.text = str("HighScore ", score)
	
	
var collisionsoundplayed = false

var jump_pressed = false

func _physics_process(event):
	var player = $"../Player"
	for i in get_slide_count():
		var collision = get_slide_collision(i)
		if collision.collider.name != 'TileMap':
			alive = false
			if not collisionsoundplayed:
				$"..//CollisionSFX".play()
				collisionsoundplayed = true
	
	if alive:	
		if Input.is_mouse_button_pressed(1) or Input.is_action_pressed("ui_up"):
			_animated_sprite.stop()
			Velocity.y -= 200
		else:
			Velocity.y = +200
		if player.position.y <= 55:
			Velocity.y = +200
			
		player.position.x = 80
		move_and_slide(Velocity, UP)
		
		
		
		
		
