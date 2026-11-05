// Draw the switch and keep its labels attached to the sprite.
draw_self();

draw_self();
if (first_switch && distance_to_object(obj_actor) <= 32) {
	draw_set_font(fnt_grav_24);
	var _sprite_top = y + (sprite_get_bbox_top(sprite_index) - sprite_get_yoffset(sprite_index)) * image_yscale;
	draw_set_color(c_white);
	draw_set_halign(fa_center);
	draw_set_valign(fa_middle);
	draw_text(x, _sprite_top - 92, "GRAVITY SWITCH");
	draw_text(x, _sprite_top - 48, "P1: ENTER  |  P2: F");
	draw_set_halign(fa_left);
	draw_set_valign(fa_top);
}