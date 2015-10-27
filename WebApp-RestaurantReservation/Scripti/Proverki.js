var vrednostPraznoMesto = "";
var vrednostSamoBroevi = "";


$(document).ready(function() {


    //Kod za DatePicker
    $('[tip="Datum"]').datepicker({
        dayNamesMin: ['Нед', 'Пон', 'Втор', 'Сре', 'Чет', 'Пет', 'Саб'],
        monthNames: ['Јануари', 'Февруари', 'Март', 'Април', 'Мај', 'Јуни', 'Јули', 'Август', 'Септември', 'Октомври', 'Ноември', 'Декември'],
        monthNamesShort: ['Јан', 'Фев', 'Мар', 'Апр', 'Мај', 'Јун', 'Јул', 'Авг', 'Сеп', 'Окт', 'Ное', 'Дек'],
        currentText: "Денес",
        showOtherMonths: true,
        minDate: new Date(),
        firstDay: 1,
        nextText: "След",
        prevText: "ретх",
        dateFormat: "mm-dd-yy",
        constrainInput: true,
        onClose: function(dateText, inst) {
            if (dateText == "") {
            }
        },
        changeMonth: false,
        beforeShow: function(input) {
            setTimeout(function() {
                $('#ui-datepicker-div').css('font-size', '11px');
            })
        }
    });
    //----Kraj -- Kod za DatePicker
    //$('#ui-datepicker-div').mouseleave ja koristime za da go hide kalendarot od datepickerot
    $('#ui-datepicker-div').mouseleave(function() {
    });


});//Kraj na documentReady


function zabraniPraznoMesto(e, id) {
   
    var pom = vratiKodKeyEvent(e);
    if (pom != 32) {
        vrednostPraznoMesto = document.getElementById(id).value;
    }
    else {
        document.getElementById(id).value = vrednostPraznoMesto;
    }
}
function FokusirajElement(x) {
    if (document.getElementById) document.getElementById(x).focus();
}
function dozvoliSamoBroevi(tekst) {
    if (isNaN(tekst)) {
        return vrednostSamoBroevi;
    }
    else {
        vrednostSamoBroevi = tekst;
        return vrednostSamoBroevi;
    }

}
function zabraniRezervacii(e, id){
    zabraniPraznoMesto(e, id);
    $("#" +id).val(dozvoliSamoBroevi($("#" +id).val()));
}
function vratiKodKeyEvent(e) {
    if (e.type == "keydown" || e.type == "keyup" || e.type == "keypress") {
        var keyCode = e.charCode ? e.charCode : e.keyCode ? e.keyCode : 0;
        var kopceKod = parseInt(keyCode);
        return kopceKod;

    }
    alert("vratiKodKeyEvent KeyCode = null");
    return null;
}
function proveriBrowser() {
    var ie = jQuery.browser.msie;
    if (ie) {
        var ver = jQuery.browser.version;
        if (ver < 8) {
            $('body').append("<div id=\"ShadowBrowser\"></div>");
            $('#ShadowBrowser').css('background-color', '#E0E8E8');
            $('#ShadowBrowser').css({
                position: 'absolute',
                top: '0px',
                left: '0px',
                width: '100%',
                height: $(document).height(),
                opacity: '.25',
                filter: 'alpha(opacity = 90)'
            });

            $('#Info').css({
                position: 'fixed',
                top: '10%',
                left:'30%',
                width: '500px',
                height: '150px',
                margin: 'auto',
                border: '2px solid Green',
                color: 'Olive',
                padding: '3px'
            });
            $('#Info').css('font-size', '0.8em');
            $('#Info').css('font-family', 'Verdana');
            $('#Info').css('z-index', '100');
            $('#Info').css('background-color', '#FFFFFF');
            $('#Info').show();
            $("#Info").html("Веб сајтот е тестиран и оптимизиран за следниве прелистувачи: <ul><li>- IE 8.0</li><li>- Mozilla 3.0</li><li>- Google Chrome</li></ul> <br/><p style='font-family:Verdana; font-size: 1em;color:Maroon;'> <b>Верзијата на овој прелистувач не е подржана и некои од фукционалностите можат да не работат!</b></p><br /> <div id='Prodolzi' style='font-size:0.9em;color: Green; cursor:pointer; float:right;'></div>");
        }
    }
}


