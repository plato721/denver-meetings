function endsInZip(){}
function checkLocation(cb){
  if( !isLocationSearch() ){ return cb(); }

  console.log("checking dis");
  return cb();
}

function isLocationSearch(){
  return locationBox().val() === "true";
}

$(document).ready(function(){
  console.log("got dem");
}());