// start and end room
if (!instance_exists(obj_player_1) || !instance_exists(obj_player_2)) exit;

var _camera_controller = instance_find(obj_cam_ctrl, 0);
var _view_w = _camera_controller.cam_width;
var _view_h = _camera_controller.cam_height;
var _margin = 16;
var _player_hud_width = 280;
var _player_hud_height = 88;
var _hud_y = _view_h - _player_hud_height - _margin;

if (obj_player_2.hud_idle_timer >= obj_player_2.hud_idle_delay) {
	draw_player_hud(obj_player_2, spr_collectible_2, "P2", global.p2_coins, global.p2_total, _margin, _hud_y);
}

if (obj_player_1.hud_idle_timer >= obj_player_1.hud_idle_delay) {
	draw_player_hud(obj_player_1, spr_collectible_1, "P1", global.p1_coins, global.p1_total, _view_w - _player_hud_width - _margin, _hud_y);
}

draw_set_halign(fa_left);
draw_set_valign(fa_top);
draw_set_alpha(1);

juice_draw_room_transition();
