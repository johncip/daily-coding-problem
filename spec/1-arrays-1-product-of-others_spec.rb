require './1-arrays-1-product-of-others'

describe 'product_of_all_other_elements' do
  versions = [
    lambda { |x| product_of_other_els_temp(x) },
    lambda { |x| product_of_other_els_div(x) },
    lambda { |x| product_of_other_els_final(x) }
  ]

  versions.each do |fn|
    it 'works on a few' do
      expect(fn.call [3, 2, 1]).to eq [2, 3, 6]
    end

    it 'works on a few more' do
      expect(fn.call [1, 2, 3, 4, 5]).to eq [120, 60, 40, 30, 24]
    end

    # from me
    it 'works for a single-element array' do
      expect(fn.call [2]).to eq [1]
    end

    it 'works for a double-element array' do
      expect(fn.call [2, 3]).to eq [3, 2]
    end
  end
end