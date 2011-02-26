$(document).ready(function() {
    getFriends();
    window.getFriendsInterval = window.setInterval(getFriends, 1000);
    
});

function getFriends(){
    $.getJSON('/friends/list', function(response) {
        if( response.job_status == "completed" ) {
            loadFriends(response);
            window.clearInterval(window.getFriendsInterval);
        }
    });
}



function loadFriends(response){
    //$( "#friend_template" ).tmpl(friends).appendTo("#friends_list");
    
    var friendsViewModel = {
        left_row: ko.observableArray(response.left_row),
        right_row: ko.observableArray(response.right_row)
    };

    ko.applyBindings(friendsViewModel);
    
    $('#loading').hide();
    
}


function inviteAll(){

    //TODO - prompt user for text to post to wall
    $.getJSON('/invite/all', function(response) {
        //todo: give the user better feedback, but for now, just alert
        alert('Invite posted to your wall');
    });
}

