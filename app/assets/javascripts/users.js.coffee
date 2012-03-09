# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
= require jquery

goLite(FRM,BTN) -> window.document.forms[FRM].elements[BTN].style.backgroundColor = "#ffcc33", 
   window.document.forms[FRM].elements[BTN].style.borderStyle = "double", window.document.forms[FRM].elements[BTN].style.borderColor = "#66FF33"

function goDim(FRM,BTN)
{
   window.document.forms[FRM].elements[BTN].style.backgroundColor = "";
   window.document.forms[FRM].elements[BTN].style.borderStyle = "none";
   window.document.forms[FRM].elements[BTN].style.borderColor = "";
}

</script>
