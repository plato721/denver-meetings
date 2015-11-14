
var main = function(){

  $(".city-text").on("click", function() {
    if ($(this).val() == "(Optional search text)")
        $(this).val("")
  });

  $(".group-text").on("click", function() {
    if ($(this).val() == "(Optional search text)")
        $(this).val("")
  });





}

$(document).ready(main);