#!/usr/bin/env ruby

require 'genetica'

WORD = "genetica"

# Creating a new Population Builder
population_builder = Genetica::PopulationBuilder.new

# Our fitness function
def word_distance(chromosome)
  (0...WORD.size).inject(0) { |distance, index|  WORD[index] == chromosome.chromosome[index] ? distance += 1 : distance }  
end

# Setting Population Builder
population_builder.size = 100                                # Population Size
population_builder.elitism = 10                              # Activating elitism in population selection
population_builder.crossover_probability = 0.7               # Crossover rate
population_builder.mutation_probability = 0.05               # Mutation rate
population_builder.chromosome_length = WORD.size             # Chromosome length
population_builder.chromosome_alleles = ('a'..'z').to_a      # Chromosome alleles
population_builder.fitness_function = method(:word_distance) # Fitness Function

# Get population
population = population_builder.population

while population.best_fitness < 8
  population.run generations=1
  puts "#{population.best_chromosome}, distance: #{population.best_fitness}"
end

# Show some statistics
puts "Solution at generation: #{population.generation}."
