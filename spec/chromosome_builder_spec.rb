require 'spec_helper'

shared_examples 'correct chromosome attribute values' do
  its('chromosome') { should be_an_instance_of Genetica::Chromosome }
  its('chromosome.size') { should be == subject.length }

  it 'should have correct alleles' do
    subject.chromosome.each do |allele|
      subject.alleles.include?(allele).should be_true
    end
  end
end

describe Genetica::ChromosomeBuilder do
  subject { described_class.new }

  describe '#chromosome' do
    context 'build chromosome with default values' do
      it_behaves_like 'correct chromosome attribute values'
    end

    context 'build chromosome with custom values' do
      let(:length) { 120 }
      let(:alleles) { ('a'..'z').to_a }

      before do
        subject.length = length
        subject.alleles = alleles
      end

      it_behaves_like 'correct chromosome attribute values'
    end
  end
end
