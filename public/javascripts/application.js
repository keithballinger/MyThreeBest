// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults
$(document).ready(function() {
    $("button").button();
  });    
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

function reloadFriends() {
    $.get(window.reloadPath);
}

