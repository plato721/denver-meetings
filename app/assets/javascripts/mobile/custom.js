
var main = function(){

  $(".city-text").on("click", function() {
    if ($(this).val() == "(Optional search text)"){
        $(this).val("")
        $(this).removeClass("city-text-default")
      }
  });

  $(".group-text").on("click", function() {
    if ($(this).val() == "(Optional search text)"){
        $(this).val("")
        $(this).removeClass("group-text-default")
      }
  });





}

$(document).ready(main);