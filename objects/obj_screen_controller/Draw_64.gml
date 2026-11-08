var _gui_w = display_get_gui_width();
var _gui_h = display_get_gui_height();
var _is_start = room == rm_start;

draw_set_font(fnt_grav_24);
draw_set_color(c_white);
draw_set_halign(fa_center);
draw_set_valign(fa_middle);

if (_is_start) {
	draw_text(_gui_w * 0.5, _gui_h * 0.35, "MULTIPLAYER PROTOTYPE");
	draw_text(_gui_w * 0.5, _gui_h * 0.50, "P1: ARROW KEYS + ENTER");
	draw_text(_gui_w * 0.5, _gui_h * 0.57, "P2: WASD + F");
	draw_text(_gui_w * 0.5, _gui_h * 0.70, "PRESS ENTER OR SPACE TO START");
} else {
	draw_text(_gui_w * 0.5, _gui_h * 0.40, "LEVELS COMPLETE");
	draw_text(_gui_w * 0.5, _gui_h * 0.58, "PRESS ENTER OR SPACE TO RETURN TO START");
}

draw_set_halign(fa_left);
draw_set_valign(fa_top);
