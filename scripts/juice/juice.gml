function spawn_particles(_x, _y, _num, _color, _speed, _lifetime) {
	for (var i = 0; i < _num; i++) {
		var _particle = instance_create_depth(_x, _y, 0, obj_particle);
		_particle.image_blend = _color;
		_particle.xspd = random_range(-_speed, _speed);
		_particle.yspd = random_range(-_speed, _speed);
		_particle.lifetime_max = _lifetime;
		_particle.lifetime = _lifetime;
	}
}

function juice_checkpoint_activated(_x, _y) {
	spawn_particles(_x, _y, 16, c_lime, 6, 24);
}

function juice_player_died(_x, _y) {
	spawn_particles(_x, _y, 24, c_red, 12, 22);
}

function juice_transition_active() {
	return global.juice_transition_phase != 0;
}

function juice_begin_next_room() {
	if (juice_transition_active()) return;

	global.juice_transition_phase = 1;
	global.juice_transition_frame = 0;
}

function juice_update_room_transition() {
	if (!juice_transition_active()) return;

	if (global.juice_transition_phase == 1) {
		global.juice_transition_frame++;
		if (global.juice_transition_frame >= global.juice_transition_duration) {
			global.juice_transition_phase = 2;
			global.juice_transition_frame = global.juice_transition_duration;
			room_goto_next();
		}
	} else {
		global.juice_transition_frame--;
		if (global.juice_transition_frame <= 0) {
			global.juice_transition_phase = 0;
		}
	}
}

function juice_draw_room_transition() {
	if (!juice_transition_active()) return;

	var _alpha = clamp(global.juice_transition_frame / global.juice_transition_duration, 0, 1);
	draw_set_color(c_black);
	draw_set_alpha(_alpha);
	draw_rectangle(0, 0, get_active_view_width(), get_active_view_height(), false);
	draw_set_color(c_white);
	draw_set_alpha(1);
}
