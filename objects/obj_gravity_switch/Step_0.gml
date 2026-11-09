// Reduce the cooldown each frame.
if (cooldown > 0) {
	cooldown -= 1;
	if (cooldown == 0) image_index = 0;
}
