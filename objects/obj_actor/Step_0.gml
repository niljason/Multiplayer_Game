var _kr = keyboard_check(btn_right);
var _kl = keyboard_check(btn_left);
var _ku = keyboard_check(btn_up);
var _kd = keyboard_check(btn_down);

// horizontal movement
var hmove = _kr - _kl;

// is on the ground?
var grounded = touching_ground(grav_dir);

if (hmove != 0) {
    xspd = approach(xspd, max_xspd * hmove, x_accel);
} else {
    xspd = approach(xspd, 0, x_decel);
}

if (grounded && _ku) {
	yspd = jump_spd * -grav_dir;
}

// Press the switch key nearby to flip both players' gravity.
var _switch = instance_nearest(x, y, obj_gravity_switch);
if (_switch != noone
&& point_distance(x, y, _switch.x, _switch.y) <= 144
&& keyboard_check_pressed(btn_switch)
&& _switch.cooldown <= 0) {
    _switch.cooldown = 30;
    with (obj_actor) {
        grav_dir *= -1;
        yspd = 0;
        y_remain = 0;
    }
}

yspd += grav * grav_dir;
yspd = clamp(yspd, -max_yspd, max_yspd);


move_collide();