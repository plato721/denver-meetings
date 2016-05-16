
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
