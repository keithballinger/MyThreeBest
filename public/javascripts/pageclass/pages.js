$(document).ready(function() {
    getFriends();
});

function getFriends(){
    $.getJSON('http://localhost:3000/friends/list', function(response) {
        
        if( response.job_status == "completed" ){
            loadFriends(response.friends);
        }else{
            setInterval("getFriends()", 1000);
        }
        
    });
}

function loadFriends(friends){
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