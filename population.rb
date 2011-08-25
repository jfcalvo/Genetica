module Genetica
  class Population

    attr_writer :crossover_probability
    attr_writer :mutation_probability
    attr_writer :fitness_function

    def initialize(chromosome_population)
      @chromosome_population = chromosome_population
    end

  end
end
