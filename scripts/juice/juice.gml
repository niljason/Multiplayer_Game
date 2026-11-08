function spawn_particles(_x, _y, _num, _type=obj_particle) {
	for (var i = 0; i < _num; i++) {
		instance_create_depth(_x, _y, 0, _type);
	}
}
