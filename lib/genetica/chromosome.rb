module Genetica
  class Chromosome < Array

    def single_point_crossover(crossover_probability, chromosome)
      if crossover_probability > 0 and rand.between? 0, crossover_probability
        locus = rand(chromosome.size) + 1

        offspring_a = self.take(locus) + chromosome.last(self.size - locus)
        offspring_b = chromosome.take(locus) + self.last(self.size - locus)

        return Chromosome.new(offspring_a), Chromosome.new(offspring_b)
      end

      # There is no crossover, return chromosomes without changes
      return self, chromosome
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
