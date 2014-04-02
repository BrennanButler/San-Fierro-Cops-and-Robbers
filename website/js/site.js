$(document).ready(function() {
	
	var popupActive = false;
	var thebody = document.body.innerHTML;
	$("a[href=#popup]").click(function(event) {
		console.log("clicked");

		if(!popupActive)
		{
			console.log("not active");
			document.body.innerHTML = "<div class=\"black-screen\"></div>" + thebody;
			var content = $($(event.target).attr("data-id"));
			$(content).animate({top: "40px"}, 300);
			popupActive = true;
			event.preventDefault();
		} 
		else 
		{
			console.log("active");
			var content = event.target.attr("data-id");
			$(content).animate({top: "-=400px"}, 300);
			document.body.innerHTML = thebody;
			popupActive = false;
			event.preventDefault();
		}

	});

});