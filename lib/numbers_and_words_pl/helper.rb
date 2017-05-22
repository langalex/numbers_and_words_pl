module NumbersAndWordsPl
  module Helper
    PL_NUMBERS = YAML.parse(File.read(File.dirname(__FILE__) + '/pl.yml')).to_ruby['numbers']

    def to_words_pl(integer)
      case integer
      when 0..9
        PL_NUMBERS['ones'][integer]
      when 10..19
        PL_NUMBERS['teens'][integer - 10]
      when 20..99
        tens, ones = integer.to_s.split('').map(&:to_i)
        "#{PL_NUMBERS['tens'][tens]} #{PL_NUMBERS['ones'][ones] if ones > 0}".strip
      when 100..999
        hundreds = integer.to_s[0].to_i - 1
        rest = integer.to_s[1..-1].to_i
        "#{PL_NUMBERS['hundreds'][hundreds]} #{to_words_pl rest if rest > 0}".strip
      when 1_000..999_999
        thousands = integer.to_s[0..-4].to_i
        one_few_many = thousands < 5 ? (thousands == 1 ? 'one' : 'few') : 'many'
        rest = integer.to_s[-3..-1].to_i
        "#{to_words_pl thousands} #{PL_NUMBERS['thousands'][one_few_many]} #{to_words_pl rest if rest > 0}".strip
      else
        fail "number #{integer} not supported"
      end
    end
  end
end
