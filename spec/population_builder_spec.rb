require 'spec_helper'

class PopulationClass < Genetica::Population
  def fitness(chromosome)
  end
end

shared_examples 'correct population attribute values' do
  its(:population_class) { should be == PopulationClass }
  its(:population) { should be_an_instance_of PopulationClass }
  its('population.size') { should be == subject.size }
  its('population.elitism') { should be == subject.elitism }
  its('population.crossover_method') { should be == subject.crossover_method }
  its('population.crossover_probability') { should be == subject.crossover_probability }
  its('population.mutation_probability') { should be == subject.mutation_probability }
  its('population.first.size') { should be == subject.chromosome_length }
  its('population.alleles') { should be == subject.chromosome_alleles }
end

describe Genetica::PopulationBuilder do
  subject { described_class.new }

  describe '#population' do
    context 'assigned population class' do
      before { subject.population_class = PopulationClass }

      context 'build population with default values' do
        it_behaves_like 'correct population attribute values'
      end

      context 'build population with custom values' do
        let(:size) { 12 }
        let(:elitism) { 2 }
        let(:crossover_method) { :single_point_crossover }
        let(:crossover_probability) { 1.0 }
        let(:mutation_probability) { 0.5 }
        let(:chromosome_length) { 7 }
        let(:chromosome_alleles) { ['a', 'b', 'c'] }

        before do
          subject.size = size
          subject.elitism = elitism
          subject.crossover_method = :single_point_crossover
          subject.crossover_probability = crossover_probability
          subject.mutation_probability = mutation_probability
          subject.chromosome_length = chromosome_length
          subject.chromosome_alleles = chromosome_alleles
        end

        it_behaves_like 'correct population attribute values'
      end
    end

    context 'not assigned population class' do
      it 'should raise an error when trying to build population' do
        expect do
          subject.population
        end.to raise_error(described_class::PopulationClassError)
      end
    end
  end
end
