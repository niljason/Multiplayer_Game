var _kr = keyboard_check(btn_right);
var _kl = keyboard_check(btn_left);
var _ku = keyboard_check_pressed(btn_up); // change to press so need keyboard input again
var _kd = keyboard_check_pressed(btn_down);
var hmove = _kr - _kl;

var _just_detached = false;

// Stay fixed to steel until the jump button releases the magnet.
if (attached_steel != noone) {
	if (!instance_exists(attached_steel)) {
		attached_steel = noone;
		attached_side = 0;
		attached_xspd = 0;
		x_remain = 0;
	} else if (_ku || (grav_dir == -1 && _kd)) {
		yspd = -attached_side * jump_spd;
		attached_steel = noone;
		attached_side = 0;
		attached_xspd = 0;
		x_remain = 0;
		y_remain = 0;
		_just_detached = true;
	} else {
		// Move along the steel face without detaching.
		var _left_offset = bbox_left - x;
		var _right_offset = bbox_right - x;
		var _min_x = attached_steel.bbox_left - _left_offset;
		var _max_x = attached_steel.bbox_right - _right_offset;
		attached_xspd = approach(attached_xspd, hmove * attached_move_speed,
			(hmove == 0) ? attached_move_decel : attached_move_accel);
		var _total_x = attached_xspd + x_remain;
		var _whole_x = floor(abs(_total_x)) * sign(_total_x);
		x_remain = _total_x - _whole_x;
		var _target_x = clamp(x + _whole_x, _min_x, _max_x);
		var _move_x = round(_target_x - x);
		var _move_dir = sign(_move_x);
		var _blocked = false;
		repeat (abs(_move_x)) {
			if (!place_meeting(x + _move_dir, y, obj_collidable)) {
				x += _move_dir;
			} else {
				_blocked = true;
				break;
			}
		}
		if (_blocked || x + _whole_x != _target_x) {
			x_remain = 0;
			attached_xspd = 0;
		} else if (hmove == 0 && abs(attached_xspd) < attached_move_decel) {
			attached_xspd = 0;
			x_remain = 0;
		}
		y = attached_steel.y + attached_offset_y;
		attached_offset_x = x - attached_steel.x;
		xspd = 0;
		yspd = 0;
		y_remain = 0;
		keep_players_in_shared_view();
		exit;
	}
}

var _jump_pressed = _ku || (_kd && grav_dir == -1);
var _steel_side = noone;
if (place_meeting(x - 1, y, obj_steel)) {
	_steel_side = instance_place(x - 1, y, obj_steel);
} else if (place_meeting(x + 1, y, obj_steel)) {
	_steel_side = instance_place(x + 1, y, obj_steel);
}
var _side_jump = !_just_detached && _jump_pressed && _steel_side != noone;
if (_side_jump) {
	var _actor_center = (bbox_left + bbox_right) * 0.5;
	var _steel_center = (_steel_side.bbox_left + _steel_side.bbox_right) * 0.5;
	var _away_dir = sign(_actor_center - _steel_center);
	if (_away_dir == 0) _away_dir = (hmove == 0) ? -1 : -sign(hmove);

	xspd = _away_dir * max_xspd;
	yspd = -grav_dir * jump_spd;
}

// is on the ground?
var grounded = touching_ground(grav_dir);
if (grounded) { coyote_timer = coyote_frames; }
else { coyote_timer = max(coyote_timer-1, 0); }

var _jump = !_just_detached && !_side_jump && (coyote_timer > 0) && (_ku || (_kd && grav_dir == -1));

if (!_side_jump) {
	if (hmove != 0) { xspd = approach(xspd, max_xspd * hmove, x_accel); } 
	else { xspd = approach(xspd, 0, x_decel); }
}

if (_jump) {
	yspd = jump_spd * -grav_dir;
	coyote_timer = 0;
	jump_hold_time = 0;
}

// hold longer = higher jump
var _jump_held = keyboard_check(btn_up) || (grav_dir == -1 && keyboard_check(btn_down));
if (-yspd * grav_dir > 0) {
	if (_jump_held && jump_hold_time < jump_hold_max) {
		jump_hold_time++;
	} else {
		yspd += grav * grav_dir * 1;
	}
}

// Press the switch key nearby to flip both players' gravity.
var _switch = instance_place(x, y, obj_gravity_switch);
if (_switch != noone
&& keyboard_check_pressed(btn_switch)
&& _switch.cooldown <= 0) {
	_switch.cooldown = 30;
	with (obj_actor) {
		grav_dir *= -1;
		yspd = 0;
		y_remain = 0;
	}
}

// connected, treat players as magnets
var _connected = place_meeting(x, y+1, obj_actor) || place_meeting(x, y-1, obj_actor); 
var _other = instance_find(obj_actor, 0);
if (_other == id) _other = instance_find(obj_actor, 1);

if (!connected && _connected) {
	spawn_particles(x, y, 10);
}

if (connected && _other != noone) {
	var _dist = _other.x - x;

	if (abs(_dist) > 1) {
		var _sign = sign(_dist);
		var _pull = clamp(abs(_dist), 0.5, 2);
		var _moved = 0;

		while (_moved < _pull) {
			if (place_meeting(x + _sign, y, obj_collidable)) break;
			x += _sign;
			_moved += 1;
		}
	}
	else if (!place_meeting(_other.x, y, obj_collidable)) {
		x = _other.x;
	}
}

connected = _connected;


if (_connected && _other != noone) {
	var _lead = (abs(xspd) > abs(_other.xspd)) || (abs(xspd) == abs(_other.xspd) && id < _other.id);
	if (_lead) {
		if (xspd != 0) {
			with (_other) {
				if (!place_meeting(x + other.xspd, y, obj_collidable)) {
					x += other.xspd;
				}
			}
		}
	} else { xspd = 0; }
}

yspd += grav * grav_dir;
yspd = clamp(yspd, -max_yspd, max_yspd);

// clean up and polish later
coins_collected = clamp(coins_collected, 0, max_coins);
max_xspd = base_xspd * (1 + coin_speed_bonus * coins_collected);
max_yspd = base_yspd;
jump_spd = base_jump_spd + coin_jump_bonus * coins_collected;
grav = base_grav + coin_grav_bonus * coins_collected;
jump_hold_max = max(1, ceil(jump_spd / grav));

unstick();
move_collide();
keep_players_in_shared_view();
