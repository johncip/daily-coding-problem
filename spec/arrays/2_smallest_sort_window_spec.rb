require './arrays/2_smallest_sort_window'

versions = [
  'smallest_sort_window_1',
  'smallest_sort_window_2',
]

versions.each do |name|
  describe name do
    it 'works on the book example' do
      expect(send name, [3, 7, 5, 6, 9]).to eq [1, 3]
    end

    it 'works on a sorted array' do
      expect(send name, [1, 2, 3]).to eq [nil, nil]
    end
  end
end
