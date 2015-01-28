# Necessario para contruir um range de -infinity até uma data. Exemplo:
#
# -::Float::INFINITY..Date.today
# ArgumentError: bad value for range
#
# Isso ocorre porque o operador "<=>" do Float não foi implementado para trabalhdar com o Date.
# -::Float::INFINITY <=> Date.today retorna nil!!!!
class Float
  alias_method :_old_comparator, :"<=>"
  def <=>(other)
    if other.is_a? Date
      (other <=> self) * -1
    else
      _old_comparator other
    end
  end
end