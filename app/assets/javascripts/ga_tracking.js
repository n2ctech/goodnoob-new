
function send_track_signup(){

	ga('send', 'event', 'signup', 'click' );
}

function send_track_btnRegister_signup(){

	ga('send', 'event', 'signup_complete', 'click' );
}

function send_track_upload(){

	ga('send', 'event', 'upload', 'click' );
}

function send_track_upload_complete(){

	ga('send', 'event', 'upload_complete', 'click' );
}

function send_track_buy(){

	ga('send', 'event', 'visitor_buy', 'click' );
}

function send_track_buy_number(){

	ga('send', 'event', 'visitor_buy_number', 'click' );
}

function send_track_review(){

	ga('send', 'event', 'visitor_review', 'click' );
}
