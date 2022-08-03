Config = {}


Config.Notify = false


Config.DrawTextUI = false

Config.DrawSprite = {
    -- Destrancada
    [0] = {'mpsafecracking', 'lock_open', 0, 0, 0.018, 0.018, 0, 255, 255, 255, 100},

    -- Trancada
    [1] = {'mpsafecracking', 'lock_closed', 0, 0, 0.018, 0.018, 0, 255, 255, 255, 100},
}

-- Pessoas com a permissao no server.cfg podem abrir todas as portas
Config.CommandPrincipal = 'group.admin'

-- Pessoas com 'command.doorlock' no server.cfg podem abrir certas portas
Config.PlayerAceAuthorised = false
