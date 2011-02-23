$(document).ready(function() {
    $.getJSON('http://localhost:3000/friends/list', function(data) {
      var items = [];

      $.each(data.friends, function(key, val) {
        items.push('<li id="user' + key + '"><img src="' + val.user.profile_picture + '" />' + val.user.first_name + ' ' + val.user.last_name + '</li>');
      });

      $('<ul/>', {
        'class': 'my-new-list',
        html: items.join('')
      }).appendTo('#friends');
      
      $('#loading').hide();
      
    });
});