module Genetica
  class Population

    attr_writer :crossover_probability
    attr_writer :mutation_probability
    attr_writer :fitness_function

    def initialize(chromosome_population)
      @chromosome_population = chromosome_population
    end

    # Estaría bien que la fitness function pueda establecerse como population_builder.fitness_function = method(:nombre_fitness_function)
    # y también definirla como un bloque o Proc (mirar PickAxe)
    def fitness_proportionate_selection
      # Get list of chromosome fitness
      chromosome_fitness = Array.new
      @chromosome_population.each { |chromosome| chromosome_fitness << @fitness_function.call(chromosome) }
      puts chromosome_fitness
      
      random_generator = Random.new
      random_number = random_generator.rand 0.0..(chromosome_fitness.inject(:+))
    end

  end
end
