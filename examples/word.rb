require 'genetica'
require 'text' # To calculate Levenshtein distance

# Creating a new Population Builder
population_builder = Genetica::PopulationBuilder.new

# Our fitness function
def distance(chromosome)
  levenshtein_distance = Text::Levenshtein.distance("genetica", chromosome.chromosome.join)
  if levenshtein_distance == 0
    return 2
  else
    return 1 / levenshtein_distance.to_f
  end
end

# Setting Population Builder
population_builder.size = 100                           # Population Size
population_builder.crossover_probability = 0.7          # Crossover rate
population_builder.mutation_probability = 0.001         # Mutation rate
population_builder.chromosome_length = 8                # Chromosome length
population_builder.chromosome_alleles = ('a'..'z').to_a # Chromosome alleles
population_builder.fitness_function = method(:distance) # Fitness Function

# Get population
population = population_builder.population

while population.best_fitness < 2
  population.run generations=1
  puts population.best_chromosome
end

# Show some statistics
puts "Solution at generation: #{population.generation}."
