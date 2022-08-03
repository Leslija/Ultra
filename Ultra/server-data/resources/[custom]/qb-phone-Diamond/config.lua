Config = Config or {}
Config.BillingCommissions = { -- This is a percentage (0.10) == 10%
    police = 0.00,
    ambulance = 0.00,
    libertywalk = 0.00,
    strtunners = 0.00
}
Config.Linux = false -- True if linux
Config.RepeatTimeout = 2000
Config.CallRepeats = 10
Config.OpenPhone = 244
Config.PhoneApplications = {
    ["phone"] = {
        app = "phone",
        color = "#04b543",
        icon = "fa fa-phone-alt",
        tooltipText = "Telemóvel",
        tooltipPos = "top",
        job = false,
        blockedjobs = {},
        slot = 1,
        Alerts = 0,
    },
    ["whatsapp"] = {
        app = "whatsapp",
        color = "#25d366",
        icon = "fas fa-comment",
        tooltipText = "Whatsapp",
        tooltipPos = "top",
        style = "font-size: 2.8vh";
        job = false,
        blockedjobs = {},
        slot = 2,
        Alerts = 0,
    },
    ["settings"] = {
        app = "settings",
        color = "#636e72",
        icon = "fa fa-cogs",
        tooltipText = "Definições",
        tooltipPos = "top",
        style = "padding-right: .08vh; font-size: 2.3vh";
        job = false,
        blockedjobs = {},
        slot = 3,
        Alerts = 0,
    },
    ["twitter"] = {
        app = "twitter",
        color = "#00b6c3",
        icon = "fab fa-twitter",
        tooltipText = "Twitter",
        tooltipPos = "top",
        job = false,
        blockedjobs = {},
        slot = 4,
        Alerts = 0,
    },
    ["mail"] = {
        app = "mail",
        color = "#ec2b4d",
        icon = "fas fa-envelope-open-text",
        tooltipText = "Mail",
        job = false,
        blockedjobs = {},
        slot = 5,
        Alerts = 0,
    },
    ["advert"] = {
        app = "advert",
        color = "#00f8b9",
        icon = "fas fa-bullhorn",
        tooltipText = "Mercado",
        job = false,
        blockedjobs = {},
        slot = 6,
        Alerts = 0,
    },
    ["bank"] = {
        app = "bank",
        color = "#9c88ff",
        icon = "fas fa-money-check-alt",
        tooltipText = "Banco",
        job = false,
        blockedjobs = {},
        slot = 7,
        Alerts = 0,
    },
    ["houses"] = {
        app = "houses",
        color = "#ffffff",
        icon = "fas fa-home",
        tooltipText = "Casas",
        job = false,
        blockedjobs = {},
        slot = 8,
        Alerts = 0,
    },
    ["lawyers"] = {
        app = "lawyers",
        color = "#26d4ce",
        icon = "fas fa-briefcase",
        tooltipText = "Serviços",
        tooltipPos = "bottom",
        job = false,
        blockedjobs = {},
        slot = 9,
        Alerts = 0,
    },
    ["gallery"] = {
        app = "gallery",
        color = "#AC1D2C",
        icon = "fas fa-images",
        tooltipText = "Galeria",
        tooltipPos = "bottom",
        job = false,
        blockedjobs = {},
        slot = 10,
        Alerts = 0,
    },
    ["camera"] = {
        app = "camera",
        color = "#d9d9d9",
        icon = "fas fa-camera",
        tooltipText = "Camera",
        tooltipPos = "bottom",
        job = false,
        blockedjobs = {},
        slot = 11,
        Alerts = 0,
    },
    
    
    
}
Config.MaxSlots = 20

Config.StoreApps = {
    ["territory"] = {
        app = "territory",
        color = "#353b48",
        icon = "fas fa-globe-europe",
        tooltipText = "Territorium",
        tooltipPos = "right",
        style = "";
        job = false,
        blockedjobs = {},
        slot = 15,
        Alerts = 0,
        password = true,
        creator = "QBCore",
        title = "Territory",
    },
}
