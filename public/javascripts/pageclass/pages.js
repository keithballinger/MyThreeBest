function getFriends(page){
    if(page == null){
        page = 1;
    }
    $.getJSON('/users?page='+page, function(response) {
        if( response.job_status == "completed" || response.count == 20 ) {
            loadFriends(response);
            if( response.job_status == "completed") {
                window.clearInterval(window.getFriendsInterval);
            }
        }
    });
}

function loadFriends(response){
    var friendsViewModel = {
        left_row: ko.observableArray(response.left_row),
        right_row: ko.observableArray(response.right_row)
    };
    ko.applyBindings(friendsViewModel);
    $('#loading').hide();
    ajaxPagination(response.count, response.page);
}

function ajaxPagination(count, page) {
    console.log("Count: "+count);
    console.log("Page: "+page);
    $("#pagination").pagination(count, {
        items_per_page: 20,
        current: page,
        callback: ajaxPaginationClick
    });
}

function ajaxPaginationClick(new_page_index, pagination_container) {
    $('#loading').show();
    getFriends(new_page_index);
    window.getFriendsInterval = window.setInterval(function () { getFriends(new_page_index); }, 3000);
}

function ajaxInvite(){
    $("a[href*='/invite']").live('click', function(evt) {
        evt.preventDefault();
        $("#inviteDialog").dialog("open");
        $("#inviteIframe").attr("src",$(this).attr("href"));
    });
    $("#inviteDialog").dialog({
        autoOpen: false,
        modal: true,
        height: 500,
        width: 500
    });
}

function inviteAll(){
    //TODO - prompt user for text to post to wall
    $.getJSON('/invite/all', function(response) {
        //todo: give the user better feedback, but for now, just alert
        alert('Invite posted to your wall');
    });
}

