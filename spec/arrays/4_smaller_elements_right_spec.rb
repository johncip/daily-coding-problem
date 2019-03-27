require './arrays/4_smaller_elements_right.rb'

versions = [
  'smaller_elements_right_1',
]

versions.each do |name|
  describe name do
    it 'works on the book example' do
      ein = [3, 4, 9, 6, 1]
      eout = [1, 1, 2, 1, 0]
      expect(send name, ein).to eq eout
    end
  end
end

