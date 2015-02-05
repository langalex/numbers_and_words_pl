$LOAD_PATH << File.dirname(__FILE__) + '../lib'
require 'numbers_and_words_pl'
require 'yaml'

describe NumbersAndWordsPl::Helper do
  include NumbersAndWordsPl::Helper
  fixtures = YAML.parse(File.read(File.dirname(__FILE__) + '/pl.yml')).to_ruby['to_words']

  fixtures.each do |group, numbers|
    context "with #{group}" do
      numbers.each do |number, word|
        it "translates #{number}" do
          expect(to_words_pl(number)).to eql(word)
        end
      end
    end
  end
end
