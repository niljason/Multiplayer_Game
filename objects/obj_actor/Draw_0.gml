var _yoff = (grav_dir == -1) ? -sprite_get_height(sprite_index) : 0;

if (invincibility_timer > 0) {
	var _shield_y = y - sprite_get_height(sprite_index) * 0.5;
	var _shield_radius = max(sprite_get_width(sprite_index), sprite_get_height(sprite_index)) * 0.75;

	draw_set_color(c_aqua);
	draw_set_alpha(0.16);
	draw_circle(x, _shield_y, _shield_radius, false);
	draw_set_alpha(0.70);
	draw_circle(x, _shield_y, _shield_radius, true);
}

draw_set_alpha(1);
draw_set_color(c_white);
draw_sprite_ext(sprite_index, image_index, x, y + _yoff, 1, grav_dir, 0, c_white, 1);
