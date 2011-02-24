$(document).ready(function() {
    getFriends();
    window.getFriendsInterval = window.setInterval(getFriends, 1000);
});

function getFriends(){
    $.getJSON('/friends', function(response) {
        if( response.job_status == "completed" ) {
            loadFriends(response.friends);
            window.clearInterval(window.getFriendsInterval);
        }
    });
}



function loadFriends(friends){
    $( "#friend_template" ).tmpl(friends).appendTo("#friends_list");
    $('#loading').hide();
}


function inviteAll(){

    //TODO - prompt user for text to post to wall
    $.getJSON('/invite/all', function(response) {
        //todo: give the user better feedback, but for now, just alert
        alert('Invite posted to your wall');
    });
}

