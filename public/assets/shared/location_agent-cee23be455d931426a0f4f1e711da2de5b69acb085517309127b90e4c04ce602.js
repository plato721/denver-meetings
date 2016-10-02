function checkLocation(cb){
  if( !isLocationSearch() ){ return cb(); }

  var searchFor = searchBox().val();
  cleanAndSearch(searchFor, cb);
}

function googleApiUrl(){
  return "https://maps.googleapis.com/maps/api/geocode/json";
}

// Todo: clean and search, not just search :-)
function cleanAndSearch(term, cb){
  $.ajax({
    url: googleApiUrl(),
    data: { address : term,
            key : googleMapsKey() },
    success: storeLocation
  })
}

function storeLocation(data){
  if( data.status === "OK" ){
    $('#lat').val(data.results[0].geometry.location.lat);
    $('#lng').val(data.results[0].geometry.location.lng);
  }
  submitForm();
}

function isLocationSearch(){
  return locationBox().is(':checked');
}

$(document).ready(function(){
  //console.log("location_agent loaded");
}());
