module Genetica
  class PopulationBuilder

    # Population attributes
    attr_accessor :size
    attr_accessor :elitism
    attr_accessor :crossover_probability
    attr_accessor :mutation_probability
    attr_accessor :fitness_function
    # Chromosome attributes
    attr_accessor :chromosome_length
    attr_accessor :chromosome_alleles

    def initialize
      # Default Population values
      @size = 20
      @elitism = 0
      @crossover_probability = 0.7
      @mutation_probability = 0.001
      @fitness_function = nil
      # Default Chromosome values
      @chromosome_length = 8
      @chromosome_alleles = [0, 1]
    end

    def population
      # Generating Chromosome population
      chromosome_builder = ChromosomeBuilder.new
      chromosome_builder.length = @chromosome_length
      chromosome_builder.alleles = @chromosome_alleles

      chromosome_population = Array.new
      @size.times { chromosome_population << chromosome_builder.chromosome }

      # Generating Population 
      population = Population.new chromosome_population
      population.alleles = @chromosome_alleles
      population.elitism = @elitism
      population.crossover_probability = @crossover_probability
      population.mutation_probability = @mutation_probability
      population.fitness_function = @fitness_function
      
      return population
    end

  end
end
