var previousContainer = null
var selectedContainer = "#mainSettings"

var previousUI = getUI()
var isDragging = false
var notificationType = getNotification()

setData()

$.fn.extend({
    qcss: function(css) {
       return $(this).queue(function(next) {
          $(this).css(css);
          next();
       });
    }
 });

$("#UISelector").click(function(){
    var audio = document.getElementById("click");
    audio.volume = 0.2;
    audio.play();
    $(selectedContainer).slideUp(300)
    $("#uiSelectorSettings").delay(300).slideDown()
    $(".title-header").fadeOut("fast", function() {
        $(".title-header").text("UI Select")
    }).fadeIn("fast")
    previousContainer = "#uiInterface"
    selectedContainer = "#uiSelectorSettings"
})

$("#UIHide-Elements").click(function(){
    var audio = document.getElementById("click");
    audio.volume = 0.2;
    audio.play();
    $(selectedContainer).slideUp(300)
    $("#uiHideElements").delay(300).slideDown()
    $(".title-header").fadeOut("fast", function() {
        $(".title-header").text("Hide Elements")
    }).fadeIn("fast")
    previousContainer = "#uiInterface"
    selectedContainer = "#uiHideElements"
})

$("#ColorSetup").click(function(){
    var audio = document.getElementById("click");
    audio.volume = 0.2;
    audio.play();
    $(selectedContainer).slideUp(300)
    $("#uiSelectorColors").delay(300).slideDown()
    $(".title-header").fadeOut("fast", function() {
        $(".title-header").text("Colors")
    }).fadeIn("fast")
    previousContainer = "#uiInterface"
    selectedContainer = "#uiSelectorColors"
})

$("#PositionSetup").click(function(){
    var audio = document.getElementById("click");
    audio.volume = 0.2;
    audio.play();
    $(selectedContainer).slideUp(300)
    $("#uiSelectorPosition").delay(300).slideDown()
    $(".title-header").fadeOut("fast", function() {
        $(".title-header").text("Orientation")
    }).fadeIn("fast")
    previousContainer = "#uiInterface"
    selectedContainer = "#uiSelectorPosition"
})

$("#ScaleSetup").click(function(){
    var audio = document.getElementById("click");
    audio.volume = 0.2;
    audio.play();
    $(selectedContainer).slideUp(300)
    $("#uiScaleSetup").delay(300).slideDown()
    $(".title-header").fadeOut("fast", function() {
        $(".title-header").text("Scale")
    }).fadeIn("fast")
    previousContainer = "#uiInterface"
    selectedContainer = "#uiScaleSetup"

    if(getNotification() == "basic") {
        var html = `<div class="notification">\
            <div class="header"><div class="header-text"><i class="fas fa-inbox"></i>NOTIFICATION</div></div>\
            <div class="bottom-text">Notification type 1</div>\
        </div>`
    } else if(getNotification() == "modern") {
        var html = `<div class="notification2">\
            <div class="before">\
                <div class="background-icon"><i class="fas fa-inbox"></i></div>\
            </div>\
            <div class="rest">\
                <div class="header">NOTIFICATION</div>\
                <div class="footer">Notification test</div>\
            </div>\
        </div>`
    } else {
        Notification("Error")
    }

    if(!isInCar) {
        $(".vehicle-ui").fadeIn()
        $(".streetlabel-container").fadeIn()
    }

    $(".notifications-container").html(html)
})

$("#FontSetup").click(function(){
    var audio = document.getElementById("click");
    audio.volume = 0.2;
    audio.play();
    $(selectedContainer).slideUp(300)
    $("#uiFontSetup").delay(300).slideDown()
    $(".title-header").fadeOut("fast", function() {
        $(".title-header").text("Scale")
    }).fadeIn("fast")
    previousContainer = "#uiInterface"
    selectedContainer = "#uiFontSetup"
})

$("#UISelectorSave").click(async function(){
    var audio = document.getElementById("click");
    audio.volume = 0.2;
    audio.play();
})

$(".button-exit").click(function(){
    var audio = document.getElementById("audio");
    audio.volume = 0.2;
    audio.play();
    $(".ui-hud-settings").fadeOut(300)
    $(selectedContainer).fadeOut(300)
    containerTextClear()
})

