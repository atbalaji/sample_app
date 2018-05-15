//= require jquery
//= require bootstrap
//= require rails-ujs
//= require turbolinks
//= require_tree .

$(document).ready(function(){
  $('[data-toggle="tooltip"]').tooltip(); 

});

function comment() {
    var x = document.getElementById("comments");
    if (x.style.display === "none") {
        x.style.display = "block";
    } else {
        x.style.display = "none";
    }
}
