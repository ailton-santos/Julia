# Importa o módulo Random para gerar números aleatórios
using Random

# Define o número secreto (entre 1 e 100)
# rand(1:100) gera um número inteiro aleatório nesse intervalo
numero_secreto = rand(1:100)
tentativas = 0
acertou = false

println("--- Jogo de Adivinhação de Números ---")
println("Tente adivinhar o número secreto entre 1 e 100.")

# Loop 'while' continua enquanto o jogador não acertar
while acertou == false
    print("Qual é o seu palpite? ")
    
    # Lê a entrada do usuário
    palpite_str = readline()
    
    # Tenta converter a entrada para um número inteiro
    palpite = tryparse(Int, palpite_str)

    # Incrementa o contador de tentativas
    tentativas += 1

    # Verifica se a entrada é um número válido
    if palpite === nothing
        println("Entrada inválida. Por favor, digite um número inteiro.")
        # Não incrementa tentativas se a entrada for inválida e continua para a próxima iteração
        tentativas -= 1 
        continue # Volta para o início do loop sem processar o restante
    end

    # Compara o palpite com o número secreto
    if palpite < numero_secreto
        println("Muito baixo! Tente um número maior.")
    elseif palpite > numero_secreto
        println("Muito alto! Tente um número menor.")
    else
        println("Parabéns! Você acertou o número secreto ($numero_secreto) em $tentativas tentativas.")
        acertou = true # Muda a condição para sair do loop
    end
end

println("--- Fim do Jogo ---")