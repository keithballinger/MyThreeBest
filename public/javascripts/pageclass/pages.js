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
    $( "#friend_template" ).tmpl(friends).appendTo("#friends_list");
    $('#loading').hide();
}

function inviteAll(){
    
    //TODO - prompt user for text to post to wall
    
    $.getJSON('http://localhost:3000/invite/all', function(response) {
        
        //todo: give the user better feedback, but for now, just alert
        alert('Invite posted to your wall');
        
    });
}