
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

  $(".meeting-search-hot-button").on("click", function(){
    if (navigator.geolocation) {
      navigator.geolocation.getCurrentPosition(function(position) {
      var pos = {
        lat: position.coords.latitude,
        lng: position.coords.longitude
      };
      window.location = "/mobile/search/create?lat=" +
        pos["lat"] + "&lng=" + pos["lng"] + "&here_and_now=true";
    });
    } else {
      $(this).html("Geolocation unavailable")
    // Browser doesn't support Geolocation
     }
  });

  $(".here-box").on("click", function(){

    // $(".meeting-search-button").addClass('hidden');
    $('[type="submit"]').button('disable'); 

    if (navigator.geolocation) {
      navigator.geolocation.getCurrentPosition(function(position) {
      var pos = {
        lat: position.coords.latitude,
        lng: position.coords.longitude
      };
      $(".main-lat").val(pos["lat"]);
      $(".main-lng").val(pos["lng"]);
      console.log("lat is: " + pos["lat"] + " lng is: " + pos["lng"]);
    $('[type="submit"]').button('enable'); 

    });

    } else {
    $('[type="submit"]').button('enable'); 

    }

});

}

$(document).ready(main);