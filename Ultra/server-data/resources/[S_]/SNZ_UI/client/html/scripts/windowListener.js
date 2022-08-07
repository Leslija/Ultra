var imReady = false
var isFuelOn = false
$(function() {	
    window.addEventListener("message", async function(event) {
        var UI = event.data
        
        if(UI.action == "ready") {
            imReady = true
            $.post(`https://${GetParentResourceName()}/UIReady`, JSON.stringify({
                Health: !stringToBool(getHiddenElementUI("health")), 
                Armour: !stringToBool(getHiddenElementUI("armour")), 
                Hunger: !stringToBool(getHiddenElementUI("hunger")),
                Thirst: !stringToBool(getHiddenElementUI("thirst")),
                Voice: !stringToBool(getHiddenElementUI("voice"))
            }))
            
            isFuelOn = UI.data.UseFuel
        } else if(UI.action == "update") {
            if (imReady) {

                if (UI.type == "player") {

                    if(UI.data.armour > 0) {
                        $(".armour").css({"display": "flex"})
                    } else {
                        $(".armour").fadeOut()
                    }

                    document.getElementById("health").innerHTML = '<stop offset="'+UI.data.health+'%" class="squarev2__color"/> <stop offset="'+UI.data.health+'%" stop-color="#1b1b1b"/>';
                    $(`.health-progress`).animate({"height": UI.data.health+"%"}, "ease-in-out")

                    document.getElementById("armour").innerHTML = '<stop offset="'+UI.data.armour+'%" class="squarev2__color"/> <stop offset="'+UI.data.armour+'%" stop-color="#1b1b1b"/>';
                    $(`.armour-progress`).animate({"height": UI.data.armour+"%"}, "ease-in-out")

                    document.getElementById("hunger").innerHTML = '<stop offset="'+UI.data.hunger+'%" class="squarev2__color"/> <stop offset="'+UI.data.hunger+'%" stop-color="#1b1b1b"/>';
                    $(`.hunger-progress`).animate({"height": UI.data.hunger+"%"}, "ease-in-out")

                    document.getElementById("thirst").innerHTML = '<stop offset="'+UI.data.thirst+'%" class="squarev2__color"/> <stop offset="'+UI.data.thirst+'%" stop-color="#1b1b1b"/>';
                    $(`.thirst-progress`).animate({"height": UI.data.thirst+"%"}, "ease-in-out")

                    document.getElementById("stamina").innerHTML = '<stop offset="'+UI.data.stamina+'%" class="squarev2__color"/> <stop offset="'+UI.data.stamina+'%" stop-color="#1b1b1b"/>';
                    $(`.stamina-progress`).css({"height": UI.data.stamina+"%"})

                    document.getElementById("oxygen").innerHTML = '<stop offset="'+UI.data.oxygen+'%" class="squarev2__color"/> <stop offset="'+UI.data.oxygen+'%" stop-color="#1b1b1b"/>';
                    $(`.oxygen-progress`).css({"height": UI.data.oxygen+"%"})

                } else if (UI.type == "carhud") {

                    if(UI.data.speed < 10) {
                        $(".speed").text(UI.data.speed)
                        $(".opacity").text("00")
                    } else if(UI.data.speed >= 10 && UI.data.speed < 100) {
                        $(".speed").text(UI.data.speed)
                        $(".opacity").text("0")
                    } else if (UI.data.speed >= 100) {
                        $(".speed").text(UI.data.speed)
                        $(".opacity").text("")
                    } else if (UI.data.speed == 0) {
                        $(".opacity").text("000")
                        $(".speed").text("")
                    }

                    if (isFuelOn) {
                        $(".fuel").fadeIn()
                        document.getElementById("fuelLevel").innerHTML = '<stop offset="'+UI.data.fuel+'%" class="squarev2__color"/> <stop offset="'+UI.data.fuel+'%" stop-color="rgba(255, 255, 255, 0.681)"/>';
                    }

                    $(".street").text(UI.data.street)
                    $(".direction").text(UI.data.direction)

                    if (UI.data.seatbelt) {
                        $(".belt").css({"color": "var(--main-background-color)"})
                    } else {
                        $(".belt").css({"color": "rgba(255, 255, 255, 0.781)"})
                    }

                    $(".speed").text(UI.data.speed)
                    $(".rpm").text(UI.data.rpm + "RPM")
                
                } else if (UI.type == "voice") {

                    $(".voice-progress").animate({"height": UI.data+"%"}, "ease-in-out")

                } else if (UI.type == "talking") {

                    if (UI.data == "on") {
                        console.log("here")
                        //$(".voice").css({"box-shadow": "0 0 14px 8px var(--main-background-color)"})
                        $(".voice").addClass("activeAnim")
                    } else if(UI.data == "off") {
                        console.log("hereOff")
                        $(".voice").removeClass("activeAnim")
                        //$(".voice").css({"box-shadow": "0 0 14px -2px #1d1d1d"})

                    }
                    
                }
            }
        } else if (UI.action == "open") {

            if (UI.type == "carhud") {

                isInCar = true
                $(".vehicle-ui").fadeIn()

            } else if (UI.type == "settings") {

                $(".hud-bars").css({"display": "flex"}).hide().fadeIn()

            } else if (UI.type == "streetlabel") {

                $(".streetlabel-container").fadeIn()

            } else if (UI.type == "oxygen") {

                $(".oxygen").css({"display": "flex"}).hide().fadeIn()

            } else if (UI.type == "stamina") {

                $(".stamina").css({"display": "flex"}).hide().fadeIn()

            }

        } else if (UI.action == "close") {

            if (UI.type == "carhud") {

                isInCar = false
                $(".vehicle-ui").fadeOut()

            } else if (UI.type == "streetlabel") {

                $(".streetlabel-container").fadeOut()

            } else if (UI.type == "oxygen") {

                $(".oxygen").fadeOut()

            } else if (UI.type == "stamina") {

                $(".stamina").fadeOut()

            }

        } else if (UI.action == "add") {
            
            if(UI.type == "notification") {

                var notify = document.createElement('div');

                if(getNotification() == "basic") {

                    var divElement = (`\
                    <div class="notification">\
                    <div class="header"><div class="header-text"><i class="${UI.data.icon}"></i>${UI.data.header}</div></div>\
                    <div class="bottom-text">${UI.data.text}</div>\
                    </div>`)

                } else if (getNotification() == "modern") {

                    var divElement = (`\
                        <div class="notification2">\
                        <div class="before">\
                            <div class="background-icon"><i class="${UI.data.icon}"></i></div>\
                        </div>\
                        <div class="rest">\
                            <div class="header">${UI.data.header}</div>\
                            <div class="footer">${UI.data.text}</div>\
                        </div>\
                    </div>`)

                }

                $(notify).html(divElement)
                    .appendTo($(".notifications-container"))
                    .hide()
                    .delay(200)
                    .fadeIn()
                $(notify).delay(UI.data.duration).fadeOut()
            }

        } else if (UI.action == "toggle") {

            if (UI.type == "ui") {

                if (!UI.data) {

                    $("#front-end").fadeOut()

                } else {

                    $("#front-end").fadeIn()

                }

            }
        } else if(UI.action == "bootmenu") {

            loadStorage()

        } else if(UI.action == "sound") {
            if (UI.type == "belt") {
                if(UI.data) {

                    var audio = document.getElementById("belton");
                    audio.volume = 0.05;
                    audio.play();

                } else if (!UI.data) {

                    var audio = document.getElementById("beltoff");
                    audio.volume = 0.05;
                    audio.play();

                }
            }
        }
    });
});

$.post(`https://${GetParentResourceName()}/NUIReady`)