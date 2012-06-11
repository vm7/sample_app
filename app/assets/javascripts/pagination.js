//$(function(){
	
  //alert("loaded");
//});


$(function() {
  $(".pagination a").live("click", function() {
    $(".pagination").html("Page is loading...");
    $.getScript(this.href);
    return false;
  });
});
