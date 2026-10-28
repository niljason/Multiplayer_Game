var _yoff = (grav_dir == -1) ? -sprite_get_height(sprite_index) : 0;
draw_sprite_ext(sprite_index, image_index, x, y + _yoff, 1, grav_dir, 0, c_white, 1);