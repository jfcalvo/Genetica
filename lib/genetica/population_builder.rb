module Genetica
  class PopulationBuilder
    class PopulationClassError < StandardError; end

    # Population attributes
    attr_accessor :size, :elitism, :crossover_method, :crossover_probability, :mutation_probability,
      :population_class

    # Chromosome attributes
    attr_accessor :chromosome_length, :chromosome_alleles

    def initialize
      set_default_population_attributes
      set_default_chromosome_attributes
    end

    def population
      raise PopulationClassError, 'You must assign a population class' if population_class.nil?

      population_class.new(chromosome_population).tap do |population|
        population.alleles = chromosome_alleles
        population.elitism = elitism
        population.crossover_method = crossover_method
        population.crossover_probability = crossover_probability
        population.mutation_probability = mutation_probability
      end
    end

    private

    def set_default_population_attributes
      @size = 20
      @elitism = 0
      @crossover_method = :uniform_crossover
      @crossover_probability = 0.7
      @mutation_probability = 0.001
      @population_class = nil
    end

    def set_default_chromosome_attributes
      @chromosome_length = 8
      @chromosome_alleles = [0, 1]
    end

    def chromosome_population
      Array.new.tap do |chromosome_population|
        size.times { chromosome_population << chromosome_builder.chromosome }
      end
    end

    def chromosome_builder
      ChromosomeBuilder.new.tap do |chromosome_builder|
        chromosome_builder.length = chromosome_length
        chromosome_builder.alleles = chromosome_alleles
      end
    end
  end
end
