require 'active_support/all'
require_relative 'infinity_extensions'

class PreencherPeriodo
  def executar!(situacoes)
    return unless situacoes.present?

    data_situacao_anterior = nil

    situacoes.each_with_index do |situacao, index|
      next_situacao =  (index + 1) < situacoes.size ? situacoes[index+1] : nil

      periodo_inicial = existe_a_partir_de?(situacao) ? situacao[:a_partir_de].to_date : (data_situacao_anterior ? data_situacao_anterior : -Float::INFINITY)
      periodo_final =  existe_a_partir_de?(next_situacao) ? next_situacao[:a_partir_de].to_date : Float::INFINITY

      data_situacao_anterior = periodo_final
      situacoes[index].merge!(periodo: (periodo_inicial...periodo_final))
    end
  end

  private

  def existe_a_partir_de?(situacao)
    situacao && situacao[:a_partir_de]
  end
end