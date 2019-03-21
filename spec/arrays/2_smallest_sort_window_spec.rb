require './arrays/2_smallest_sort_window'

describe 'min_on_left?' do
  it 'works for one' do
    expect(min_on_left? [1], 0, 0).to eq(true)
    expect(min_on_left? [2, 1], 1, 1).to eq(true)
    expect(min_on_left? [4, 3, 2, 1], 2, 2).to eq(true)
  end

  it 'works for many' do
    expect(min_on_left? [1, 2, 4, 3], 0, 3).to eq(true)
    expect(min_on_left? [3, 2, 4, 1], 0, 3).to eq(false)

    expect(min_on_left? [1, 2, 4, 3], 1, 2).to eq(true)
    expect(min_on_left? [1, 2, 4, 3], 1, 3).to eq(true)
    expect(min_on_left? [1, 2, 4, 3], 2, 3).to eq(false)
  end
end

describe 'max_on_right?' do
  it 'works for one' do
    expect(max_on_right? [1], 0, 0).to eq(true)
    expect(max_on_right? [2, 1], 1, 1).to eq(true)
    expect(max_on_right? [4, 3, 2, 1], 2, 2).to eq(true)
  end

  it 'works for many' do
    expect(max_on_right? [1, 2, 4, 3], 0, 2).to eq(true)
    expect(max_on_right? [1, 2, 4, 3], 0, 3).to eq(false)

    expect(max_on_right? [1, 2, 4, 3], 1, 2).to eq(true)
    expect(max_on_right? [1, 2, 4, 3], 1, 3).to eq(false)
    expect(max_on_right? [1, 2, 4, 3], 2, 3).to eq(false)
  end
end

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
