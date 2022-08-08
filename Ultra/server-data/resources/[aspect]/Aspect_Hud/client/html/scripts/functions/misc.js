/////////////////////////////////
////////// Misc Settings
//////

function sleep(ms) {
    return new Promise(resolve => setTimeout(resolve, ms));
}

const stringToBool = function(val) {
    if (val == "false") {
        return false
    } else if (val == "true") {
        return true
    }
}