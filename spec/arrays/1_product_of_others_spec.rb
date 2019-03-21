require './arrays/1_product_of_others'

versions = [
  'product_of_other_els_temp',
  'product_of_other_els_div',
  'product_of_other_els_final'
]

versions.each do |name|
  describe name do
    it 'works on a few' do
      expect(send name, [3, 2, 1]).to eq [2, 3, 6]
    end

    it 'works on a few more' do
      expect(send name, [1, 2, 3, 4, 5]).to eq [120, 60, 40, 30, 24]
    end

    # from me
    it 'works for a single-element array' do
      expect(send name, [2]).to eq [1]
    end

    it 'works for a double-element array' do
      expect(send name, [2, 3]).to eq [3, 2]
    end
  end
end
