if (!instance_exists(obj_player_1) || !instance_exists(obj_player_2)) exit;

var _camera_controller = instance_find(obj_cam_ctrl, 0);
var _view_w = _camera_controller.cam_width;
var _view_h = _camera_controller.cam_height;
var _panel_w = 250;
var _panel_h = 88;
var _margin = 16;

var _p1_hud_x = _margin;
var _p1_hud_y = _view_h - _panel_h - _margin;
var _p2_hud_x = _view_w - _panel_w - _margin;
var _p2_hud_y = _view_h - _panel_h - _margin;

draw_player_hud(obj_player_2, spr_collectible_2, "P2", _p1_hud_x, _p1_hud_y);
draw_player_hud(obj_player_1, spr_collectible_1, "P1", _p2_hud_x, _p2_hud_y);

draw_set_halign(fa_left);
draw_set_valign(fa_top);
draw_set_alpha(1);

juice_draw_room_transition();
