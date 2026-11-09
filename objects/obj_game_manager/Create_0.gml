// keep the persistent manager from being duplicated when a new run starts
if (instance_number(object_index) > 1) {
	instance_destroy();
	exit;
}

start_new_run = function() {
	global.deaths = 0;
	global.timer = 0;
};

global.juice_transition_phase = 0;
global.juice_transition_frame = 0;
global.juice_transition_duration = 20;
global.ui_font = font_add("PixelifySans[wght].ttf", 24, false, false, 32, 127);

start_new_run();
