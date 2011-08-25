module Genetica
  class ChromosomeBuilder

    attr_writer :length
    attr_writer :alleles

    def initialize
      # Default Chromosome values
      @length = 8
      @alleles = [0, 1]
    end
    
    def generate
      chromosome = Array.new
      @length.times { chromosome << @alleles.sample }
      return Chromosome.new(chromosome)
    end

  end
end
