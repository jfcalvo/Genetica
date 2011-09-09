module Genetica
  class Chromosome

    attr_reader :chromosome

    def initialize(chromosome)
      @chromosome = chromosome
    end

    def single_point_crossover(chromosome)
      other_chromosome = chromosome.chromosome
      locus = rand(other_chromosome.size) + 1

      offspring_a = @chromosome.take(locus) + other_chromosome.last(@chromosome.size - locus)
      offspring_b = other_chromosome.take(locus) + @chromosome.last(@chromosome.size - locus)

      return Chromosome.new(offspring_a), Chromosome.new(offspring_b)
    end

    def mutate!(mutation_probability, alleles)
      if mutation_probability > 0
        @chromosome.collect! do |gene|
          if rand.between? 0, mutation_probability
            # Mutated Gene, we select a different gene from the alleles
            (alleles - [gene]).sample
          else
            # Gene without mutation
            gene
          end
        end
      end
    end

    def to_s
      return @chromosome.join
    end

  end
end

