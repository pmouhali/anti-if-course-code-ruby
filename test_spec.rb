class Nothing
 
  attr_reader :nothing
  def initialize
    @nothing = 0
  end

end

RSpec.describe Nothing do
  describe '#nothing' do
    let(:nothing) { described_class.new }
    it 'is equal to zero' do
      expect(nothing.nothing).to eq(0)
    end
  end
end
