module Genetica
  class Population

    attr_reader :population
    attr_reader :generation

    attr_accessor :alleles
    attr_accessor :elitism
    attr_accessor :crossover_probability
    attr_accessor :mutation_probability
    attr_accessor :fitness_function

    def initialize(population)
      @generation = 0
      @population = population
    end

    def best_chromosome(quantity=1)
      if quantity > 1
        return self.best_fitness(quantity).collect { |fitness| @population.at(@population_fitness.index fitness) }
      end
      @population.at @population_fitness.index(self.best_fitness)      
    end

    def best_fitness(quantity=1)
      if quantity > 1
        return @population_fitness.sort.reverse.take(quantity)
      end
      @population_fitness.max
    end

    def average_fitness
      @population_fitness.inject(:+) / @population_fitness.size.to_f
    end

    def population_fitness
      @population.collect { |chromosome| @fitness_function.call(chromosome) }
    end

    def fitness_function=(new_fitness_function)
      @fitness_function = new_fitness_function
      @population_fitness = self.population_fitness
    end

    def population=(new_population)
      @population = new_population
      @population_fitness = self.population_fitness
    end

    def fitness_proportionate_selection
      # FUTURE: With Ruby 1.9.3 you can use rand with ranges, e.g. rand 0.0..3.4
      # Get random number
      random_generator = Random.new
      random_number = random_generator.rand 0.0..@population_fitness.inject(:+)

      # Chromosome selection
      fitness_counter = 0
      @population.each_with_index do |chromosome, i|
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
        population += [self.best_chromosome(quantity=@elitism)].flatten if @elitism > 0

        while population.size < @population.size
          # 1. Selection Step
          # Select a pair of parent chromosomes from the current population.
          # This selection is 'with replacement', the same chromosome can be selected
          # more than once to become a parent.
          chromosome_a = self.fitness_proportionate_selection
          chromosome_b = self.fitness_proportionate_selection

          # 2. Crossover Step
          # TODO: Maybe crossover probability check would be in the single_point_crossover of
          # Chromosome class.
          if @crossover_probability > 0 and rand.between? 0, @crossover_probability
            offspring_a, offspring_b = chromosome_a.single_point_crossover chromosome_b
          else
            offspring_a, offspring_b = chromosome_a, chromosome_b
          end

          # 3. Mutation Step
          offspring_a.mutate! @mutation_probability, @alleles
          offspring_b.mutate! @mutation_probability, @alleles

          # 4. Adding offsprings to new chromosome population
          population << offspring_a << offspring_b          
        end

        # If original population size is odd discard a random chromosome
        population.delete_at rand population.size if @population.size.odd?

        # Replacing chromosome population with the new one
        self.population = population

        # A new generation has been created
        @generation += 1
      end
    end

  end
end
