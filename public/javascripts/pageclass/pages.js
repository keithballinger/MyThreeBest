$(document).ready(function() {
    getFriends();
    window.getFriendsInterval = window.setInterval(getFriends, 1000);
    
    var friendsViewModel = {
        left_row: ko.observableArray([
            { vote_id: "1", name: "Keith Ballinger", profile_image_url: "http://profile.ak.fbcdn.net/hprofile-ak-snc4/173926_100002115969383_4889585_q.jpg" },
            { vote_id: "1", name: "Bob Kruger", profile_image_url: "http://profile.ak.fbcdn.net/hprofile-ak-snc4/173926_100002115969383_4889585_q.jpg" }
        ]),
        right_row: ko.observableArray([
            { vote_id: "1", name: "Amy Bond", profile_image_url: "http://profile.ak.fbcdn.net/hprofile-ak-snc4/173926_100002115969383_4889585_q.jpg" },
            { vote_id: "1", name: "James Smith", profile_image_url: "http://profile.ak.fbcdn.net/hprofile-ak-snc4/173926_100002115969383_4889585_q.jpg" }
        ])

    };

    ko.applyBindings(friendsViewModel);
    
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

