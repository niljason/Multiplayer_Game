// Menu rooms have no players; retain the last camera position until gameplay resumes.
if (!instance_exists(obj_player_1) || !instance_exists(obj_player_2)) exit;

global.cam = view_camera[0];

zoom_level = lerp(zoom_level, target_zoom, 0.05);

var _dim_x = cam_width * zoom_level;
var _dim_y = cam_height * zoom_level;
camera_set_view_size(global.cam, _dim_x, _dim_y);

player_diff_x = (obj_player_1.x - obj_player_2.x) / 2 + obj_player_2.x;
player_diff_y = (obj_player_1.y - obj_player_2.y) / 2 + obj_player_2.y;

var _target_x = player_diff_x - (_dim_x / 2);
var _target_y = player_diff_y - (_dim_y / 2);

_target_x = clamp(_target_x, 0, room_width - _dim_x);
_target_y = clamp(_target_y, 0, room_height - _dim_y);

// Keep the camera wide enough to contain both players. If the left player is
// blocked at the view's left edge, this prevents the view panning right.
var _min_cam_x = max(0, max(obj_player_1.bbox_right, obj_player_2.bbox_right) - _dim_x);
var _max_cam_x = min(room_width - _dim_x, min(obj_player_1.bbox_left, obj_player_2.bbox_left));
if (_min_cam_x <= _max_cam_x) {
	_target_x = clamp(_target_x, _min_cam_x, _max_cam_x);
}

cam_x = lerp(cam_x, _target_x, 0.1);
cam_y = lerp(cam_y, _target_y, 0.1);

cam_x = clamp(cam_x, 0, room_width - _dim_x);
cam_y = clamp(cam_y, 0, room_height - _dim_y);

// apply position
camera_set_view_pos(global.cam, cam_x, cam_y);
