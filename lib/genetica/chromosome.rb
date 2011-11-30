module Genetica
  class Chromosome < Array
  
    # TODO: Add conts with the name of the crossover method to call    

    def crossover(crossover_method, crossover_probability, chromosome)
      if crossover_probability > 0 and rand.between? 0, crossover_probability
        return self.send(crossover_method, crossover_probability, chromosome)
      end

      # There is no crossover, return chromosomes without changes
      return self, chromosome
    end

    def single_point_crossover(crossover_probability, chromosome)  
      locus = rand(chromosome.size) + 1

      offspring_a = self.take(locus) + chromosome.last(self.size - locus)
      offspring_b = chromosome.take(locus) + self.last(self.size - locus)

      return Chromosome.new(offspring_a), Chromosome.new(offspring_b)
    end

    def uniform_crossover(crossover_probability, chromosome)
      offspring_a, offspring_b = Array.new, Array.new

      chromosome.size.times do |i|
        if rand(2) == 0
          offspring_a << self[i]
          offspring_b << chromosome[i]
        else
          offspring_a << chromosome[i]
          offspring_b << self[i]
        end
      end

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
