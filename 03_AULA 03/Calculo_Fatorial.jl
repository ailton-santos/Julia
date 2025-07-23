# Lista de números para processar
numeros_para_processar = [0, 3, 5, 8, -2, 10]

println("--- Processando Números ---")

for num in numeros_para_processar
    print("Número: ", num)

    # --- Lógica do Fatorial (diretamente no loop) ---
    if num < 0
        println(" | Fatorial: Número inválido (negativo).")
        # Pula para a próxima iteração do loop, já que não podemos calcular o fatorial nem par/ímpar para negativos aqui
        continue
    elseif num == 0
        fatorial_resultado = 1
    else
        fatorial_resultado = 1
        # Loop interno para calcular o fatorial de 'num'
        for i = 1:num
            fatorial_resultado *= i
        end
    end

    # --- Lógica de Par/Ímpar (diretamente no loop) ---
    if num % 2 == 0
        par_impar_resultado = "par"
    else
        par_impar_resultado = "ímpar"
    end

    # Imprime os resultados combinados
    println(" | Fatorial: ", fatorial_resultado, " | É ", par_impar_resultado)
end

println("--- Processamento Concluído ---")