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
    $('[type="submit"]').button('disable'); //wait for lat and lng
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
  }); //here-box on click (proximity without here and now)
}

$(document).ready(main);

// white stripe on short searches fix
// Credit: ezanker http://stackoverflow.com/questions/21552308/
//   set-content-height-100-jquery-mobile/27617438#27617438
$(document).on( "pagecontainershow", function(){
    ScaleContentToDevice();
    
    $(window).on("resize orientationchange", function(){
        ScaleContentToDevice();
    })
});

function ScaleContentToDevice(){
    scroll(0, 0);
    var content = $.mobile.getScreenHeight()
      - $(".ui-header").outerHeight()
      - $(".ui-footer").outerHeight()
      - $(".ui-content").outerHeight()
      + $(".ui-content").height();
    $(".ui-content").height(content);
}