$(".button-back").click(function(){
    var audio = document.getElementById("click");
    audio.volume = 0.2;
    audio.play();
    if (previousContainer != null) {
        $(selectedContainer).slideUp(300)
        $(previousContainer).delay(300).slideDown()
        selectedContainer = previousContainer
        containerText()
    }

    if(!isInCar) {
        $(".vehicle-ui").fadeOut()
        $(".streetlabel-container").fadeOut()
    }

    $(".notifications-container").empty()

})

$("#goToSecond").click(function() {
    console.log("gotosecond")
    $("#firstSetupUI").animate({"left": "-20%", "opacity": "0.0"}, "ease-in-out")
    $("#secondSetupUI").css({"display": "flex"}).animate({"left": "0%", "opacity": "1.0"}, "ease-in-out")
    var audio = document.getElementById("audio");
    audio.volume = 0.2;
    audio.play();
    $("#uiSelection-Square").css({"display": "flex", "left": "20%", "opacity": "1"})
})

$("#goToThird").click(async function() {
    $("#secondSetupUI").animate({"left": "-20%", "opacity": "0.0"}, "ease-in-out")
    $("#thirdSetupUI").css({"display": "flex"}).animate({"left": "0%", "opacity": "1.0"}, "ease-in-out")
    var audio = document.getElementById("audio");
    audio.volume = 0.2
    audio.play()
    var selectedBootUI = $("#uiSelection").val()
    var myUI = "uiSquare"
    if (selectedBootUI == "uiSelection-Diamond") {
        myUI = "uiDiamond"
    } else if (selectedBootUI == "uiSelection-Square") {
        myUI = "uiSquare"
    } else if (selectedBootUI == "uiSelection-Square2") {
        myUI = "uiSquare2"
    } else if (selectedBootUI == "uiSelection-Skew") {
        myUI = "uiSkew"
    } 
    console.log(myUI)
    saveUI(myUI)
    setUIPos()
    $("#notify-basic").css({"opacity": "1"})
})

$("#goToFourth").click(async function() {
    $("#thirdSetupUI").animate({"left": "-20%", "opacity": "0.0"}, "ease-in-out")
    $("#fourthSetupUI").css({"display": "flex"}).animate({"left": "0%", "opacity": "1.0"}, "ease-in-out")
    var audio = document.getElementById("audio");
    audio.volume = 0.2
    audio.play()
    
})

$("#goToFinish").click(async function() {
    $("#fourthSetupUI").animate({"left": "-20%", "opacity": "0.0"}, "ease-in-out")
    $("#finishSetupUI").css({"display": "flex"}).animate({"left": "0%", "opacity": "1.0"}, "ease-in-out")
    var audio = document.getElementById("audio");
    audio.volume = 0.2
    audio.play()
    $.post(`https://${GetParentResourceName()}/NUIFocusOff`)
    sleppyUI() // :-)
})

var thisUI = "uiSelection-Square"

$("#button-reset-colors").click(function(){
    var audio = document.getElementById("click");
    audio.volume = 0.2;
    audio.play()
    resetColor()
    Notification("Colors has been restored")
})

$("#button-reset-position").click(function() {
    var audio = document.getElementById("click");
    audio.volume = 0.2;
    audio.play()
    resetUIPos()
    $(`#${getUI()}`).css({"inset": "0"})
    Notification("Position has been restored")
})

$("#button-reset-scale").click(function() {
    var audio = document.getElementById("click");
    audio.volume = 0.2;
    audio.play()
    //resetUIScale()

    $("#ui-scale").val(5)
    $("#veh-ui-scale").val(5)
    $("#notify-scale").val(5)
    $("#streetlabel-scale").val(5)

    setNotifyScale("1.0")
    setUIScale("1.0")
    setVehUIScale("1.0")
    setStreetLabelScale("1.0")

    Notification("Scale has been restored")
})

$("#notification-reset").click(function() {
    var audio = document.getElementById("click");
    audio.volume = 0.2;
    audio.play()
    resetNotifyPos()
    $(".notifications-container").css({"inset": "0"})
    Notification("Notification position has been restored.")
})

$("#vehPositionSetup").click(function(){
    var audio = document.getElementById("click");
    audio.volume = 0.2;
    audio.play();
    $(selectedContainer).slideUp(300)
    $("#vehUIPosition").delay(300).slideDown()
    $(".title-header").fadeOut("fast", function() {
        $(".title-header").text("Position")
    }).fadeIn("fast")
    previousContainer = "#vehUIInterface"
    selectedContainer = "#vehUIPosition"
})

