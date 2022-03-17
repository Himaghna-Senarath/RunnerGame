extends Popup

onready var player = $"../Player"
onready var lbl = $'Restart'
onready var spikes = $"../spikes"
var already_paused
var selected_menu

func _ready():
	pass 
		
func _process(delta):
	if not player.alive:
		lbl.text = str("TAP TO RESTART", "\n\n   SCORE ", player.score)
		popup_centered_ratio(0.3)
		if Input.is_mouse_button_pressed(1) or Input.is_action_just_pressed("ui_up"):
				hide()
				player.reset()
				get_tree().reload_current_scene()
			
