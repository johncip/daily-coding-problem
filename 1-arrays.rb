# -- 1. product of all other elements in an array

# quadratic time, linear space
def product_of_all_other_elements_naive(arr)
  res = Array.new(arr.size)

  arr.each_index do |i|
    res[i] = 1
    arr.each_index do |j|
      next if j == i

      res[i] *= arr[j]
    end
  end

  return res
end

# linear time, constant (extra) space
def product_of_all_other_elements(arr)
  product = 1

  arr.each_index do |i|
    product *= arr[i]
  end

  arr.each_index do |i|
    arr[i] = product / arr[i]
  end

  return arr
end

# same as above
def product_of_all_other_elements_fancy(arr)
  product = arr.reduce(1, :*)

  return arr.map do |val|
    product / val
  end
end

# -- 2. product of all other elements in an array
