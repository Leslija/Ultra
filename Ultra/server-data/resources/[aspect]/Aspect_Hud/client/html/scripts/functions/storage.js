/////////////////////////////////
////////// Functions for colors
//////


const saveColor = function(color) {
    localStorage.setItem("themeColor", color);
}

const getColor = function() {
    return localStorage.getItem("themeColor")
}

const setData = function() {
    configColors = document.querySelector(':root');
    let setColor = getColor()
    configColors.style.setProperty('--main-background-color', setColor)
}

const resetColor = function() {
    configColors = document.querySelector(':root');
    let setColor = saveColor("#fff")
    configColors.style.setProperty('--main-background-color', "#fff")
}

/////////////////////////////////////
////////// Functions for saving UI
//////

const getUI = function() {
    return localStorage.getItem("selectedUI")
}

const saveUI = function(id) {
    localStorage.setItem("selectedUI", id)
}

const resetUI = function() {
    localStorage.setItem("selectedUI", "diamond")
}

//UI POSITION

const getUIPosFromCSS = function() {
    var UIToQuery = document.querySelector(`#${getUI()}`)
    var inset = UIToQuery.style.inset
    return inset
}

const getUIPos = function() {
    return localStorage.getItem("uiPosition")
}

const setUIPosToCSS = function() {
    var uiThatIsSelected = document.querySelector(`#${getUI()}`)
    var configInset = getUIPosFromCSS()
    uiThatIsSelected.style.setProperty("inset", configInset)
    localStorage.setItem("uiPosition", configInset)
}

const setUIPos = function(value) {
    if (getUI() != null) {
        var uiThatIsSelected = document.querySelector(`#${getUI()}`)
        uiThatIsSelected.style.setProperty("inset", value)
        localStorage.setItem("uiPosition", value)
    }
}

const resetUIPos = function() {
    localStorage.setItem("uiPosition", "none")
}

//UI ORIENTATION

const getUIOrientation = function() {
    return localStorage.getItem("uiOrientation")
}

const setUIOrientation = function(type) {
    var uiThatIsSelected = document.querySelector(`#${getUI()}`)
    localStorage.setItem("uiOrientation", type)
}

//UI HIDE ELEMENT

const getHiddenElementUI = function(type) {
    return localStorage.getItem(type)
}

const setHiddenElementUI = function(type, bool) {
    localStorage.setItem(type, bool)
}

/////////////////////////////////////////
////////// Functions for saving VEH UI
//////

const getVehUIPos = function() {
    return localStorage.getItem("vehPosition")
}

const saveVehUIPos = function(type) {
    localStorage.setItem("vehPosition", type)
}

const getVehUIPosFromCSS = function() {
    var VehPosToQuery = document.querySelector(".vehicle-first")
    var inset = VehPosToQuery.style.inset
    return inset
}

const setVehUIPosToCSS = function() {
    var VehUIContainer = document.querySelector(".vehicle-first")
    var configInset = getVehUIPosFromCSS()
    VehUIContainer.style.setProperty("inset", configInset)
    localStorage.setItem("vehPosition", configInset)
}

const resetVehUIPos = function() {
    localStorage.setItem("vehPosition", "none")
}

///////////////////////////////////////////////
////////// Functions for saving Notifications
//////

const getNotification = function() {
    return localStorage.getItem("notificationType")
}

const saveNotification = function(type) {
    localStorage.setItem("notificationType", type)
}

const getNotifyPosFromCSS = function() {
    var NotifyToQuery = document.querySelector(".notifications-container")
    var inset = NotifyToQuery.style.inset
    return inset
}

const getNotifyPos = function() {
    return localStorage.getItem("notificationPos")
}

const setNotifyPosToCSS = function() {
    var NotifyContainer = document.querySelector(".notifications-container")
    var configInset = getNotifyPosFromCSS()
    console.log()
    NotifyContainer.style.setProperty("inset", configInset)
    localStorage.setItem("notificationPos", configInset)
}

const setNotifyPos = function() {
    var NotifyContainer = document.querySelector(".notifications-container")
    var configInset = getNotifyPos()
    NotifyContainer.style.setProperty("inset", configInset)
    localStorage.setItem("notificationPos", configInset)
}

const resetNotifyPos = function() {
    localStorage.setItem("notificationPos", "none")
}

///////////////////////////////////////////////
////////// Functions for saving UI-SCALE
//////

const getUIScale = function () {
    return localStorage.getItem("uiScale")
}

const getVehUIScale = function () {
    return localStorage.getItem("vehUIScale")
}

const getNotifyScale = function () {
    return localStorage.getItem("notifyScale")
}

const getStreetLabelScale = function () {
    return localStorage.getItem("streetLabelScale")
}

///////////////////////////////////////////////
////////// Functions for saving SCALE
//////

const setUIScale = function (value) {
    localStorage.setItem("uiScale", value)
    $(`#${getUI()}`).css({"transform": `scale(${value})`});
}

const setVehUIScale = function (value) {
    localStorage.setItem("vehUIScale", value)
    $(".vehicle-ui-container").css({"transform": `scale(${value})`});
}

const setNotifyScale = function (value) {
    localStorage.setItem("notifyScale", value)
    $(".notifications-container").css({"transform": `scale(${value})`});
}

const setStreetLabelScale = function (value) {
    localStorage.setItem("streetLabelScale", value)
    $(".streetlabel-container").css({"transform": `scale(${value})`});
}

///////////////////////////////////////////////
////////// Functions for saving FONTS
//////

const setFont = function (whatFont) {
    var configFont = document.querySelector(':root');
    configFont.style.setProperty('--main-font', whatFont)
    localStorage.setItem("uiFont", whatFont)
}

const getFont = function () {
    var configFont = document.querySelector(':root');
    configFont.style.setProperty('--main-font', localStorage.getItem("uiFont"))
    return localStorage.getItem("uiFont")
}

///////////////////////////////////////////////
////////// Functions for saving Streetlabel
//////

const getStreetLabelPos = function() {
    return localStorage.getItem("streetLabelPos")
}

const setStreetLabelPos = function() {
    var StreetContainer = document.querySelector(".streetlabel")
    var configInset = getStreetLabelPos()
    StreetContainer.style.setProperty("inset", configInset)
    localStorage.setItem("streetLabelPos", configInset)
}

const getStreetLabelPosFromCSS = function() {
    var LabelToQuery = document.querySelector(".streetlabel")
    var inset = LabelToQuery.style.inset
    return inset
}

const setStreetLabelPosToCSS = function() {
    var StreetContainer = document.querySelector(".streetlabel")
    var configInset = getStreetLabelPosFromCSS()
    StreetContainer.style.setProperty("inset", configInset)
    localStorage.setItem("streetLabelPos", configInset)
}