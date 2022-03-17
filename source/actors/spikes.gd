extends Sprite

var spikes = []
var otherxs = []
var score = 0

var spikescn = load("res://source/actors/spike.tscn")
var doublespikescn = load("res://source/actors/DoubleSpike.tscn")
var doublex2spikescn = load("res://source/actors/Doublex2Spike.tscn")

func genrand(endrange):
	var rand = RandomNumberGenerator.new()
	rand.randomize()
	var x = rand.randf_range(0, endrange)
	return x

		
func _ready():
	pass
		
var newspeed = 200
var framespeed = 60
var newtm = 0
var speedchng = 0.01

var lastx = 400


func _process(delta):
	var playerobj = $"../Player"
		
	if playerobj.alive:
		if newtm < 0.9:
			newtm += delta
		if newtm > 0.9:
			speedchng += 0.0003
			newtm  = 0
		
		newspeed = 200 * speedchng
		
		if newspeed >= 15:
			newspeed =15
			
		for spike in spikes:
			spike.position.x-= newspeed*(delta*60)
			
		
		if (spikes.size() <= 44):
			var type = genrand(3)
			
			var spike = spikescn.instance()
			if 1.0 > type:
				spike = spikescn.instance()
			elif 2.0 > type:
				spike = doublespikescn.instance()
			elif 2.0 < type:
				spike = doublex2spikescn.instance()
			var y = 0
				
			var x_diff = genrand(210)
			var x_offset = (250+(newspeed*0))
			var x_minus_offset = 0
			var x = 200
				
			x = (lastx + x_offset + x_diff - x_minus_offset)
			
			otherxs.append(x)
			spike.position.x = x
			spike.position.y = y
			
			spikes.append(spike)
			add_child(spike)
			lastx = x
		
		var spikes_cpy = spikes
		
		var idx = 0
		for b in spikes:
			if (b.position.x <= -100):
				spikes_cpy.remove(idx)
				b.queue_free()
			idx += 1
		spikes = spikes_cpy
			
		
			
			
