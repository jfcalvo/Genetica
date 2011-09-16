require 'genetica'
require 'text'
require 'benchmark'

# Fitness Functions
def number_of_ones(chromosome)
  return chromosome.chromosome.count 1 # Number of ones in the chromosome
end

def distance(chromosome)
  levenshtein_distance = Text::Levenshtein.distance("genetica", chromosome.chromosome.join)
  if levenshtein_distance == 0
    return 2
  else
    return 1 / levenshtein_distance.to_f
  end
end

class SpeedBenchmark
  def initialize
    # Creating a Population builder
    @population_builder = Genetica::PopulationBuilder.new
  end

  def benchmark_fitness_selection
    # Setting Population
    @population_builder.size = 100                                 # Population Size
    @population_builder.crossover_probability = 0.7                # Crossover rate
    @population_builder.mutation_probability = 0.001               # Mutation rate
    @population_builder.chromosome_length = 20                     # Chromosome length
    @population_builder.chromosome_alleles = [0, 1]                # Chromosome alleles
    @population_builder.fitness_function = method(:number_of_ones) # Fitness Function

    population = @population_builder.population

    # Execute 10000 times a fitness proportionate selection    
    10000.times { population.fitness_proportionate_selection }
  end

  def benchmark_best_fitness
    # Setting Population
    @population_builder.size = 1000                                # Population Size
    @population_builder.crossover_probability = 0.7                # Crossover rate
    @population_builder.mutation_probability = 0.001               # Mutation rate
    @population_builder.chromosome_length = 20                     # Chromosome length
    @population_builder.chromosome_alleles = [0, 1]                # Chromosome alleles
    @population_builder.fitness_function = method(:number_of_ones) # Fitness Function

    population = @population_builder.population

    # Execute 1000 times get best fitness of the population
    10000.times { population.best_fitness }
  end

  def benchmark_generations
    # Setting Population
    @population_builder.size = 100                                 # Population Size
    @population_builder.crossover_probability = 0.7                # Crossover rate
    @population_builder.mutation_probability = 0.001               # Mutation rate
    @population_builder.chromosome_length = 20                     # Chromosome length
    @population_builder.chromosome_alleles = [0, 1]                # Chromosome alleles
    @population_builder.fitness_function = method(:number_of_ones) # Fitness Function

    population = @population_builder.population

    # Execute a run with 1000 generations
    population.run generations=1000
  end

  def benchmark_1
    # Setting Population
    @population_builder.size = 1000                                # Population Size
    @population_builder.crossover_probability = 0.7                # Crossover rate
    @population_builder.mutation_probability = 0.001               # Mutation rate
    @population_builder.chromosome_length = 20                     # Chromosome length
    @population_builder.chromosome_alleles = [0, 1]                # Chromosome alleles
    @population_builder.fitness_function = method(:number_of_ones) # Fitness Function
    
    population = @population_builder.population

    # Run until a chromosome with all genes to 1 is discovered
    while population.best_fitness < @population_builder.chromosome_length
      population.run generations=1
    end
  end

  def benchmark_2
    # Setting Population
    @population_builder.size = 100                                  # Population Size
    @population_builder.crossover_probability = 0.7                 # Crossover rate
    @population_builder.mutation_probability = 0.001                # Mutation rate
    @population_builder.chromosome_length = 8                       # Chromosome length
    @population_builder.chromosome_alleles = ('a'..'z').to_a        # Chromosome alleles
    @population_builder.fitness_function = method(:distance)        # Fitness Function

    population = @population_builder.population

    while population.best_fitness < 2
      population.run generations=1
      puts population.best_chromosome
    end
  end

end


# Executing Benchmarks
speed_benchmark = SpeedBenchmark.new

Benchmark.bm do |x|
  x.report('fitness selections:') { speed_benchmark.benchmark_fitness_selection }
  x.report('best fitness:') { speed_benchmark.benchmark_best_fitness }
  x.report('generations:') { speed_benchmark.benchmark_generations }
  x.report('benchmark_1:') { speed_benchmark.benchmark_1 }
  x.report('benchmark_2:') { speed_benchmark.benchmark_2 }
end

