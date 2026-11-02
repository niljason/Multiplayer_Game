xspd = 0;
yspd = 0;

base_grav = 0.8;
base_xspd = 8;
base_yspd = 64;
base_jump_spd = 20;

x_accel = 0.4;
x_decel = 0.8;

grav = base_grav;
max_xspd = base_xspd;
max_yspd = base_yspd;
jump_spd = base_jump_spd;

// key presses, override in children
btn_left = 0;
btn_right = 0;
btn_up = 0;
btn_down = 0;
grav_dir = 0;

// positive feedback loop
coins_collected = 0;
max_coins = 10;

// Per-coin upgrade rates
coin_speed_bonus = 0.075; 
coin_jump_bonus  = 0.25;
coin_grav_bonus  = 0.01; 

// connected 
connected = false;

x_start = x;
y_start = y;

coyote_frames = 6;
coyote_timer = 0;

init_movement();