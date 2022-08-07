/////////////////////////////////
////////// Container Functions
////// AD. Please, do not touch

/////////////////////////
////// NOTIFICATION UI
////

const Notification = function(text) {
    $(".notification-text").html(text)
    $(".notification-container").qcss({"transform": "translateY(50%)"}, "ease-in-out").delay(2000).qcss({"transform": "translateY(-200%)"})
}

//////////////////////////////////
////// Container Main Functions
////

const Quit = function() {
    var audio = document.getElementById("audio");
    audio.volume = 0.2;
    audio.play();
    if (!isDragging) {
        $(".ui-hud-settings").fadeOut(300)
        $(selectedContainer).fadeOut(300)
        $(".hud-bars").fadeOut()
        $.post(`https://${GetParentResourceName()}/NUIFocusOff`)
    } else {
        Notification("Drag mode is enabled.")
    }
}

const containerText = function() {
    if (selectedContainer == "#mainSettings") {
        $(".title-header").animate({"padding-right": "-130px"}, "ease-in-out", function(){
            $(".title-header").text("Settings")
        }).fadeIn("fast")
    } else if (selectedContainer == "#uiInterface") {
        $(".title-header").fadeOut("fast", function() {
            $(".title-header").text("UI Setup")
        }).fadeIn("fast")
    } else if (selectedContainer == "#vehUIInterface") {
        $(".title-header").fadeOut("fast", function() {
            $(".title-header").text("Vehicle Setup")
        }).fadeIn("fast")
    } else if (selectedContainer == "#notificationSettings") {
        $(".title-header").fadeOut("fast", function() {
            $(".title-header").text("Notify Setup")
        }).fadeIn("fast")
    } 
}

const containerTextClear = function() {
    $(".title-header").fadeOut("fast", function() {
        $(".title-header").text("")
    }).fadeIn("fast")
}

const sleppyUI = async function() {
    var music = document.getElementById("music");
    music.volume = 0.2;
    music.play();
    console.log("Retrieving settings from storage")
    await sleep(13650)
    console.log("Done!")
    $("#finishingSetup").animate({"left": "70%", "opacity": "0"})
    $("#welcome").animate({"top": "50%", "opacity": "1"})
    $("#setupUI").fadeOut(11000)
    await sleep(2000)
    $("#front-end").fadeIn(9000)
    $(`#${getUI()}`).css({"display": "flex"}).hide().fadeIn()
    $(".stamina").css({"display": "none"})
    $(".oxygen").css({"display": "none"})
    $(".armour").css({"display": "none"})
}

/* BAR FUNCTIONS */

const UISetup = function() {
    $(".ui-hud-settings").fadeOut(300)
    $(selectedContainer).fadeOut(300)
    var audio = document.getElementById("audio");
    audio.volume = 0.2;
    audio.play();
    $(".ui-hud-settings").css({"display": "flex"}).hide().slideDown()
    $("#uiInterface").delay(300).slideDown()
    $(".title-header").animate({"padding-right": "130px"}, "ease-in-out", function(){
        $(".title-header").text("UI Setup")
    }).fadeIn("fast")
    previousContainer = "#mainSettings"
    selectedContainer = "#uiInterface"
}

const VehUISetup = function() {
    //$(".hud-bars").fadeOut()
    $(".ui-hud-settings").fadeOut(300)
    $(selectedContainer).fadeOut(300)
    var audio = document.getElementById("audio");
    audio.volume = 0.2;
    audio.play();
    $(".ui-hud-settings").css({"display": "flex"}).hide().slideDown()
    $("#vehUIInterface").delay(300).slideDown()
    $(".title-header").animate({"padding-right": "130px"}, "ease-in-out", function(){
        $(".title-header").text("Vehicle Setup")
    }).fadeIn("fast")
    //$(".hud-settings-bars").fadeOut()
    previousContainer = "#mainSettings"
    selectedContainer = "#vehUIInterface"
}

const NotifySetup = function() {
    //$(".hud-bars").fadeOut()
    $(".ui-hud-settings").fadeOut(300)
    $(selectedContainer).fadeOut(300)
    var audio = document.getElementById("audio");
    audio.volume = 0.2;
    audio.play();
    $(".ui-hud-settings").css({"display": "flex"}).hide().slideDown()
    $("#notificationSettings").delay(300).slideDown()
    $(".title-header").animate({"padding-right": "130px"}, "ease-in-out", function(){
        $(".title-header").text("Notify Setup")
    }).fadeIn("fast")
    //$(".hud-settings-bars").fadeOut()
    previousContainer = "#mainSettings"
    selectedContainer = "#notificationSettings"
}

var isInCar = false

const Draggable = function() {
    if (!isDragging) {
        var audio = document.getElementById("click");
        audio.volume = 0.2;
        audio.play();

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
        }

        $(`#${getUI()}`).draggable({disabled: false, scroll: false, 
            start: function(){
            $(`#${getUI()}`).css({'width': "auto", "height": "auto"});
         }});
        $(".vehicle-first").draggable({disabled: false, scroll: false, 
            start: function(){
            $(".vehicle-first").css({'width': "auto", "height": "auto"});
         }})
        $(".notifications-container").draggable({disabled: false, scroll: false, 
            start: function(){
            $(".notifications-container").css({'width': "auto", "height": "auto"});
        }});
        $(".streetlabel").draggable({disabled: false, scroll: false, 
            start: function(){
            $(".notifications-container").css({'width': "auto", "height": "auto"});
        }});

        if(!isInCar) {
            $(".vehicle-ui").css({"display": "flex"}).hide().fadeIn()
            $(".streetlabel-container").fadeIn()
        }

        $(".notifications-container").html(html)

        isDragging = true
        Notification("Dragging enabled")

    } else if (isDragging) {

        var audio = document.getElementById("click");
        audio.volume = 0.2;
        audio.play();

        if(!isInCar) {
            $(".vehicle-ui").fadeOut()
            $(".streetlabel-container").fadeOut()
        }

        $(".notifications-container").empty()

        $(`#${getUI()}`).draggable({disabled: true, scroll: false});
        $(".vehicle-first").draggable({disabled: true, scroll: false});
        $(".notifications-container").draggable({disabled: true, scroll: false});
        $(".streetlabel").draggable({disabled: true, scroll: false});

        setUIPosToCSS()
        setNotifyPosToCSS()
        setVehUIPosToCSS()
        setStreetLabelPosToCSS()

        isDragging = false
        Notification("Dragging disabled")
    }
}