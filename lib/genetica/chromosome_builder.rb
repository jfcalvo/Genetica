module Genetica
  class ChromosomeBuilder

    attr_accessor :length
    attr_accessor :alleles

    def initialize
      # Default Chromosome values
      @length = 8
      @alleles = [0, 1]
    end
    
    def chromosome
      chromosome = Array.new
      @length.times { chromosome << @alleles.sample }
      return Chromosome.new(chromosome)
    end

  end
end
