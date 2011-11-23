#!/usr/bin/env ruby
#
# A small example on how to use the genetica Ruby gem.
#

require 'genetica'


if ARGV.size == 0
  puts "error: Expected a string as parameter."
  puts "example: #{$PROGRAM_NAME} genetica"
  exit
end

# Get the word to be used in the fitness function to measure distance
WORD = ARGV[0]
WORD_BEST_DISTANCE = WORD.size

# All the alleles that the chromosome can use
CHROMOSOME_ALLELES = ('a'..'z').to_a | ('A'..'Z').to_a | WORD.chars.to_a | [' ']

# Our fitness function
def word_distance(chromosome)
  (0...WORD.size).inject(0) { |distance, index|  WORD[index] == chromosome.chromosome[index] ? distance += 1 : distance }  
end

# Creating a new Population Builder
population_builder = Genetica::PopulationBuilder.new
# Setting Population Builder
population_builder.size = 100                                # Population Size
population_builder.elitism = 5                               # Activating elitism in population selection
population_builder.crossover_probability = 0.7               # Crossover rate
population_builder.mutation_probability = 0.01               # Mutation rate
population_builder.chromosome_length = WORD.size             # Chromosome length
population_builder.chromosome_alleles = CHROMOSOME_ALLELES   # Chromosome alleles
population_builder.fitness_function = method(:word_distance) # Fitness Function

# Get population
population = population_builder.population

while population.best_fitness < WORD_BEST_DISTANCE
  population.run generations=1
  puts "#{population.best_chromosome}, generation: #{population.generation}, distance: #{population.best_fitness}"
end

# Show some statistics
puts "Solution at generation: #{population.generation}."
