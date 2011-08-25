
# 72.217263 seconds generating 10.000.000 chromosomes
def generate_chromosome_1(length, alleles)
  (1..length).collect { alleles[rand(alleles.size)] }.join
end

# 64.619006 seconds generating 10.000.000 chromosomes
def generate_chromosome_2(length, alleles)
  chromosome = String.new
  for i in 1..length
    chromosome += alleles[rand(alleles.size)]
  end
  return chromosome
end

# 61.679619 second generating 10.000.000 chromosomes
def generate_chromosome_3(length, alleles)
  chromosome = String.new
  length.times do
    chromosome += alleles[rand(alleles.size)]
  end
  return chromosome
end

# 51.38105 second generating 10.000.000 chromosomes
def generate_chromosome_4(length, alleles)
  chromosome = ""
  length.times do
    chromosome << alleles[rand(alleles.size)]
  end
  return chromosome
end

# 20.282132 seconds crossovering 10000000 chromosomes
def single_point_crossover_1(chromosome_a, chromosome_b)
  locus = rand(chromosome_a.size)
  offspring_a = chromosome_a[0..locus] + chromosome_b[(locus+1)...chromosome_b.size]
  offspring_b = chromosome_b[0..locus] + chromosome_a[(locus+1)...chromosome_a.size]
  return offspring_a, offspring_b
end

# 17.590166 seconds crossovering 10000000 chromosomes
def single_point_crossover_2(chromosome_a, chromosome_b)
  locus = rand(chromosome_a.size)
  range_left = 0..locus
  range_right = (locus+1)...chromosome_a.size
  offspring_a = chromosome_a[range_left] + chromosome_b[range_right]
  offspring_b = chromosome_b[range_left] + chromosome_a[range_right]
  return offspring_a, offspring_b
end

def measure_time(repeat)
  start = Time.now
  repeat.times { yield }
  puts "Took #{Time.now - start} seconds, repeating #{repeat} times."
end


repeat = 10000000

puts "Using generate_chromosome_1:"
measure_time(repeat) { generate_chromosome_1 8, "01" }
 
puts "Using generate_chromosome_2:"
measure_time(repeat) { generate_chromosome_2 8, "01" }
 
puts "Using generate_chromosome_3:"
measure_time(repeat) { generate_chromosome_3 8, "01" }
 
puts "Using generate_chromosome_4:"
measure_time(repeat) { generate_chromosome_4 8, "01" }

#(1..4).each do |i|
#  puts "Using generate_chromosome_#{i}"
#  measure_time(repeat) {send "generate_chromosome_#{i}", 8, "01"}
#end

puts "Generating chromosomes."
chromosome_a = generate_chromosome_4 8, "01"
chromosome_b = generate_chromosome_4 8, "01"

puts "Using single_point_crossover_1:"
measure_time(repeat) { single_point_crossover_1 chromosome_a, chromosome_b }

puts "Using single_point_crossover_2:"
measure_time(repeat) { single_point_crossover_2 chromosome_a, chromosome_b }

