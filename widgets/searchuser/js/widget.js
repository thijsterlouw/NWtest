function loadPage(page,query) {
    $.get('http://127.0.0.1/widget/searchuser/?page='+page+'&query='+query,
    function (htmlResult) {
		$("#w-searchuser").replaceWith(htmlResult); 
		$('.noJs').hide();	
    }    
    );
	window.location.hash = page;
    return false;
}

function search(query) {
	$.post('http://127.0.0.1/widget/searchuser/?page=0&query='+query, function(data) {
		$('#w-searchuser').replaceWith(data);
	});
}

$(document).ready(function() {
#	$('.noJs').hide();
#	var hash = window.location.hash;
#	hash = hash.replace('#','');
#	console.log(hash);
#	loadPage(hash);
});
