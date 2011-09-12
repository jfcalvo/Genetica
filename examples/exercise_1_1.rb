#
# This exercise is extracted from the book: "An Introduction to Genetic Algorithms"
# by Melanie Mitchell. Used with permission of Melanie Mitchell.
#
# Chapter 1, Exercise 1:
# Implement a simple GA with fitness−proportionate selection, roulettewheel sampling,
# population size 100, single−point crossover rate pc = 0.7, and bitwise mutation rate 
# pm = 0.001. Try it on the following fitness function: ƒ(x) = number of ones in x, 
# where x is a chromosome of length 20. Perform 20 runs, and measure the average 
# generation at which the string of all ones is discovered. Perform the same experiment 
# with crossover turned off (i.e., pc = 0). Do similar experiments, varying the mutation 
# and crossover rates, to see how the variations affect the average time required for the 
# GA to find the optimal string. If it turns out that mutation with crossover is better 
# than mutation alone, why is that the case?.
#

require 'genetica'


# Run code function for the exercise
def exercise_run(population_builder, runs)
  # An array with the number of generations necessary by every population
  # to discover the chromosome of all ones
  generations_discovered = Array.new

  # Runs
  print "Running"
  runs.times do
    # Generating a new Population
    population = population_builder.population

    fitness = 0
    while fitness < population_builder.chromosome_length
      # Perform a run of one generation
      population.run generations=1 
      # Get the best fitness of this run
      fitness = population.best_fitness
    end

    # Saving at which generation the chromosome of all ones is discovered
    generations_discovered << population.generation

    # Showing to screen that a new run has been executed
    print "."
  end

  # Showing the average generation at which the chromosome of all ones was
  # discovered
  puts "\nCalculating average generation..."
  average_generation = generations_discovered.inject(:+) / generations_discovered.size.to_f
  puts "Average generation to discover chromosome of all ones (for #{runs} runs): #{average_generation}."
end


# Creating the fitness function
def number_of_ones(chromosome)
  return chromosome.chromosome.count 1 # Number of ones in the chromosome
end

# Creating a Population builder
population_builder = Genetica::PopulationBuilder.new
# Setting Population
population_builder.size = 100                                 # Population Size
population_builder.crossover_probability = 0.7                # Crossover rate
population_builder.mutation_probability = 0.001               # Mutation rate
population_builder.chromosome_length = 20                     # Chromosome length
population_builder.chromosome_alleles = [0, 1]                # Chromosome alleles
population_builder.fitness_function = method(:number_of_ones) # Fitness Function

# Step 1.
# Perform 20 runs, and measure the average generation at which the string of
# all ones is discovered.
runs = 20
exercise_run(population_builder, runs)

# Step 2.
# Perform the same experiment with crossover turned off (i.e., pc = 0).

# Set crossover rate to 0
population_builder.crossover_probability = 0
# Run
puts "Same running with crossover turned off..."
exercise_run(population_builder, runs)

# Step 3.
# With mutation turned off and crossover probability to 0.7
puts "Same running with mutation turned off and crossover probability to 0.7."
population_builder.mutation_probability = 0
population_builder.crossover_probability = 0.7
exercise_run(population_builder, runs)
