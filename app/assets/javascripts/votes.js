function loadPage() {
    try {
        if(fantasticFlow.getNumberOfItems() - fantasticFlow.getActiveItem().index < 10) {
            getPhotos(photosPage+1);
        }
    } catch(err) { }
}

function getPhotos(page) {
    $.getJSON(window.location.pathname+"?page="+page, function(response) {
        loadPhotos(response);
    });
}

function loadPhotos(response) {
    var flowChanged = false;
    $.each(response, function(index, object) {
        var photo = object.photo;
        if($("#"+photo.id).length == 0) {
            var img = document.createElement('img')
            $(img).attr({src: photo.preview_url, id: photo.id, title: photo.title});
            $(img).addClass("item");
            fantasticFlow.addItem(img, 'last');
            flowChanged = true;
        }
    });
    if(flowChanged) {
      photosPage = photosPage + 1;
    }
}

function ajaxPagination() {
    $(".pagination a").click(function() {
        $.ajax({
          type: "GET",
          url: $(this).attr("href"),
          dataType: "script"
        });
        window.reloadPath = $(this).attr("href");
        return false;
    });
}
