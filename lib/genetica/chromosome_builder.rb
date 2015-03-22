module Genetica
  class ChromosomeBuilder
    attr_accessor :length, :alleles

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
      @length = 8
      @alleles = [0, 1]
    end
  end
end
