$(function () {
	console.log("Cooking init....");
});

function handleCooking() {
	var knapp = $('.switch-label')[0].id;
	//console.log("knapp", knapp);

	if(knapp == "off"){
		$('.switch-label')[0].id = "on";

		console.log("turn on!");

		return $.ajax({
			type: "GET",
			crossDomain: true,
			url: "http://10.0.0.172/?pin=ON0",
			//data: "effect",
			dataType: "json",
			success : function(data){
				console.log("done: " , data);
			}
		});

	}

	if(knapp == "on"){
		$('.switch-label')[0].id = "off";
		console.log("turn off!");

		return $.ajax({
			type: "GET",
			crossDomain: true,
			url: "http://10.0.0.172/?pin=OFF0",
			//data: "effect",
			dataType: "json",
			success : function(data){
				console.log("done: " , data);
			}
		});

	}

	
}