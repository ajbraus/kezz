$(document).ready(function() {        
  $('.pSortable').sortable({
  	handle: '.handle',
		items: 'p',
		opacity: 0.6,
    update: function(event, ui) {
        var paragraph_order = $(this).sortable('toArray').toString();W
      //this will give you the new order list from here you can fire ajax call for updating the order
    }
  });
  $('.sSortable').sortable({
  	handle: '.handle',
  	revert: true,
  	opacity: 0.6,
 	  zIndex: 5,
    update: function(event, ui) {
        var sentance_order = $(this).sortable('toArray').toString();
      //this will give you the new order list from here you can fire ajax call for updating the order
    }
  });
  $('.phSortable').sortable({
   handle: '.handle',
 	 opacity: 0.6,
 	 revert: true,
 	 zIndex: 5,
    update: function(event, ui) {
        var phrase_order = $(this).sortable('toArray').toString();
      //this will give you the new order list from here you can fire ajax call for updating the order
    }
  });
});
