function init_movement(){
	xspd = 0;
	yspd = 0;
	
	x_remain = 0;
	y_remain = 0;
}

function reset_actor_to_spawn() {
	x = x_start;
	y = y_start;
	grav_dir = spawn_grav_dir;
	attached_steel = noone;
	attached_side = 0;
	attached_xspd = 0;
	attached_offset_x = 0;
	attached_offset_y = 0;
	xspd = 0;
	yspd = 0;
	x_remain = 0;
	y_remain = 0;
}


function move_collide(){
	
	// this slightly more advanced version of our move_collide function 
	// accounts for speeds that are not integers. The player can't move 
	// .5 pixels, but if our speed is 1.5, we can average it out by moving
	// 1 frame on frame 1, and 2 frames on frame 2, and then repeating.
	
	// first, apply any leftover movement that didn't get applied on previous frames (saved below).
	var xspd_total = xspd + x_remain;
	var yspd_total = yspd + y_remain;
	
	// then store the rounded, integer representation of our movement,
	var xspd_round = floor(abs(xspd_total)) * sign(xspd_total);
	var yspd_round = floor(abs(yspd_total)) * sign (yspd_total);
	
	// and save any leftover movement that didn't get applied for next frame.
	x_remain = xspd_total % 1;
	y_remain = yspd_total % 1;
	

	// then we just do our movement from before, using the rounded version of our speed
	for (var _x = 0; _x < abs(xspd_round); _x+=1){
		if (!place_meeting(x + sign(xspd), y, obj_collidable)){
			x += sign(xspd);
		} else {
			hitThing = instance_place(x+sign(xspd),y,obj_collidable);
			hitThing.hit = true;
			hit = true;
			xspd = 0;	
		}
	}
	

	for (var _y = 0; _y < abs(yspd_round); _y++){
		if (!place_meeting(x, y + sign(yspd), obj_collidable)){
			y += sign(yspd);
		} else {
			var _impact_dir = sign(yspd);
			hitThing = instance_place(x, y + _impact_dir, obj_collidable);
			hitThing.hit = true;
			hit = true;

			if ((hitThing.object_index == obj_steel || hitThing.object_index == obj_moving_steel) && !place_meeting(x, y, hitThing)) {
				attached_steel = hitThing;
				attached_side = _impact_dir;
				attached_xspd = 0;
				attached_offset_x = x - round(hitThing.x);
				attached_offset_y = y - round(hitThing.y);
				xspd = 0;
				x_remain = 0;
			}

			yspd = 0;
		}	
	}
	if (xspd == 0) x_remain = 0;
	if (yspd == 0) y_remain = 0;
}

function touching_ground(_amt) {
	var _floor_below = place_meeting(x, y+_amt, obj_collidable);
	return _floor_below;
}

// true if (_x,_y) overlaps any collidable other than _ignore
function blocked_ignoring(_x, _y, _ignore) {
	var _list = ds_list_create();
	var _n = instance_place_list(_x, _y, obj_collidable, _list, false);
	var _blocked = false;
	for (var i = 0; i < _n; i++) {
		if (_list[| i] != _ignore) { _blocked = true; break; }
	}
	ds_list_destroy(_list);
	return _blocked;
}

function unstick() {
	if (!place_meeting(x, y, obj_collidable)) return;
	// 4 cardinal directions
	var _dx = [0, 1, -1, 0];
	var _dy = [-1, 0, 0, 1];
	// 16 pixels in each direction
	for (var _r = 1; _r <= 16; _r++) {
		for (var _i = 0; _i < 4; _i++) {
			var _nx = x + _dx[_i] * _r;
			var _ny = y + _dy[_i] * _r;
			if (!place_meeting(_nx, _ny, obj_collidable)) {
				x = _nx; y = _ny;
				x_remain = 0; y_remain = 0;
				return;
			}
		}
	}
}

// A player cannot move far enough away to place the other player beyond one
// camera-width. This makes the player moving away from their partner stop.
function keep_players_in_shared_view() {
	if (instance_number(obj_actor) != 2 || !instance_exists(obj_cam_ctrl)) return;

	var _p1 = instance_find(obj_actor, 0);
	var _p2 = instance_find(obj_actor, 1);
	var _left = (_p1.bbox_left <= _p2.bbox_left) ? _p1 : _p2;
	var _right = (_left == _p1) ? _p2 : _p1;
	var _overflow = _right.bbox_right - _left.bbox_left - camera_get_view_width(global.cam);

	if (_overflow <= 0) return;

	if (id == _right) {
		x -= _overflow;
	} else if (id == _left) {
		x += _overflow;
	}
	xspd = 0;
	x_remain = 0;
}
