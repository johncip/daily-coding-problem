require './arrays/3_maximum_subarray_sum'

describe 'most_negative_left_sum' do
  it 'works on the book example' do
    ex = [34, -50, 42, 14, -5, 86]
    expect(most_negative_left_sum ex).to eq [-16, 1]
  end
end

describe 'most_negative_right_sum' do
  it 'works on the book example' do
    ex = [34, -50, 42, 14, -5, 86]
    expect(most_negative_right_sum ex).to eq [0, nil]
  end
end

versions = [
  # 'maximum_subarray_sum_1',
  # 'maximum_subarray_sum_2',
  'maximum_subarray_sum_3',
]

versions.each do |name|
  describe name do
    it 'works on the book example' do
      ex = [34, -50, 42, 14, -5, 86]
      expect(send name, ex).to eq 137
    end

    it 'works when the right is very negative' do
      ex = [34, -50, 42, 14, -5, -86]
      expect(send name, ex).to eq 56
    end
  end
end
