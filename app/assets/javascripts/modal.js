// Get the modal
var friend_modal = document.getElementById('myModal');
var thanks_modal = document.getElementById('thanks_modal');

// Get the button that opens the modal
var friend_button = document.getElementById("request");
var thanks_button = document.getElementById("tick");

// Get the <span> element that closes the modal
var span = document.getElementsByClassName("close")[1];

// When the user clicks on the button, open the modal
friend_button.onclick = function() {
  friend_modal.style.display = "block";
}

thanks_button.onclick = function() {
  thanks_modal.style.display = "block";
}

// When the user clicks on <span> (x), close the modal
// span.onclick = function() {
//   modal.style.display = "none";
// }

// When the user clicks anywhere outside of the modal, close it
// $(window.modal).onclick = function(event) {
//   if (event.target == modal) {
//     modal.style.display = "none";
//   }
// }

$('#close-modal').click(function(){
  friend_modal.style.display = "none";
});

$('#tick').click(function(){
  friend_modal.style.display = "none";
});

$('#cancel').click(function(){
  // thanks_modal.style.display = "none";
  window.location.reload();
});
