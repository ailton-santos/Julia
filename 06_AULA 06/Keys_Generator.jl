using Random # Para gerar caracteres aleatórios

# Conjuntos de caracteres disponíveis
caracteres_letras = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"
caracteres_numeros = "0123456789"
caracteres_simbolos = "!@#$%^&*()_+-=[]{}|;:,.<>?"

println("--- Gerador de Senhas Simples ---")

# --- Coleta de critérios do usuário ---
print("Tamanho mínimo da senha (ex: 8): ")
tamanho_min_str = readline()
tamanho_min = tryparse(Int, tamanho_min_str)

if tamanho_min === nothing || tamanho_min < 1
    println("Tamanho mínimo inválido. Usando 8 como padrão.")
    tamanho_min = 8
end

print("A senha deve incluir números? (s/n): ")
incluir_numeros_resp = lowercase(readline())
incluir_numeros = (incluir_numeros_resp == "s")

print("A senha deve incluir símbolos? (s/n): ")
incluir_simbolos_resp = lowercase(readline())
incluir_simbolos = (incluir_simbolos_resp == "s")

# Combina os caracteres disponíveis com base nas escolhas do usuário
caracteres_base = caracteres_letras
if incluir_numeros
    caracteres_base *= caracteres_numeros # Adiciona números se solicitado
end
if incluir_simbolos
    caracteres_base *= caracteres_simbolos # Adiciona símbolos se solicitado
end

# Se nenhum tipo de caractere foi selecionado além de letras
if !incluir_numeros && !incluir_simbolos
    println("Nenhum caractere especial selecionado. A senha terá apenas letras.")
end

# --- Geração e Validação da Senha ---
senha_gerada = ""
senha_valida = false
tentativas_geracao = 0
max_tentativas = 1000 # Limite para evitar loop infinito em critérios muito restritivos

println("\nGerando senha...")

# Loop WHILE para tentar gerar senhas até encontrar uma que atenda aos critérios
while !senha_valida && tentativas_geracao < max_tentativas
    
    tentativas_geracao += 1
    senha_atual = ""
    
    # Loop FOR para construir a senha caractere por caractere
    for _ = 1:tamanho_min
        # rand(caracteres_base) seleciona um caractere aleatório da string
        senha_atual *= string(rand(caracteres_base))
    end

    # --- Verificação dos critérios da senha com IF e operadores lógicos ---
    tem_numeros = false
    tem_simbolos = false
    
    # Loop FOR para verificar cada caractere da senha gerada
    for char in senha_atual
        if occursin(string(char), caracteres_numeros) # Verifica se o caractere é um número
            tem_numeros = true
        end
        if occursin(string(char), caracteres_simbolos) # Verifica se o caractere é um símbolo
            tem_simbolos = true
        end
    end

    # Usa operadores lógicos para determinar se a senha é válida
    # Senha é válida SE:
    # 1. (incluir_numeros é falso OU tem_numeros é verdadeiro)
    # E
    # 2. (incluir_simbolos é falso OU tem_simbolos é verdadeiro)
    senha_valida = (!incluir_numeros || tem_numeros) && (!incluir_simbolos || tem_simbolos)

    # Condição extra: Se a senha não é válida e esgotamos as tentativas, avisar
    if !senha_valida && tentativas_geracao == max_tentativas
        println("Não foi possível gerar uma senha com os critérios especificados após $max_tentativas tentativas. Tente critérios menos restritivos.")
        break # Sai do loop while
    end
end

if senha_valida
    println("Senha Gerada (em $tentativas_geracao tentativas): **$senha_gerada**")
else
    println("A geração de senha falhou ou os critérios foram muito restritivos.")
end

println("--- Fim do Gerador de Senhas ---")