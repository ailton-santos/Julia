# 1. Solicita o nome do material ao usuário
print("Digite o nome do material (ex: Cimento, Tijolo, Areia): ")
nome_material = readline()

# 2. Solicita o preço unitário do material
print("Digite o preço unitário do ", nome_material, " (em R$): ")
# readline() lê como string, parse(Float64, ...) converte para número decimal
preco_unitario_str = readline()
preco_unitario = parse(Float64, preco_unitario_str)

# 3. Solicita a quantidade desejada
print("Digite a quantidade de ", nome_material, " que você precisa: ")
quantidade_str = readline()
quantidade = parse(Int, quantidade_str) # parse(Int, ...) converte para número inteiro

# 4. Calcula o custo total inicial
custo_total = preco_unitario * quantidade

# 5. Aplica um desconto condicional
# Se a quantidade for maior ou igual a 100 unidades, aplica 10% de desconto
if quantidade >= 100
    desconto = custo_total * 0.10
    custo_total_com_desconto = custo_total - desconto
    println("\nParabéns! Você comprou ", quantidade, " unidades de ", nome_material, " e ganhou 10% de desconto!")
    println("Valor do desconto: R$", round(desconto, digits=2)) # round(..., digits=2) formata para 2 casas decimais
    println("Custo total com desconto: R$", round(custo_total_com_desconto, digits=2))
else
    # Se a condição acima for falsa (quantidade < 100)
    println("\nQuantidade insuficiente para desconto. Compre 100 ou mais unidades para ganhar 10% de desconto.")
    println("Custo total sem desconto: R$", round(custo_total, digits=2))
end

println("\nObrigado por usar nosso calculador de custos!")