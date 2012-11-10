$(document).ready(function() {        
  $('.pSortable').sortable({
  	placeholder: "ui-state-highlight",
    handle: '.phandle',
		items: 'p',
		opacity: 0.6,
    update: function(event, ui) {
        var paragraph_order = $(this).sortable('toArray').toString();
      //this will give you the new order list from here you can fire ajax call for updating the order
    }
  });
  $('.sSortable').sortable({
  	placeholder: "ui-state-highlight",
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
   placeholder: "ui-state-highlight",
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
