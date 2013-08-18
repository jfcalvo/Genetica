module Genetica
  class ChromosomeBuilder
    attr_accessor :length
    attr_accessor :alleles

    def initialize
      set_default_chromosome_attributes
    end

    def chromosome
      Chromosome.new.tap do |chromosome|
        length.times { chromosome << alleles.sample }
      end
    end

    private

    def set_default_chromosome_attributes
      self.length = 8
      self.alleles = [0, 1]
    end
  end
end
