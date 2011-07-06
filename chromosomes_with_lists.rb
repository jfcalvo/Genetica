
# 31.695232 seconds generating 10.000.000 chromosomes
def generate_chromosome_1(length, alleles)
  (1..length).collect { alleles[rand(alleles.size)] }
end

# 59.475459 seconds generating 10.000.000 chromosomes
def generate_chromosome_2(length, alleles)
  chromosome = Array.new
  for i in 1..length
    chromosome += alleles[rand(alleles.size), 1]
  end
  return chromosome
end

# 56.628943 second generating 10.000.000 chromosomes
def generate_chromosome_3(length, alleles)
  chromosome = Array.new
  length.times do
    chromosome += alleles[rand(alleles.size), 1]
  end
  return chromosome
end

# 26.912256 second generating 10.000.000 chromosomes
def generate_chromosome_4(length, alleles)
  chromosome = []
  length.times do
    chromosome << alleles[rand(alleles.size)]
  end
  return chromosome
end

# 26.19594 seconds crossovering 10000000 chromosomes
def single_point_crossover_1(chromosome_a, chromosome_b)
  locus = rand(chromosome_a.size)
  offspring_a = chromosome_a[0..locus] + chromosome_b[(locus + 1)...chromosome_b.size]
  offspring_b = chromosome_b[0..locus] + chromosome_a[(locus + 1)...chromosome_a.size]
  return offspring_a, offspring_b
end

# 23.429007 seconds crossovering 10000000 chromosomes
def single_point_crossover_2(chromosome_a, chromosome_b)
  locus = rand(chromosome_a.size)
  range_left = 0..locus
  range_right = (locus + 1)...chromosome_a.size
  offspring_a = chromosome_a[range_left] + chromosome_b[range_right]
  offspring_b = chromosome_b[range_left] + chromosome_a[range_right]
  return offspring_a, offspring_b
end

# 20.691821 seconds crossovering 10000000 chromosomes
def single_point_crossover_3(chromosome_a, chromosome_b)
  offspring_a, offspring_b = [], []
  locus = rand(chromosome_a.size) + 1
  offspring_a = chromosome_a.take(locus) + chromosome_b.last(chromosome_a.length - locus)
  offspring_b = chromosome_b.take(locus) + chromosome_a.last(chromosome_a.length - locus)
  return offspring_a, offspring_b
end

def measure_time(repeat)
  start = Time.now
  repeat.times { yield }
  puts "Took #{Time.now - start} seconds, repeating #{repeat} times."
end

repeat = 10000000

# puts "Using generate_chromosome_1:"
# measure_time(repeat) { generate_chromosome_1 8, [0, 1] }
# 
# puts "Using generate_chromosome_2:"
# measure_time(repeat) { generate_chromosome_2 8, [0, 1] }
# 
# puts "Using generate_chromosome_3:"
# measure_time(repeat) { generate_chromosome_3 8, [0, 1] }
# 
# puts "Using generate_chromosome_4:"
# measure_time(repeat) { generate_chromosome_4 8, [0, 1] }

puts "Generating chromosomes."
chromosome_a = generate_chromosome_4 8, [0, 1]
chromosome_b = generate_chromosome_4 8, [0, 1]

puts "Using single_point_crossover_1:"
measure_time(repeat) { single_point_crossover_1 chromosome_a, chromosome_b }

puts "Using single_points_crossover_2:"
measure_time(repeat) { single_point_crossover_2 chromosome_a, chromosome_b }

puts "Using single_points_crossover_3:"
measure_time(repeat) { single_point_crossover_3 chromosome_a, chromosome_b }

