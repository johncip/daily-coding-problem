require './arrays/2_smallest_sort_window'

describe 'smallest_sort_window' do
  versions = [
    lambda { |x| smallest_sort_window_1(x) },
    lambda { |x| smallest_sort_window_2(x) },
  ]

  versions.each do |fn|
    it 'works on the book example' do
      expect(fn.call [3, 7, 5, 6, 9]).to eq [1, 3]
    end
  end
end
