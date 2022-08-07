$.map(HiddenElements, function (clicked) {
    $(`#hide-${clicked}`).click(function() {
        if (document.getElementById(`hide-${clicked}`).checked) {
            $(`.${clicked}`).fadeOut()
            setHiddenElementUI(clicked, "true")
        } else {
            $(`.${clicked}`).fadeIn()
            setHiddenElementUI(clicked, "false")
        }
    })
})