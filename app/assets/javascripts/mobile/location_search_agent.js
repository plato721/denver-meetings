



$(function(){
  var isLocationCheckbox = $('#is_location_search[type=checkbox]');

  isLocationCheckbox.change(function(){
    if(this.checked){
      console.log("unhiding radius menu");
    } else {
      console.log("hiding radius menu");
    }
  });


});