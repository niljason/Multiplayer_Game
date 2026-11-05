x += xspd;
y += yspd;

lifetime--;


image_alpha = lifetime / lifetime_max;

if (lifetime <= 0) {
	instance_destroy();
}