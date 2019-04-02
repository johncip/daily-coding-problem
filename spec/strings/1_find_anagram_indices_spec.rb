require './strings/1_find_anagram_indices.rb'


versions = [
  'find_anagram_indices_1',
  'find_anagram_indices_2',
]

versions.each do |name|
  describe name do
    it 'works on the book example' do
      expect(send name, 'abxaba', 'ab').to eq([0, 3, 4])
    end
  end
end

