
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

// adapted from https://gist.github.com/kamranzafar/3136584
function toast(msg){
  $("<div class='ui-loader ui-overlay-shadow ui-body-e ui-corner-all'><h3>"+msg+"</h3></div>")
  .css({ display: "block",
    opacity: 0.70,
    position: "fixed",
    padding: "7px",
    background: "red",
    "text-align": "center",
    width: "270px",
    left: ($(window).width() - 284)/2,
    top: 14 })
  .appendTo( $.mobile.pageContainer ).delay( 1500 )
  .fadeOut( 3000, function(){
    $(this).remove();
  });
}
