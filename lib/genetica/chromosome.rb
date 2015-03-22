module Genetica
  class Chromosome < Array
    def crossover(crossover_method, crossover_probability, chromosome)
      if crossover_probability > 0 && rand.between?(0, crossover_probability)
        self.send(crossover_method, crossover_probability, chromosome)
      else
        # There is no crossover, return chromosomes without changes
        return self, chromosome
      end
    end

    def single_point_crossover(crossover_probability, chromosome)
      locus = rand(chromosome.size) + 1

      offspring_a = take(locus) + chromosome.last(size - locus)
      offspring_b = chromosome.take(locus) + last(size - locus)

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
        map! do |gene|
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
      join
    end
  end
end
