# Classe para representar um Produto
mutable struct Produto
    nome::String
    categoria::String
    preco::Float64
    quantidade_vendida::Int
    
    # Construtor da classe Produto
    function Produto(nome::String, categoria::String, preco::Float64, quantidade_vendida::Int)
        # Validação básica de entrada no construtor
        if preco < 0.0
            @warn "Preço do produto '$nome' não pode ser negativo. Definindo como 0.0."
            preco = 0.0
        end
        if quantidade_vendida < 0
            @warn "Quantidade vendida de '$nome' não pode ser negativa. Definindo como 0."
            quantidade_vendida = 0
        end
        new(nome, categoria, preco, quantidade_vendida)
    end
end

# Classe para gerenciar um conjunto de dados de vendas (uma coleção de objetos Produto)
mutable struct GerenciadorDeVendas
    # O atributo 'produtos' será uma lista (Array) de objetos Produto
    produtos::Vector{Produto}

    # Construtor da classe GerenciadorDeVendas
    function GerenciadorDeVendas()
        new([]) # Inicializa a lista de produtos vazia
    end

    # Método para adicionar um produto ao gerenciador
    function adicionar_produto_a_gerenciador!(self::GerenciadorDeVendas, produto::Produto)
        push!(self.produtos, produto)
        println("Produto '$(produto.nome)' adicionado ao gerenciador de vendas.")
    end

    # Método para calcular o valor total de vendas
    function calcular_valor_total_vendas(self::GerenciadorDeVendas)
        total_vendas = 0.0
        for produto in self.produtos
            total_vendas += produto.preco * produto.quantidade_vendida
        end
        return total_vendas
    end

    # Método para encontrar o produto mais vendido (em quantidade)
    function encontrar_produto_mais_vendido(self::GerenciadorDeVendas)
        if isempty(self.produtos)
            return nothing
        end
        
        produto_mais_vendido = self.produtos[1]
        max_quantidade = self.produtos[1].quantidade_vendida

        for i = 2:length(self.produtos)
            produto_atual = self.produtos[i]
            if produto_atual.quantidade_vendida > max_quantidade
                max_quantidade = produto_atual.quantidade_vendida
                produto_mais_vendido = produto_atual
            end
        end
        return produto_mais_vendido
    end

    # Método para encontrar o produto com maior receita
    function encontrar_produto_maior_receita(self::GerenciadorDeVendas)
        if isempty(self.produtos)
            return nothing
        end

        produto_maior_receita = self.produtos[1]
        max_receita = self.produtos[1].preco * self.produtos[1].quantidade_vendida

        for i = 2:length(self.produtos)
            produto_atual = self.produtos[i]
            receita_atual = produto_atual.preco * produto_atual.quantidade_vendida
            if receita_atual > max_receita
                max_receita = receita_atual
                produto_maior_receita = produto_atual
            end
        end
        return produto_maior_receita
    end

    # Método para listar produtos por categoria
    function listar_produtos_por_categoria(self::GerenciadorDeVendas, categoria_alvo::String)
        produtos_na_categoria = Produto[] # Lista vazia para produtos encontrados
        
        for produto in self.produtos
            # Usa 'lowercase' para comparação de categoria sem diferenciar maiúsculas/minúsculas
            if lowercase(produto.categoria) == lowercase(categoria_alvo)
                push!(produtos_na_categoria, produto)
            end
        end
        return produtos_na_categoria
    end

end # Fim da definição da classe GerenciadorDeVendas

println("--- Iniciando o Sistema de Análise de Vendas POO ---")

# --- 1. Criação de Objetos Produto ---
println("\nCriando objetos Produto...")
produto1 = Produto("Camiseta Basic", "Vestuário", 29.90, 150)
produto2 = Produto("Calça Jeans Slim", "Vestuário", 89.90, 80)
produto3 = Produto("Fone de Ouvido XP", "Eletrônicos", 150.00, 40)
produto4 = Produto("Mouse Gamer Pro", "Eletrônicos", 120.00, 60)
produto5 = Produto("Copo Térmico 500ml", "Casa e Cozinha", 45.00, 200)
produto6 = Produto("Livro Julia Essencial", "Livros", 75.00, 30)

# Demonstração de validação no construtor
produto_erro_preco = Produto("Produto Errado", "Teste", -10.00, 5) # Deverá emitir um aviso

# --- 2. Criação do Objeto GerenciadorDeVendas ---
println("\nCriando o objeto GerenciadorDeVendas...")
gerenciador = GerenciadorDeVendas()

# --- 3. Adicionando Produtos ao Gerenciador usando o método ---
println("\nAdicionando produtos ao gerenciador...")
gerenciador.adicionar_produto_a_gerenciador!(gerenciador, produto1)
gerenciador.adicionar_produto_a_gerenciador!(gerenciador, produto2)
gerenciador.adicionar_produto_a_gerenciador!(gerenciador, produto3)
gerenciador.adicionar_produto_a_gerenciador!(gerenciador, produto4)
gerenciador.adicionar_produto_a_gerenciador!(gerenciador, produto5)
gerenciador.adicionar_produto_a_gerenciador!(gerenciador, produto6)
gerenciador.adicionar_produto_a_gerenciador!(gerenciador, produto_erro_preco) # Adicionando o produto com aviso

# --- 4. Realizando Análises Usando os Métodos do Gerenciador ---
println("\n--- Realizando Análises de Vendas ---")

# a) Valor Total de Vendas
total_vendas_geral = gerenciador.calcular_valor_total_vendas(gerenciador)
println("Valor Total Geral de Vendas: R\$ $(round(total_vendas_geral, digits=2))")

# b) Produto Mais Vendido (por quantidade)
mais_vendido_obj = gerenciador.encontrar_produto_mais_vendido(gerenciador)
if mais_vendido_obj !== nothing
    println("Produto Mais Vendido (Quantidade): $(mais_vendido_obj.nome) (Vendidos: $(mais_vendido_obj.quantidade_vendida))")
else
    println("Nenhum produto encontrado para análise de mais vendido.")
end

# c) Produto com Maior Receita
maior_receita_obj = gerenciador.encontrar_produto_maior_receita(gerenciador)
if maior_receita_obj !== nothing
    receita_desse_produto = maior_receita_obj.preco * maior_receita_obj.quantidade_vendida
    println("Produto com Maior Receita: $(maior_receita_obj.nome) (Receita: R\$ $(round(receita_desse_produto, digits=2)))")
else
    println("Nenhum produto encontrado para análise de maior receita.")
end

# d) Listar Produtos por Categoria (com interação e loop)
println("\n--- Consulta por Categoria ---")
consultar_categoria = true
while consultar_categoria
    print("Digite a categoria para listar produtos (ou 'sair' para finalizar): ")
    categoria_pesquisa = readline()

    if lowercase(categoria_pesquisa) == "sair"
        println("Finalizando consulta por categoria.")
        consultar_categoria = false
        break
    end

    produtos_encontrados = gerenciador.listar_produtos_por_categoria(gerenciador, categoria_pesquisa)
    
    if isempty(produtos_encontrados) # Usando if/else
        println("Nenhum produto encontrado na categoria '$categoria_pesquisa'.")
    else
        println("Produtos na categoria '$categoria_pesquisa':")
        for produto_na_lista in produtos_encontrados # Usando for
            println("- $(produto_na_lista.nome) (Preço: R\$ $(produto_na_lista.preco), Vendidos: $(produto_na_lista.quantidade_vendida))")
        end
    end
end

println("\n--- Fim do Sistema de Análise de Vendas POO ---")