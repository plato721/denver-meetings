
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

  $(".meeting-search-hot-button-box").on("click", function(){
    if (navigator.geolocation) {
      navigator.geolocation.getCurrentPosition(function(position) {
      var pos = {
        lat: position.coords.latitude,
        lng: position.coords.longitude
      };
      console.log("lat is: " + pos["lat"] + " lng is: " + pos["lng"]);
    });
    } else {
    // Browser doesn't support Geolocation
     }
  });

  $(".here-box").on("click", function(){
    if (navigator.geolocation) {
      navigator.geolocation.getCurrentPosition(function(position) {
      var pos = {
        lat: position.coords.latitude,
        lng: position.coords.longitude
      };
      console.log("lat is: " + pos["lat"] + " lng is: " + pos["lng"]);
    });

    } else {
    // Browser doesn't support Geolocation
    }
});


}

$(document).ready(main);