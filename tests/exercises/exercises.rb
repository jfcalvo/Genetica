load 'genetica.rb'

# Fitness function
def number_of_ones(chromosome)
	# Return the number of ones in the chromosome
	chromosome.chromosome.count 1
end

# Building Population
population_builder = Genetica::PopulationBuilder.new
population_builder.size = 100
population_builder.crossover_probability = 0.7
population_builder.mutation_probability = 0.001
population_builder.chromosome_length = 20
population_builder.chromosome_alleles = [0, 1]
population_builder.fitness_function = method(:number_of_ones)


generations_best_fitness = Array.new

500.times do
	# Generating Population
	population = population_builder.population

	fitness = 0
	while fitness < 20
		population.run
		# Get the best fitness of this run
		fitness = population.best_fitness
	end

	# Storing generation best fitness
	generations_best_fitness << population.generations	

	puts "Fitness #{fitness} achieved at generation #{population.generations}."
end

generations_best_fitness_average = generations_best_fitness.inject(:+)/generations_best_fitness.size.to_f
puts "Best fitness average achieved at #{generations_best_fitness_average}"
