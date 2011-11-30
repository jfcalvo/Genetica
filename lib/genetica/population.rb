module Genetica
  class Population < Array

    attr_reader   :generation
    attr_accessor :alleles
    attr_accessor :elitism
    attr_accessor :crossover_probability
    attr_accessor :mutation_probability

    def initialize(population)
      super population
      @generation = 0
      @population_fitness = self.population_fitness
    end

    def best_chromosome
      self.at @population_fitness.index(self.best_fitness)
    end

    def best_chromosomes(quantity=1)
      self.best_fitnesses(quantity).collect { |fitness| self.at(@population_fitness.index fitness) }     
    end

    def best_fitness
      @population_fitness.max
    end

    def best_fitnesses(quantity=1)
      @population_fitness.sort.reverse.take(quantity)      
    end    

    def average_fitness
      @population_fitness.inject(:+) / @population_fitness.size.to_f
    end

    def population_fitness
      self.collect { |chromosome| self.fitness(chromosome) }
    end

    def replace(other_ary)
      super other_ary
      @population_fitness = self.population_fitness
    end

    def fitness_proportionate_selection
      random_number = rand 0.0..@population_fitness.inject(:+)

      # Chromosome selection
      fitness_counter = 0
      self.each_with_index do |chromosome, i|
        fitness_counter += @population_fitness[i]
        if fitness_counter >= random_number
          return chromosome
        end
      end
    end

    def run(generations=1)
      generations.times do
        # Generate a new chromosome population
        population = Array.new

        # If elitism if greater than 0 then we save the same number of chromosomes to the next generation
        population += self.best_chromosomes(quantity=@elitism) if @elitism > 0

        while population.size < self.size
          # 1. Selection Step
          # Select a pair of parent chromosomes from the current population.
          # This selection is 'with replacement', the same chromosome can be selected
          # more than once to become a parent.
          chromosome_a = self.fitness_proportionate_selection
          chromosome_b = self.fitness_proportionate_selection

          # 2. Crossover Step
          offspring_a, offspring_b = chromosome_a.single_point_crossover @crossover_probability, chromosome_b

          # 3. Mutation Step
          offspring_a.mutate! @mutation_probability, @alleles
          offspring_b.mutate! @mutation_probability, @alleles

          # 4. Adding offsprings to new chromosome population
          population << offspring_a << offspring_b          
        end

        # If original population size is odd discard a random chromosome
        population.delete_at rand population.size if self.size.odd?

        # Replacing chromosome population with the new one
        self.replace population

        # A new generation has been created
        @generation += 1
      end
    end

  end
end
