require 'rails_helper'

RSpec.describe Body, type: :model do
  subject { described_class.new(parts: parts) }

  context 'with valid parts' do
    let(:parts) { 'front-torso, front-thigh-right' }

    it 'is valid' do
      expect(subject).to be_valid
    end
  end

  context 'with invalid parts' do
    let(:parts) { 'invalid-part, another-invalid-part' }

    it 'is not valid' do
      puts subject
      expect(subject).not_to be_valid
      expect(subject.errors[:parts]).to include("contains invalid parts")
    end
  end

  context 'with parts containing numbers' do
    let(:parts) { 'front-torso1, front-thigh-right' }

    it 'is not valid' do
      expect(subject).not_to be_valid
      expect(subject.errors[:parts]).to include("must be a string and not contain numbers")
    end
  end

  context 'with parts as a non-string' do
    let(:parts) { 123 }

    it 'is not valid' do
      expect(subject).not_to be_valid
      expect(subject.errors[:parts]).to include("must be a string and not contain numbers")
    end
  end

  context 'with a mixture of valid and invalid parts' do
    let(:parts) { 'front-torso, invalid-part' }

    it 'is not valid' do
      expect(subject).not_to be_valid
      expect(subject.errors[:parts]).to include("contains invalid parts")
    end
  end

  context 'with empty parts' do
    let(:parts) { '' }

    it 'is valid' do
      expect(subject).to be_valid
    end
  end
end
