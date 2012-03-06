function loadPage(url) {
    $.get('http://127.0.0.1/widget/searchuser/'+url,
    function (htmlResult) {
		$("#w-searchuser").replaceWith(htmlResult);	
		pimpJS();
		window.location.hash = url;
    }    
    );
    return false;
}


function pimpPager() {
	$("a.m-pager").attr({
	"onClick" : function (arr) {
                    return "loadPage(\"" + $(this).attr("href") + "\");";
                },
    "href" : "#"}
    );
};


function pimpSearchField() {
  $("#w-searchuser-searchform").submit(function(event) {

    /* stop form from submitting normally */
    event.preventDefault(); 
        
    /* get some values from elements on the page: */
    var $form = $( this ),
        queryval = $form.find( 'input[name="query"]' ).val(),
        url = 'http://127.0.0.1/widget/searchuser/?query='+queryval ;

    /* Send the data using post and put the results in a div */
    $.post( url, { query: queryval },
      function( data ) {
          $('#w-searchuser').replaceWith(data);
          pimpJS();
          window.location.hash = 'query='+queryval;
      }
    );
  });
};


/* pimp non-JS page with AJAX-style requests */
function pimpJS() {
    pimpPager();
    pimpSearchField();
}

/* pimp the page after a reload */
$(document).ready(function() {
	pimpJS();
});
