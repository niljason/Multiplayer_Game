var _kr = keyboard_check(btn_right);
var _kl = keyboard_check(btn_left);
var _ku = keyboard_check_pressed(btn_up); // change to press so need keyboard input again
var _kd = keyboard_check_pressed(btn_down);

// horizontal movement
var hmove = _kr - _kl;

// is on the ground?
var grounded = touching_ground(grav_dir);
if (grounded) { coyote_timer = coyote_frames; }
else { coyote_timer = max(coyote_timer-1, 0); }
var _jump = (coyote_timer > 0) && (_ku || (_kd && grav_dir == -1));

if (hmove != 0) {
    xspd = approach(xspd, max_xspd * hmove, x_accel);
} else {
    xspd = approach(xspd, 0, x_decel);
}

if (_jump) {
	yspd = jump_spd * -grav_dir;
	coyote_timer = 0;
}
// not held dampen jump
var _jump_held = keyboard_check(btn_up) || (grav_dir == -1 && keyboard_check(btn_down));
if (!_jump_held && -yspd * grav_dir > 0) {
    yspd += grav * grav_dir * 2;
}

// Press the switch key nearby to flip both players' gravity.
var _switch = instance_nearest(x, y, obj_gravity_switch);
if (_switch != noone
&& place_meeting(x, y, _switch)
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
if (_other == id) _other = instance_find(obj_actor, 1); // get other player if this player

if (connected) {
    var _dist = _other.x - x;

    if (abs(_dist) > 1) {
        var _sign = sign(_dist);
        var _pull = clamp(abs(_dist), 0.5, 2);
        var _moved = 0;

        while (_moved < _pull) {
            if (place_meeting(x + _sign, y, obj_wall)) break;
            x += _sign;
            _moved += 1;
        }
    }
	else if (!place_meeting(_other.x, y, obj_wall)) {
	    x = _other.x;
	}
}

connected = _connected;

if (_connected && _other != noone) {
    var _lead = (abs(xspd) > abs(_other.xspd)) || (abs(xspd) == abs(_other.xspd) && id < _other.id);
    if (_lead) {
        if (xspd != 0) {
            with (_other) {
                if (!place_meeting(x + other.xspd, y, obj_wall)) {
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

move_collide();