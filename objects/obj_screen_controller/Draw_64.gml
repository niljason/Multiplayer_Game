var _view_w = room_width;
var _view_h = room_height;
var _is_start = room == rm_start;

//draw_set_font(fnt_grav_24);
global.ui_font = font_add("PixelifySans[wght].ttf", 24, false, false, 32, 127);
draw_set_font(get_ui_font());
draw_set_color(c_white);
draw_set_halign(fa_center);
draw_set_valign(fa_middle);

if (_is_start) {
	draw_text(_view_w * 0.5, _view_h * 0.35, "MULTIPLAYER PROTOTYPE");
	draw_text(_view_w * 0.5, _view_h * 0.50, "P1: ARROW KEYS + ENTER");
	draw_text(_view_w * 0.5, _view_h * 0.57, "P2: WASD + F");
	draw_text(_view_w * 0.5, _view_h * 0.70, "PRESS ENTER OR SPACE TO START");
} else {
	var _deaths = global.deaths;
	var _timer = global.timer;

	draw_text(_view_w * 0.5, _view_h * 0.40, "LEVELS COMPLETE");
	draw_text(_view_w * 0.5, _view_h * 0.50, "DEATHS: " + string(_deaths));
	draw_text(_view_w * 0.5, _view_h * 0.57, "TIME: " + format_timer_ticks(_timer));
	draw_text(_view_w * 0.5, _view_h * 0.70, "PRESS ENTER OR SPACE TO RETURN TO START");
}

draw_set_halign(fa_left);
draw_set_valign(fa_top);
