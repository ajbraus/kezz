$(document).ready(function() {        
  $('.pSortable').sortable({
    start: function( event, ui ) {
      $('body').animate({ zoom: 0.6 }, 300)
      },
    stop: function( event, ui ) {
      $('body').animate({ zoom: 1 }, 300)
      },
  	placeholder: "pbackdrop",
    handle: '.phandle',
		items: 'p',
		opacity: 0.6,
    update: function(event, ui) {
        var paragraph_order = $(this).sortable('toArray').toString();
      //this will give you the new order list from here you can fire ajax call for updating the order
    }
  });
  $('.sSortable').sortable({
  	placeholder: "sbackdrop",
    handle: '.shandle',
  	revert: true,
  	opacity: 0.6,
 	  zIndex: 5,
    update: function(event, ui) {
        var sentence_order = $(this).sortable('toArray').toString();
      //this will give you the new order list from here you can fire ajax call for updating the order
    }
  });
  $('.phSortable').sortable({
   placeholder: "phbackdrop",
   handle: '.phhandle',
 	 opacity: 0.6,
 	 revert: true,
 	 zIndex: 5,
    update: function(event, ui) {
        var phrase_order = $(this).sortable('toArray').toString();
      //this will give you the new order list from here you can fire ajax call for updating the order
    }
  });
});
