module Genetica
  class Population < Array
    attr_reader   :generation, :population_fitness
    attr_accessor :alleles, :elitism, :crossover_method, :crossover_probability, :mutation_probability

    def initialize(population)
      super population

      @generation = 0
    end

    def fitness
      raise NotImplementedError, "Your class should implement #{__method__} class method"
    end

    def best_chromosome
      @best_chromosome ||= at(population_fitness.index(best_fitness))
    end

    def best_chromosomes(quantity = 1)
      @best_chromosomes ||= best_fitnesses(quantity).map do |fitness|
        at population_fitness.index(fitness)
      end
    end

    def best_fitness
      @best_fitness ||= population_fitness.max
    end

    def best_fitnesses(quantity = 1)
      @best_fitnesses ||= population_fitness.sort.reverse.first(quantity)
    end

    def average_fitness
      @average_fitness ||= population_fitness.inject(:+) / population_fitness.size.to_f
    end

    def population_fitness
      @population_fitness ||= map { |chromosome| fitness(chromosome) }
    end

    def run(generations = 1)
      generations.times do
        # Generate a new chromosome population
        population = Array.new

        # If elitism if greater than 0 then we save the same number of chromosomes to the next generation
        population += best_chromosomes(quantity = elitism) if elitism > 0

        while population.size < size
          # 1. Selection Step
          # Select a pair of parent chromosomes from the current population.
          # This selection is 'with replacement', the same chromosome can be selected
          # more than once to become a parent.
          chromosome_a = fitness_proportionate_selection
          chromosome_b = fitness_proportionate_selection

          # 2. Crossover Step
          offspring_a, offspring_b = chromosome_a.crossover(crossover_method, crossover_probability,
            chromosome_b)

          # 3. Mutation Step
          offspring_a.mutate!(mutation_probability, alleles)
          offspring_b.mutate!(mutation_probability, alleles)

          # 4. Adding offsprings to new chromosome population
          population << offspring_a << offspring_b
        end

        # If original population size is odd discard a random chromosome
        population.delete_at rand population.size if size.odd?

        # Replacing chromosome population with the new one
        replace population

        # A new generation has been created
        @generation += 1
      end
    end

    private

    def fitness_proportionate_selection
      random_number = rand 0.0..population_fitness.inject(:+)

      # Chromosome selection
      fitness_counter = 0
      each_with_index do |chromosome, i|
        fitness_counter += population_fitness[i]
        return chromosome if fitness_counter >= random_number
      end
    end

    def replace(other_ary)
      super other_ary

      reset_memoizes
    end

    def reset_memoizes
      @population_fitness = nil
      @average_fitness = nil
      @best_fitnesses = nil
      @best_fitness = nil
      @best_chromosomes = nil
      @best_chromosome = nil
    end
  end
end
