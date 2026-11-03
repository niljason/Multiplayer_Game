var _just_detached = false;

// Stay fixed to steel until the jump button releases the magnet.
if (attached_steel != noone) {
    if (!instance_exists(attached_steel)) {
        attached_steel = noone;
        attached_side = 0;
    } else if (keyboard_check_pressed(btn_up) || (grav_dir == -1 && keyboard_check_pressed(btn_down))) {
        yspd = -attached_side * jump_spd;
        attached_steel = noone;
        attached_side = 0;
        x_remain = 0;
        y_remain = 0;
        _just_detached = true;
    } else {
        x = attached_steel.x + attached_offset_x;
        y = attached_steel.y + attached_offset_y;
        xspd = 0;
        yspd = 0;
        x_remain = 0;
        y_remain = 0;
        exit;
    }
}

var _kr = keyboard_check(btn_right);
var _kl = keyboard_check(btn_left);
var _ku = keyboard_check_pressed(btn_up); // change to press so need keyboard input again
var _kd = keyboard_check_pressed(btn_down);
var hmove = _kr - _kl;

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
var _jump = !_just_detached && !_side_jump && (grounded && _ku || grounded && _kd && grav_dir == -1);

if (!_side_jump) {
    if (hmove != 0) {
        xspd = approach(xspd, max_xspd * hmove, x_accel);
    } else {
        xspd = approach(xspd, 0, x_decel);
    }
}

if (_jump) {
	yspd = jump_spd * -grav_dir;
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
if (_other == id) _other = instance_find(obj_actor, 1);

if (!connected && _connected) {
	var _midX = (_other.x + x) / 2;
	x = _midX;
	_other.x = _midX;
}
connected = _connected;

if (_connected && xspd != 0 && _other != noone) {
    with (_other) {
        if (!place_meeting(x + other.xspd, y, obj_wall)) {
            x += other.xspd;
        }
    }
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