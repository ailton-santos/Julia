# --- Gerenciamento de Pacotes ---
# A linha 'using Pkg' é necessária para usar as funcionalidades do gerenciador de pacotes.
# Geralmente, você faria isso no console REPL de Julia, mas para o exemplo, vamos ilustrar aqui.

# Para adicionar um pacote (se você ainda não o tem):
# No REPL (modo Julia):
# julia> using Pkg
# julia> Pkg.add("Dates") # Adiciona o pacote Dates
# julia> Pkg.add("Random") # Adiciona o pacote Random (geralmente já vem com Julia, mas bom saber)

# Para usar um pacote (tornar suas funções disponíveis):
# Colocamos 'using' no início do nosso script para carregar as funcionalidades dos pacotes.
using Random # Para gerar números aleatórios
using Dates  # Para trabalhar com datas e horas

println("--- Sistema de Análise de Eventos ---")

# --- Estrutura de Dados para Eventos ---
# Cada evento será um dicionário para manter as informações organizadas
# A lista (Array) de eventos armazenará esses dicionários
eventos_registrados = []

# --- Configurações Iniciais ---
numero_de_eventos_para_simular = 3

println("\nSimulando o registro de $numero_de_eventos_para_simular eventos:")

# Loop FOR para simular o registro de vários eventos
for i = 1:numero_de_eventos_para_simular
    println("\n--- Registro do Evento #$i ---")

    # --- Usando funcionalidades do pacote Random ---
    # Gerar uma data e hora de início aleatória
    # Vamos gerar anos entre 2023 e 2025, meses 1-12, dias 1-28, horas 0-23, minutos 0-59
    ano_aleatorio = rand(2023:2025)
    mes_aleatorio = rand(1:12)
    dia_aleatorio = rand(1:28) # Evita problemas com meses de 30/31/29 dias
    hora_aleatoria = rand(0:23)
    minuto_aleatorio = rand(0:59)

    # --- Usando funcionalidades do pacote Dates ---
    # Cria um DateTime object (data e hora)
    # DateTime é um tipo de dado definido no pacote Dates
    data_hora_inicio = DateTime(ano_aleatorio, mes_aleatorio, dia_aleatorio, hora_aleatoria, minuto_aleatorio)
    println("  Data/Hora de Início Gerada: $(data_hora_inicio)")

    # Gerar uma duração aleatória em minutos (entre 30 e 360 minutos = 0.5 a 6 horas)
    duracao_minutos = rand(30:360)
    
    # --- Usando funcionalidades do pacote Dates para manipular tempo ---
    # Cria um Period object (duração) em minutos
    # Minute é um tipo de dado definido no pacote Dates
    periodo_duracao = Minute(duracao_minutos)
    println("  Duração do Evento Gerada: $(duracao_minutos) minutos")

    # Calcula a data/hora de término somando o período à data de início
    data_hora_fim = data_hora_inicio + periodo_duracao
    println("  Data/Hora de Término Calculada: $(data_hora_fim)")

    # Armazena os dados do evento em um dicionário
    evento_atual = Dict(
        "id" => i,
        "inicio" => data_hora_inicio,
        "duracao_minutos" => duracao_minutos,
        "fim" => data_hora_fim
    )
    
    push!(eventos_registrados, evento_atual) # Adiciona o dicionário do evento à lista
end

println("\n--- Resumo dos Eventos Registrados ---")

# Loop FOR para exibir os detalhes de cada evento
for evento in eventos_registrados
    println("\nEvento ID: $(evento["id"])")
    println("  Início: $(evento["inicio"])")
    println("  Duração: $(evento["duracao_minutos"]) minutos")
    println("  Término: $(evento["fim"])")

    # --- Exemplo de IF/ELSE com lógica de tempo ---
    # Verifica se o evento terminou antes de um certo horário (ex: 18:00 do mesmo dia)
    # Isso requer mais manipulação de Dates.
    # Primeiro, extraímos a data (ano, mês, dia) da data/hora de início
    data_do_dia = Date(evento["inicio"])
    # Criamos um DateTime para 18:00 (6 PM) do mesmo dia do evento
    hora_corte = DateTime(year(data_do_dia), month(data_do_dia), day(data_do_dia), 18, 0, 0)

    if evento["fim"] < hora_corte
        println("  Status: Terminou antes das 18:00 do mesmo dia.")
    else
        println("  Status: Terminou às 18:00 ou depois (ou no dia seguinte).")
    end
end

println("\n--- Fim da Análise de Eventos ---")