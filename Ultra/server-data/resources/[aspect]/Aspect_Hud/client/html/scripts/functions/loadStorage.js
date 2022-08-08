var HiddenElements = ["health", "armour", "hunger", "thirst", "voice"]
var isMyPosition = getVehUIPos()
var isMyOrientation = getUIOrientation()
var isMyNotification = getNotification()
var isUIPosition = getUIPos()
var isNotifyPosition = getNotifyPos()
var isMyUIScale = getUIScale()
var isMyVehUIScale = getVehUIScale()
var isMyNotifyScale = getNotifyScale()
var isMyStreetLabelScale = getStreetLabelScale()
var isMyFont = getFont()
var isMyStreetPos = getStreetLabelPos()

const loadStorage = function() {
    console.log("Loading Storage")

    //BOOT MENU
    
    if(getUI() == null) {
        $("#setupUI").fadeIn(1000)
        $.post(`https://${GetParentResourceName()}/NUIFocusOn`)
        console.log("BootMenu")
    } else {
        console.log("Front end")
        $("#front-end").fadeIn()
        $(`#${getUI()}`).css({"display": "flex"})
        $(".stamina").css({"display": "none"})
        $(".oxygen").css({"display": "none"})
        $(".armour").css({"display": "none"})
    }

    if (isMyFont == null) {
        setFont("'Barlow', sans-serif")
    } else {
        setFont(isMyFont)
    }

    if (isMyPosition == null) {
        saveVehUIPos("right")
    } else {
        $(".vehicle-first").css({"inset": isMyPosition})
    }
    
    if (isUIPosition == null) {
        setUIPos("0")
    } else {
        setUIPos(isUIPosition)
    }

    if (isNotifyPosition == null) {
        setNotifyPos("0")
    } else {
        console.log(isNotifyPosition)
        setNotifyPos(isNotifyPosition)
    }

    if (isMyStreetPos == null) {
        setStreetLabelPos("0")
    } else {
        setStreetLabelPos(isMyStreetPos)
    }

    if (isMyOrientation == null) {
        setUIOrientation("row")
    } else {
        $(`#${getUI()}`).css({"flex-direction": `${getUIOrientation()}`}, "ease-in-out")
    }

    if (isMyNotification == null) {
        saveNotification("modern")
    } else {
        notificationType = getNotification()
    }

    if (isMyUIScale == null) {
        setUIScale("1.0")
    } else {
        setUIScale(isMyUIScale)
        $("#ui-scale").val(isMyUIScale * 5)
    }

    if (isMyVehUIScale == null) {
        setVehUIScale("1.0")
    } else {
        setVehUIScale(isMyVehUIScale)
        $("#veh-ui-scale").val(isMyVehUIScale * 5)
    }

    if (isMyNotifyScale == null) {
        setNotifyScale("1.0")
    } else {
        setNotifyScale(isMyNotifyScale)
        $("#notify-scale").val(isMyNotifyScale * 5)
    }

    if (isMyStreetLabelScale == null) {
        setNotifyScale("1.0")
    } else {
        setNotifyScale(isMyStreetLabelScale)
        $("#streetlabel-scale").val(isMyStreetLabelScale * 5)
    }

    $.map(HiddenElements, function(element) {
        if (getHiddenElementUI(element) == null) {
            setHiddenElementUI(element, "false")
        } else if(getHiddenElementUI(element) == "true") {
            $(`.${element}`).fadeOut()
            $(`#hide-${element}`).prop('checked', true);
            setHiddenElementUI(element, "true")
        } else if(getHiddenElementUI(element) == "false") {
            $(`.${element}`).fadeIn()
            $(`#hide-${element}`).prop('checked', false);
            setHiddenElementUI(element, "false")
        }
    });
}