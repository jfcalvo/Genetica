module Genetica
  class Population

    attr_accessor :crossover_probability
    attr_accessor :mutation_probability
    attr_accessor :fitness_function

    def initialize(chromosome_population)
      @chromosome_population = chromosome_population
    end

    # Estaría bien que la fitness function pueda establecerse como population_builder.fitness_function = method(:nombre_fitness_function)
    # y también definirla como un bloque o Proc (mirar PickAxe)
    def fitness_proportionate_selection
      # Get an array with chromosome fitness      
      chromosome_fitness = @chromosome_population.collect { |chromosome| @fitness_function.call(chromosome) }
      
      # FUTURE: With the future 1.9.3 version of Ruby we could change the next random 
      # generator for something like:
      # rand 0.0..(chromosome_fitness.inject(:+))
      random_generator = Random.new
      random_number = random_generator.rand 0.0..chromosome_fitness.inject(:+)

      puts "Random number #{random_number}"

      # Chromosome selection
      fitness_counter = 0
      chromosome_fitness.each_with_index do |fitness, i|
        fitness_counter += fitness
        puts "Fitness counter #{fitness_counter}"        
        if fitness_counter >= random_number
          puts "Chromosome #{i} with fitness #{chromosome_fitness[i]}"
          return @chromosome_population[i]
        end
      end
    end

  end
end
