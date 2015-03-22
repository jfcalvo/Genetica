#!/usr/bin/env ruby

require 'genetica'

class WordPopulation < Genetica::Population
  def fitness(chromosome)
    (0...WORD.size).inject(0) { |distance, index| WORD[index] == chromosome[index] ? distance += 1 : distance }
  end

  def run
    while best_fitness < WORD.size
      super generations = 1
      puts "#{best_chromosome}, generation: #{generation}, distance: #{best_fitness}"
    end

    puts "Solution found at generation: #{generation}."
  end
end

if ARGV.size == 0
  puts 'error: Expected a string as parameter.'
  puts "example: #{$PROGRAM_NAME} genetica"
  exit
end

# Get the string parameter
WORD = ARGV[0]

# Creating a new Population Builder
population_builder = Genetica::PopulationBuilder.new
# Setting Population Builder
population_builder.population_class = WordPopulation     # Set the class of the Population to build
population_builder.size = 500                            # Population Size
population_builder.elitism = 1                           # Activating elitism in population selection
population_builder.crossover_method = :uniform_crossover # Selecting the method to crossover chromosomes
population_builder.crossover_probability = 0.4           # Crossover rate
population_builder.mutation_probability = 0.001          # Mutation rate
population_builder.chromosome_length = WORD.size         # Chromosome length
population_builder.chromosome_alleles = ('a'..'z').to_a | ('A'..'Z').to_a | WORD.chars.to_a | [' '] # Chromosome alleles
# Get population, set the referential word and run
population = population_builder.population
population.run
