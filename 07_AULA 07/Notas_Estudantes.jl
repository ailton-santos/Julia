# 1. Lista (Array) de estudantes cadastrados
# Cada estudante será representado por um Dicionário
estudantes_cadastrados = []

# 2. Dicionário (Hash Map) para armazenar as notas de cada estudante
# A chave será o nome do estudante e o valor será outro Dicionário
# Este dicionário interno armazenará as disciplinas e as notas em tuplas
notas_estudantes = Dict{String, Dict{String, Tuple{Float64, Float64, Float64}}}() # NomeEstudante => Disciplina => (Nota1, Nota2, Nota3)

println("--- Sistema de Gerenciamento de Notas de Estudantes ---")

# --- Cadastro de Estudantes e suas Notas ---

# Loop para cadastrar alguns estudantes e suas notas
# Usaremos um 'for' loop simples para simular entradas predefinidas
# Mas poderia ser um 'while' loop para entrada interativa do usuário
for i = 1:3 # Vamos cadastrar 3 estudantes para este exemplo
    println("\n--- Cadastro do Estudante $(i) ---")

    print("Nome do estudante: ")
    nome_estudante = readline()

    # Cria um dicionário para o estudante e adiciona à lista de estudantes
    estudante_info = Dict("nome" => nome_estudante, "id" => "E00$(i)")
    push!(estudantes_cadastrados, estudante_info) # Adiciona o dicionário do estudante à lista

    # Dicionário temporário para armazenar as notas deste estudante
    disciplinas_notas_temporarias = Dict{String, Tuple{Float64, Float64, Float64}}()

    # Loop 'for' para coletar notas de 2 disciplinas por estudante
    for j = 1:2
        print("Nome da disciplina $(j): ")
        nome_disciplina = readline()

        print("Nota 1 de $nome_disciplina: ")
        nota1_str = readline()
        nota1 = tryparse(Float64, nota1_str)
        if nota1 === nothing
            println("Nota inválida. Usando 0.0.")
            nota1 = 0.0
        end

        print("Nota 2 de $nome_disciplina: ")
        nota2_str = readline()
        nota2 = tryparse(Float64, nota2_str)
        if nota2 === nothing
            println("Nota inválida. Usando 0.0.")
            nota2 = 0.0
        end

        print("Nota 3 de $nome_disciplina: ")
        nota3_str = readline()
        nota3 = tryparse(Float64, nota3_str)
        if nota3 === nothing
            println("Nota inválida. Usando 0.0.")
            nota3 = 0.0
        end
        
        # Armazena as 3 notas como uma TUPLA no dicionário de disciplinas
        disciplinas_notas_temporarias[nome_disciplina] = (nota1, nota2, nota3)
    end

    # Adiciona o dicionário de disciplinas e notas ao dicionário principal de notas dos estudantes
    notas_estudantes[nome_estudante] = disciplinas_notas_temporarias
end

println("\n--- Dados Cadastrados ---")

# --- Consulta e Exibição de Dados ---

# Loop 'for' para iterar sobre a lista de estudantes e exibir seus dados
println("\nLista de Estudantes e seus IDs:")
for estudante_info in estudantes_cadastrados
    println("ID: $(estudante_info["id"]), Nome: $(estudante_info["nome"])")
end

# Loop 'while' para permitir consultas interativas de notas
consultar_notas = true
while consultar_notas
    print("\nDigite o nome do estudante para consultar as notas (ou 'sair' para finalizar): ")
    nome_consulta = readline()

    if lowercase(nome_consulta) == "sair"
        println("Finalizando consulta de notas.")
        consultar_notas = false
        break
    end

    # --- IF/ELSE para verificar se o estudante existe no dicionário de notas ---
    if haskey(notas_estudantes, nome_consulta)
        println("\nNotas de $nome_consulta:")
        
        # Pega o dicionário de disciplinas/notas do estudante
        notas_disciplinas = notas_estudantes[nome_consulta]
        
        # Loop 'for' para iterar sobre as disciplinas e suas tuplas de notas
        # items(notas_disciplinas) retorna pares (chave, valor)
        for (disciplina, notas_tupla) in notas_disciplinas
            nota1_val = notas_tupla[1]
            nota2_val = notas_tupla[2]
            nota3_val = notas_tupla[3]
            
            media = (nota1_val + nota2_val + nota3_val) / 3
            
            println("  - $disciplina: Nota 1=$(nota1_val), Nota 2=$(nota2_val), Nota 3=$(nota3_val) | Média: $(round(media, digits=2))")
            
            # --- IF/ELSE para status de aprovação (usando a média) ---
            if media >= 7.0
                println("    Status: Aprovado!")
            elseif media >= 5.0
                println("    Status: Em Recuperação.")
            else
                println("    Status: Reprovado.")
            end
        end
    else
        println("Estudante '$nome_consulta' não encontrado.")
    end
end

println("\n--- Sistema Encerrado ---")