extends Node2D

# Constants
const INITIAL_BALL_SPEED = 120
const PAD_SPEED = 150

# Properties
var screen_size
var pad_size
var direction = Vector2(1.0, 0.0)
var ball_speed = INITIAL_BALL_SPEED

# Called when the node enters the scene tree for the first time.
func _ready():
	screen_size = get_viewport_rect().size
	pad_size = get_node("left").get_texture().get_size()
	set_process(true)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float):
	var left_rect = Rect2(get_node("left").position - pad_size*0.5, pad_size)
	var right_rect = Rect2(get_node("right").position - pad_size*0.5, pad_size)
	
	# Move ball
	move_ball(get_node("ball"), left_rect, right_rect, delta)
	
	# Move left pad
	move_pad(get_node("left"), "left_move_up", "left_move_down", delta)
	
	# Move right pad
	move_pad(get_node("right"), "right_move_up", "right_move_down", delta)

func move_ball(node_ball: Node2D, rect_left: Rect2, rect_right: Rect2, delta: float):
	# Integrate new ball position
	var ball_pos = node_ball.position + (direction * ball_speed * delta)
	
	# Flip when touching roof or floor
	if ((ball_pos.y < 0 and direction.y < 0) or (ball_pos.y > screen_size.y and direction.y > 0)):
		direction.y *= -1
	
	# Flip, change direction and increase speed when touching pads
	if ((rect_left.has_point(ball_pos) and direction.x < 0) or (rect_right.has_point(ball_pos) and direction.x > 0)):
		direction.x *= -1
		direction.y = randf()*2.0 - 1
		direction = direction.normalized()
		ball_speed *= 1.1
	
	# Check gameover
	if (ball_pos.x < 0 or ball_pos.x > screen_size.x):
		ball_pos = screen_size*0.5
		ball_speed = INITIAL_BALL_SPEED
		direction = Vector2(-1, 0)
	
	node_ball.position = ball_pos

func move_pad(node_pad: Node2D, event_up: String, event_down: String, delta: float):
	# Takes care of moving specified pad
	var pos = node_pad.position
	
	if (pos.y > 0 and Input.is_action_pressed(event_up)):
		pos.y += -PAD_SPEED * delta
	if (pos.y < screen_size.y and Input.is_action_pressed(event_down)):
		pos.y += PAD_SPEED * delta
		
	node_pad.position = pos
