// force app to expand to full height of screen

$(document).ready(function(){ 
	if (typeof(PhoneGap) != 'undefined') {
			$('body > *').css({minHeight: '460px !important'});
	}
}