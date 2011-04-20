function getPhotos(id){
    $.getJSON('/users/'+id+'/photos', function(response) {
        loadPhotos(response);
    });
}

function loadPhotos(response){
}
