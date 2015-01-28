require_relative '../preencher_periodo.rb'

describe PreencherPeriodo do
  it 'quando tiver apenas uma situação sem data' do
    situacoes = [{a_partir_de: nil}]
    PreencherPeriodo.new.executar!(situacoes)

    situacao = situacoes.first[:periodo]
    expect(situacao).to cover('1500-04-21'.to_date)
    expect(situacao).to cover('2200-01-01'.to_date)#infinity
  end

  it 'quando tiver apenas uma situação com data' do
    data_unica_situacao = '2014-02-20'
    situacoes = [{a_partir_de: data_unica_situacao}]
    PreencherPeriodo.new.executar!(situacoes)

    situacao = situacoes.first[:periodo]
    expect(situacao).not_to cover(data_unica_situacao.to_date - 1.day)
    expect(situacao).to cover(data_unica_situacao.to_date)
    expect(situacao).to cover('2200-01-01'.to_date)
  end

  it 'quando tiver duas situações, primeira sem data e segunda com data' do
    data_segunda_situacao = '2014-02-20'
    situacoes = [{a_partir_de: nil}, {a_partir_de: data_segunda_situacao}]
    PreencherPeriodo.new.executar!(situacoes)

    primeira_situacao = situacoes.first[:periodo]
    expect(primeira_situacao).to cover('1500-04-21'.to_date)
    expect(primeira_situacao).to cover(data_segunda_situacao.to_date - 1.day)
    expect(primeira_situacao).not_to cover(data_segunda_situacao.to_date)

    segunda_situacao = situacoes[1][:periodo]
    expect(segunda_situacao).to cover(data_segunda_situacao.to_date)
    expect(segunda_situacao).to cover('2200-01-01'.to_date)
    expect(segunda_situacao).not_to cover(data_segunda_situacao.to_date - 1.day)
  end

  it 'quando tiver duas situações, primeira e segunda com data' do
    data_primeira_situacao = '2014-02-20'
    data_segunda_situacao = '2014-05-06'

    situacoes = [{a_partir_de: data_primeira_situacao}, {a_partir_de: data_segunda_situacao}]
    PreencherPeriodo.new.executar!(situacoes)

    primeira_situacao = situacoes.first[:periodo]
    expect(primeira_situacao).to cover(data_primeira_situacao.to_date)
    expect(primeira_situacao).to cover(data_segunda_situacao.to_date - 1.day)
    expect(primeira_situacao).not_to cover(data_primeira_situacao.to_date - 1.day)
    expect(primeira_situacao).not_to cover(data_segunda_situacao.to_date)

    segunda_situacao = situacoes[1][:periodo]
    expect(segunda_situacao).to cover(data_segunda_situacao.to_date)
    expect(segunda_situacao).to cover('2200-01-01'.to_date)
    expect(segunda_situacao).not_to cover(data_segunda_situacao.to_date - 1.day)
  end

  it 'quando tiver três situações com data' do
    data_primeira_situacao = '2014-02-20'
    data_segunda_situacao = '2014-05-06'
    data_terceira_situacao = '2014-08-16'

    situacoes = [{a_partir_de: data_primeira_situacao}, {a_partir_de: data_segunda_situacao}, {a_partir_de: data_terceira_situacao}]
    PreencherPeriodo.new.executar!(situacoes)

    primeira_situacao = situacoes.first[:periodo]
    expect(primeira_situacao).to cover(data_primeira_situacao.to_date)
    expect(primeira_situacao).to cover(data_segunda_situacao.to_date - 1.day)
    expect(primeira_situacao).not_to cover(data_primeira_situacao.to_date - 1.day)
    expect(primeira_situacao).not_to cover(data_segunda_situacao.to_date)

    segunda_situacao = situacoes[1][:periodo]
    expect(segunda_situacao).to cover(data_segunda_situacao.to_date)
    expect(segunda_situacao).to cover(data_terceira_situacao.to_date - 1.day)
    expect(segunda_situacao).not_to cover(data_segunda_situacao.to_date - 1.day)

    terceira_situacao = situacoes[2][:periodo]
    expect(terceira_situacao).to cover(data_terceira_situacao.to_date)
    expect(terceira_situacao).to cover('2200-01-01'.to_date)
    expect(terceira_situacao).not_to cover(data_terceira_situacao.to_date - 1.day)
  end

  it 'quando tiver três situações mas a primeira sem data' do
    data_primeira_situacao = nil
    data_segunda_situacao = '2014-05-06'
    data_terceira_situacao = '2014-08-16'

    situacoes = [{a_partir_de: data_primeira_situacao}, {a_partir_de: data_segunda_situacao}, {a_partir_de: data_terceira_situacao}]
    PreencherPeriodo.new.executar!(situacoes)

    primeira_situacao = situacoes.first[:periodo]
    expect(primeira_situacao).to cover('1500-04-21'.to_date)
    expect(primeira_situacao).to cover(data_segunda_situacao.to_date - 1.day)

    segunda_situacao = situacoes[1][:periodo]
    expect(segunda_situacao).to cover(data_segunda_situacao.to_date)
    expect(segunda_situacao).to cover(data_terceira_situacao.to_date - 1.day)
    expect(segunda_situacao).not_to cover(data_segunda_situacao.to_date - 1.day)

    terceira_situacao = situacoes[2][:periodo]
    expect(terceira_situacao).to cover(data_terceira_situacao.to_date)
    expect(terceira_situacao).to cover('2200-01-01'.to_date)
    expect(terceira_situacao).not_to cover(data_segunda_situacao.to_date - 1.day)
  end


end