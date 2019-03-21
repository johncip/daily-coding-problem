# 1. Find the product of all other elements in an array.
#
# The main problem with doing this in-place is that you
# need to keep reading either the old values (or their product).


# If the answer is built in a temporary array, you can just
# keep reading the old values.
#
# quadratic time, linear space
def product_of_other_els_temp(arr)
  res = Array.new(arr.size)

  arr.each_index do |i|
    res[i] = 1
    arr.each_index do |j|
      res[i] *= arr[j] unless j == i
    end
  end

  return res
end

# Each value is equal to the full product dividied by
# the value at the current index.
#
# linear time, constant space
def product_of_other_els_div(arr)
  product = 1

  arr.each_index do |i|
    product *= arr[i]
  end

  arr.each_index do |i|
    arr[i] = product / arr[i]
  end

  return arr
end

# By keeping a running product, you can avoid both division
# and a temporary array.
#
# quadratic (well, triangular) time, constant space.
#
# per the book: precomputing the running ("prefix") product
# and the "suffix" product makes this linear time & space.
def product_of_other_els_final(arr)
  running_product = 1
  current_val = nil

  arr.each_index do |i|
    current_val = arr[i]
    arr[i] = running_product

    ((i+1)...arr.size).each do |j|
      arr[i] *= arr[j]
    end

    running_product *= current_val
  end

  return arr
end