$("#veh-ui-reset").click(function(){
    var audio = document.getElementById("click");
    audio.volume = 0.2;
    audio.play();
    resetVehUIPos()
    $(".vehicle-first").css({"inset": "0"})
})

$("#notifyType").click(function(){
    var audio = document.getElementById("click");
    audio.volume = 0.2;
    audio.play();
    $(selectedContainer).slideUp(300)
    $("#notificationSelector").delay(300).slideDown()
    $(".title-header").fadeOut("fast", function() {
        $(".title-header").text("Notify Select")
    }).fadeIn("fast")

    $("")

    previousContainer = "#notificationSettings"
    selectedContainer = "#notificationSelector"
})

$("#notifyPositionSetup").click(function(){
    var audio = document.getElementById("click");
    audio.volume = 0.2;
    audio.play();
    $(selectedContainer).slideUp(300)
    $("#notifyPosition").delay(300).slideDown()
    $(".title-header").fadeOut("fast", function() {
        $(".title-header").text("Notify Position")
    }).fadeIn("fast")
    previousContainer = "#notificationSettings"
    selectedContainer = "#notifyPosition"
})

$("#orientationRow").click(function(){ 
    $(`#${getUI()}`).css({"flex-direction": "row"})
    setUIOrientation("row")
    Notification("UI Layout has been set to ROW")
})

$("#orientationColumn").click(function(){ 
    $(`#${getUI()}`).css({"flex-direction": "column"})
    setUIOrientation("column")
    Notification("UI Layout has been set to COLUMN")
})

var firstSelected = "uiSelection-Square"
var notificationTypeBoot = "notify-basic"

$(".custom-option").on("click", function() {
    var menuValue = $(this).data("menu")
    var audio = document.getElementById("click");
    audio.volume = 0.05;
    audio.play();
    if (menuValue == "boot") {
        if (firstSelected != $(this).data("value")) {
            $(`#${firstSelected}`).animate({"left": "0%", "opacity": "0"}, "ease-in-out").delay(100).fadeOut()
            $(`#${$(this).data("value")}`).delay(300).css({"display": "flex"}).animate({"left": "20%", "opacity": "1"}, "ease-in-out")
            firstSelected =  $(this).data("value")
        }
    } else if (menuValue == "ui-select") {
        let selectedUI = document.getElementById("uiSelect").value;
        Notification("UI Saved")
        $(`#${getUI()}`).fadeOut(400)
        sleep(2000)
        saveUI(selectedUI)
        //alert(selectedUI)
        $(`#${selectedUI}`).delay(500).css({"display": "flex"}).hide().fadeIn()
    } else if (menuValue == "notification-type") {
        var type = document.getElementById("notifySelect").value
        saveNotification(type)
        notificationType = type
        Notification("Notification type saved")
    } else if (menuValue == "boot-notification") {
        if (document.getElementById("notification-boot").value != notificationTypeBoot) {
            console.log($(this).data("menu"))
            var valueType = $(this).data("type")
            console.log(valueType)
            var type = document.getElementById("notification-boot").value
            saveNotification($(this).attr("data-type"))
            $(`#${notificationTypeBoot}`).animate({"right": "0%", "opacity": "0"}, "ease-in-out").delay(100).fadeOut()
            notificationType = $(this).data("type")
            
            $(`#${type}`).delay(300).css({"display": "block"}).animate({"right": "8%", "opacity": "1"}, "ease-in-out")
            notificationTypeBoot = type
            Notification("Notification type saved")
        }
    } else if(menuValue == "ui-font") {
        selectedFont = $(this).data("value")
        setFont(selectedFont)
        Notification("Font saved")
    }
})

$(document).on('input change', '#ui-scale', function() {
    var scale = $(this).val() / 5
    setUIScale(scale)
});

$(document).on('input change', '#veh-ui-scale', function() {
    var scale = $(this).val() / 5
    setVehUIScale(scale)
});

$(document).on('input change', '#notify-scale', function() {
    var scale = $(this).val() / 5
    setNotifyScale(scale)
});

$(document).on('input change', '#streetlabel-scale', function() {
    var scale = $(this).val() / 5
    setNotifyScale(scale)
});

$(document).on('input change', '#streetlabel-scale', function() {
    var scale = $(this).val() / 5
    setStreetLabelScale(scale)
});