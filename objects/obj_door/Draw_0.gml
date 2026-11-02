if (owner_obj = obj_player_1) {
	draw_sprite_ext(sprite_index, 
	image_index, x, y, 
	image_xscale, image_yscale, image_angle, 
	make_colour_rgb(0, 174, 240), image_alpha);
} else {
	draw_sprite_ext(sprite_index, 
	image_index, x, y, 
	image_xscale, image_yscale, image_angle, 
	make_colour_rgb(241, 110, 170), image_alpha);
}