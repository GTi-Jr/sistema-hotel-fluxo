module TransactionHelper
  class << self
  	#Verificar se o produto não tem um preço definido
  	#Exemplo: hospedagem
  	#Se não tiver um preço: pegar o preço da tabela de transações e dividir pela quantidade
  	#Objetivo: obter o preço unitário de produtos que não tem um valor definido
    def priceNull(priceUnit,priceTotal,quantity)
      if priceUnit.nil?
      	priceTotal / quantity
      else
      	priceUnit
      end
	end
  end
end
