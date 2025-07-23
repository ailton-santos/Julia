# Dados iniciais do estoque (Produto, Quantidade, Preço Unitário)
estoque = [
    ["Camiseta", 10, 29.90],
    ["Calça Jeans", 5, 89.90],
    ["Meia", 20, 9.50]
]

println("--- Sistema de Gerenciamento de Estoque ---")

# Variável de controle para o loop WHILE
continuar_vendendo = true

# Loop WHILE principal: continua enquanto houver interesse em vender
while continuar_vendendo

    println("\nEstoque Atual:")
    # Loop FOR para listar os produtos no estoque
    for i = 1:length(estoque)
        # Acessa os dados de cada produto
        nome_produto = estoque[i][1]
        quantidade = estoque[i][2]
        preco = estoque[i][3]
        println("$i. $nome_produto | Quantidade: $quantidade | Preço: R\$ $(preco)")
    end

    print("\nDigite o número do produto que deseja vender (ou '0' para sair): ")
    escolha_str = readline()
    
    # Tenta converter a escolha para um número
    escolha = tryparse(Int, escolha_str)

    # --- IF/ELSE para validar a escolha do produto ---
    if escolha === nothing || escolha < 0 || escolha > length(estoque)
        println("Escolha inválida. Por favor, digite um número válido de produto ou '0' para sair.")
        continue # Volta para o início do loop while
    end

    if escolha == 0
        println("Saindo do sistema de vendas. Até mais!")
        continuar_vendendo = false # Altera a condição para sair do loop while
        break # Sai imediatamente do loop while
    end

    # Se a escolha for válida, pega o produto selecionado
    produto_selecionado_idx = escolha
    nome_produto = estoque[produto_selecionado_idx][1]
    quantidade_disponivel = estoque[produto_selecionado_idx][2]
    preco_unitario = estoque[produto_selecionado_idx][3]

    # --- IF/ELSE para verificar se há estoque disponível ---
    if quantidade_disponivel == 0
        println("Desculpe, $nome_produto está fora de estoque.")
        continue # Volta para o início do loop while para nova escolha
    end

    print("Quantas unidades de '$nome_produto' deseja vender (disponível: $quantidade_disponivel)? ")
    quantidade_venda_str = readline()
    quantidade_venda = tryparse(Int, quantidade_venda_str)

    # --- IF/ELSE para validar a quantidade da venda ---
    if quantidade_venda === nothing || quantidade_venda <= 0
        println("Quantidade inválida. Por favor, digite um número positivo.")
        continue # Volta para o início do loop while
    elseif quantidade_venda > quantidade_disponivel
        println("Não há estoque suficiente! Disponível: $quantidade_disponivel.")
        continue # Volta para o início do loop while
    else
        # Processa a venda
        estoque[produto_selecionado_idx][2] -= quantidade_venda # Diminui o estoque
        valor_total_venda = quantidade_venda * preco_unitario
        println("Venda de $quantidade_venda unidades de '$nome_produto' registrada. Total: R\$ $(round(valor_total_venda, digits=2)).")
        
        # --- IF para verificar se o estoque zerou após a venda ---
        if estoque[produto_selecionado_idx][2] == 0
            println("Atenção: '$nome_produto' está agora fora de estoque!")
        end
    end
end

println("\n--- Resumo Final do Estoque ---")
# Loop FOR para listar o estoque final
for i = 1:length(estoque)
    nome_produto = estoque[i][1]
    quantidade = estoque[i][2]
    preco = estoque[i][3]
    println("$i. $nome_produto | Quantidade: $quantidade | Preço: R\$ $(preco)")
end

println("--- Sistema Encerrado ---")