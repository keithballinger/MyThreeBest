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

function loadFriends2(friends){
    var items = [];

    $.each(friends, function(key, val) {
        items.push('<li id="user' + key + '"><img src="' + val.user.profile_picture + '" />' + val.user.first_name + ' ' + val.user.last_name + '</li>');
    });

    $('<ul/>', {
        'class': 'my-new-list',
        html: items.join('')
    }).appendTo('#friends');

    $('#loading').hide();
}

function loadFriends(friends){
    $( "#friend_template" ).tmpl(friends).appendTo("#friends_list");
    $('#loading').hide();
}
