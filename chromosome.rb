class Chromosome

  attr_reader :chromosome

  def initialize(chromosome)
    @chromosome = chromosome
  end

  def initialize(length, alleles)
    @chromosome = generate_chromosome(length, alleles)
  end

  def single_point_crossover(chromosome)
    offspring_a, offspring_b = [], []
    locus = rand(@chromosome.size) + 1
    other_chromosome = chromosome.chromosome
    puts "Locus: #{locus}"
    offspring_a = @chromosome.take(locus) + other_chromosome.last(@chromosome.size - locus)
    offspring_b = other_chromosome.take(locus) + @chromosome.last(@chromosome.size - locus)
    return offspring_a, offspring_b
  end

  def to_s
    return @chromosome.join
  end
 
  private
  def generate_chromosome(length, alleles)
    chromosome = Array.new
    length.times do
      chromosome << alleles[rand(alleles.size)]
    end
    return chromosome
  end
end


def measure_time(repeat)
  start = Time.now
  repeat.times { yield }
  puts "Took #{Time.now - start} seconds, repeating #{repeat} times."
end

repeat = 10000000

puts "Generating chromosomes..."
measure_time(repeat) { Chromosome.new 8, [0, 1] }

