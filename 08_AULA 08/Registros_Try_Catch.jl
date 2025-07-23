# Lista para armazenar os registros de estudantes (cada um será um dicionário)
registros_estudantes = []

println("--- Calculadora de Média de Notas Robusta ---")

# Loop WHILE principal para permitir múltiplos cadastros/consultas
# Continuará enquanto o usuário não digitar 'sair'
continuar_sistema = true
while continuar_sistema
    println("\n--- Menu Principal ---")
    println("1. Cadastrar Notas de Novo Estudante")
    println("2. Ver Médias de Estudantes Cadastrados")
    println("0. Sair do Sistema")
    print("Escolha uma opção: ")

    opcao_str = readline()
    opcao = tryparse(Int, opcao_str)

    if opcao === nothing || (opcao != 1 && opcao != 2 && opcao != 0)
        println("Opção inválida. Por favor, digite 1, 2 ou 0.")
        continue # Volta para o início do loop while
    end

    if opcao == 0
        println("Saindo do sistema. Até mais!")
        continuar_sistema = false # Altera a condição para sair do loop while
        break # Sai imediatamente do loop while
    end

    # --- Opção 1: Cadastrar Notas ---
    if opcao == 1
        println("\n--- Cadastro de Novo Estudante ---")
        print("Digite o nome do estudante: ")
        nome_estudante = readline()

        # Dicionário para armazenar as notas deste estudante
        notas_estudante_atual = Dict{String, Float64}()
        
        # Array para armazenar os nomes das disciplinas que o estudante terá
        disciplinas_para_cadastrar = ["Matemática", "Português", "História"]

        # Loop FOR para coletar notas de cada disciplina
        for disciplina in disciplinas_para_cadastrar
            nota_valida = false
            while !nota_valida
                print("Digite a nota de $disciplina (0-10): ")
                nota_str = readline()
                
                # --- TRY-CATCH para tratar erros na conversão de nota ---
                try
                    nota = parse(Float64, nota_str) # Tenta converter a string para Float64
                    
                    # --- IF/ELSE para validar o intervalo da nota ---
                    if nota < 0.0 || nota > 10.0
                        println("Erro: Nota deve estar entre 0 e 10. Tente novamente.")
                    else
                        notas_estudante_atual[disciplina] = nota # Adiciona a nota ao dicionário
                        nota_valida = true # Marca como válida para sair do loop while
                    end
                catch e # Captura qualquer erro que aconteça no bloco 'try'
                    # Verifica se o erro é uma exceção de "argumento inválido" (ex: texto em vez de número)
                    if isa(e, ArgumentError) 
                        println("Erro de entrada: Por favor, digite um número válido para a nota. Tente novamente.")
                    else
                        # Captura outros tipos de erro inesperados
                        println("Ocorreu um erro inesperado: $e. Tente novamente.")
                    end
                end
            end
        end

        # Adiciona o registro completo do estudante (nome e notas) à lista principal
        push!(registros_estudantes, Dict("nome" => nome_estudante, "notas" => notas_estudante_atual))
        println("Estudante '$nome_estudante' cadastrado com sucesso!")
    end

    # --- Opção 2: Ver Médias ---
    if opcao == 2
        if isempty(registros_estudantes) # Verifica se a lista de estudantes está vazia
            println("Nenhum estudante cadastrado ainda.")
            continue
        end

        println("\n--- Médias dos Estudantes ---")
        # Loop FOR para iterar sobre todos os estudantes cadastrados
        for estudante_registro in registros_estudantes
            nome_estudante = estudante_registro["nome"]
            notas = estudante_registro["notas"] # Pega o dicionário de notas do estudante

            total_notas = 0.0
            num_disciplinas = 0
            
            # Loop FOR para somar as notas e contar as disciplinas
            for (disciplina, nota) in notas
                total_notas += nota
                num_disciplinas += 1
            end

            # --- IF/ELSE para calcular e exibir a média ---
            if num_disciplinas > 0
                media = total_notas / num_disciplinas
                println("\nEstudante: $nome_estudante")
                println("  Média Geral: $(round(media, digits=2))")
                
                # --- Operadores lógicos para status de aprovação ---
                if media >= 7.0 && num_disciplinas > 0 # Precisa ter média alta E pelo menos uma disciplina
                    println("  Status: Aprovado!")
                elseif media >= 5.0 && media < 7.0 && num_disciplinas > 0 # Média entre 5 e 7 E disciplinas
                    println("  Status: Em Recuperação.")
                else # Média abaixo de 5 OU zero disciplinas (caso improvável aqui, mas boa prática)
                    println("  Status: Reprovado.")
                end
            else
                println("\nEstudante: $nome_estudante (Sem notas cadastradas para cálculo da média.)")
            end
        end
    end
end

println("\n--- Fim do Programa ---")