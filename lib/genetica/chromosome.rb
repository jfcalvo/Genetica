module Genetica
  class Chromosome < Array

    def single_point_crossover(chromosome)
      locus = rand(chromosome.size) + 1

      offspring_a = self.take(locus) + chromosome.last(self.size - locus)
      offspring_b = chromosome.take(locus) + self.last(self.size - locus)

      return Chromosome.new(offspring_a), Chromosome.new(offspring_b)
    end

    def mutate!(mutation_probability, alleles)
      if mutation_probability > 0
        self.collect! do |gene|
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
      self.join
    end

  end
end
