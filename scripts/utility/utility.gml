function print(_string){
	show_debug_message(_string);	
}

function approach(_start, _end, _val){
	if (_start > _end){
		return max(_start - _val, _end);	
	} else {
		return min(_start + _val, _end);	
	}
}