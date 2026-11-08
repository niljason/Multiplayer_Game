// Keep the persistent manager from being duplicated when a new run starts.
if (instance_number(object_index) > 1) {
	instance_destroy();
	exit;
}

get_ui_font();
