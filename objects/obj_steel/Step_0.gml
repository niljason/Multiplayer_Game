//// Turn around at each end of the travel range.
//if (move_dir > 0 && x + move_speed >= start_x + move_range) {
//    move_dir = -1;
//} else if (move_dir < 0 && x - move_speed <= start_x) {
//    move_dir = 1;
//}

//move_delta_x = move_speed * move_dir;
//x += move_delta_x;

//// Carry only players latched to this steel platform.
//with (obj_actor) {
//    if (attached_steel == other.id) {
//        x = other.x + attached_offset_x;
//        y = other.y + attached_offset_y;
//    }
//}
