Config = {}

-- Configurações de tamanho nao deixe 1.0 pois buga
Config.tamanhos = {
    grande = {
        min = 1.01,    -- Tamanho mínimo ao usar o item grande
        max = 1.30     -- Tamanho máximo ao usar o item grande
    },
    normal = {
        min = 1.01,    -- Tamanho mínimo ao usar o item normal
        max = 1.01     -- Tamanho máximo ao usar o item normal
    },
    pequeno = {
        min = 0.70,    -- Tamanho mínimo ao usar o item pequeno
        max = 0.99     -- Tamanho máximo ao usar o item pequeno
    }
}

-- Itens consumíveis
Config.itemParaAumentar = 'grande'          -- Nome do item para aumentar o tamanho
Config.itemParaResetar = 'normal'           -- Nome do item para retornar ao tamanho padrão
Config.itemParaDiminuir = 'pequeno'         -- Nome do item para diminuir o tamanho

Config.comandatt = 'att' -- caso bugue o tamanho use este comando

-- Nome da tabela SQL onde o tamanho do personagem será salvo
Config.SQLTable = "character" --- NÃO MEXA

-- Nome do campo que armazenará o tamanho do jogador no banco de dados
Config.SizeField = "size" --- NÃO MEXA


-- Função de notificação personalizada
function notifyPlayer(src, message)
    TriggerClientEvent('txk_notify:notify', src, message, 'success', 6000, 'middle-right')
end

function notifyPlayerError(src, message)
    TriggerClientEvent('txk_notify:notify', src, message, 'error', 6000, 'middle-right')
end
