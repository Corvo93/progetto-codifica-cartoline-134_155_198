$(function() {

    // Rendo invisibili tutti i div contenenti immagini + info e poi rendo visibile solo quello selezionato, che deduco dall'id del pulsante.
    $(".view").on('click', function() {
        $(".c_holder").removeClass("visible");
        $("#c" + this.id).addClass("visible");
		$(".view").removeClass ("active");
        $(this).addClass("active");
        console.log("#r_c" + this.id + "_f");
        $("#r_c" + this.id + "_f").prop("checked", true).change();
    });
	
	// Rendo invisibile sia il fronte che il retro e rendo visibile la parte interessata a seconda dell'input radio selezionato
	$("input[type=radio]").on('change', function() {
        let this_name = $(this).attr('name').split("_");
		//console.log(this_name[1]);
        $("#F" + this_name[1]).removeClass('visible');
        $("#R" + this_name[1]).removeClass('visible');
		//$(".desc_fronte").removeClass('visible');
        $(".text_retro").removeClass('visible');
		let check = $(this).attr('class');
		//console.log(check);
		if (check == "radio_fronte") {
			$("#F" + this_name[1]).addClass('visible');
			$(".img_c").attr("style", "width: 22em");
			$(".text_fronte").addClass('visible');
			$(".text_retro").removeClass('visible');
		}
		if (check == "radio_retro") {
			$("#R" + this_name[1]).addClass('visible');
			$(".img_c").attr("style", "width: 30em");
			$(".text_retro").addClass('visible');
			$(".text_fronte").removeClass('visible');
		}
		});
});





















