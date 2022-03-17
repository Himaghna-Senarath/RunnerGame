extends KinematicBody2D

var birds = []
var otherxs = []
var score = 0
var time = 0
var speedchng = 0.01
var speedcap = 15

var birdscn = load("res://source/actors/Bird.tscn")
	
func _ready():
	score = 0
	pass

func genrand(endrange):
		var rand = RandomNumberGenerator.new()
		rand.randomize()
		var x = rand.randf_range(0, endrange)
		return x
		
var newtm = 0
var newspeed = 0

var lastx = 900
func _process(delta):
	var playerobj = $"../Player"
		
	if playerobj.alive and playerobj.score > 40:
		score = playerobj.score
		
		if newtm < 0.9:
			newtm += delta
		if newtm > 0.9:
			speedchng += 0.0003
			newtm  = 0
			
		newspeed = 200*speedchng
		
		if newspeed >= speedcap:
			newspeed = speedcap
			
		if (birds.size() <= 4):
			var bird = birdscn.instance()
				
			var y_offset = 70
			var x_diff = genrand(310)
		
			var y = genrand(60) - y_offset
				
			var x_offset = (200+((newspeed*5)))
			
			var x = 200
			if len(otherxs) != 0:
				x =(lastx + x_offset + x_diff)
			elif len(otherxs) == 0:
				x= 1000
			otherxs.append(x)

			bird.position.x = x
			bird.position.y = y
			birds.append(bird)
			add_child(bird)
			lastx = x
		
		
		if playerobj.alive:
			var birds_cpy = birds
			var idx = 0
			for b in birds_cpy:
				if (b.position.x <= -1):
					birds_cpy.remove(idx)
				b.position.x-= (newspeed*(delta*100))
				idx += 1
			birds = birds_cpy

