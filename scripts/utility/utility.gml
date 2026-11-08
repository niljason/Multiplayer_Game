function print(_string){
	show_debug_message(_string);	
}

function approach(_start, _end, _val){
	if (_start > _end){
		return max(_start - _val, _end);	
	} else {
		return min(_start + _val, _end);	
	}
}

function get_ui_font() {
	if (!variable_global_exists("ui_font")) {
		global.ui_font = font_add("PixelifySans[wght].ttf", 24, false, false, 32, 127);
	}

	return (global.ui_font == -1) ? fnt_grav_24 : global.ui_font;
}

function draw_player_hud(_player, _coin_sprite, _label, _x, _y) {
	var _panel_w = 220;
	var _panel_h = 88;
	var _gravity = (_player.grav_dir == 1) ? "DOWN" : "UP";

	draw_set_alpha(0.55);
	draw_set_color(c_black);
	draw_rectangle(_x, _y, _x + _panel_w, _y + _panel_h, false);

	draw_set_alpha(1);
	draw_set_color(c_white);
	draw_set_font(get_ui_font());
	draw_set_halign(fa_left);
	draw_set_valign(fa_top);
	draw_sprite(_coin_sprite, 0, _x + 28, _y + 28);
	draw_text(_x + 56, _y + 12, _label + ": " + string(_player.coins_collected));
	draw_text(_x + 16, _y + 52, "GRAVITY: " + _gravity);
}
