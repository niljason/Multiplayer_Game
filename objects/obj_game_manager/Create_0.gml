// keep the persistent manager from being duplicated when a new run starts
if (instance_number(object_index) > 1) {
	instance_destroy();
	exit;
}

global.deaths = 0;
global.timer = 0;
global.coins_ready = false;
global.p1_coins = 0;
global.p1_total = 0;
global.p2_coins = 0;
global.p2_total = 0;

start_new_run = function() {
	global.deaths = 0;
	global.timer = 0;
	reset_coins();
};

global.juice_transition_phase = 0;
global.juice_transition_frame = 0;
global.juice_transition_duration = 20;
global.ui_font = font_add("PixelifySans[wght].ttf", 24, false, false, 32, 127);
if (global.ui_font == -1) global.ui_font = fnt_grav_24;
