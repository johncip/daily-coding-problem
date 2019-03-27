# 1.4 Find number of smaller elements to the right

# initial thoughts:
#
# - the last element of the result array will be 0
# - the second-to-last only involes the comparison of two elements
#
# - what if we store the max of those two?
# - what if we store the min of those two?
# - what if we store the position of the last seen max value?
#
# - what if we knew, for each i, the smallest element to the right of it?
# - what if we knew, for each i, the largest element to the right of it?
#
# - what if we had an array where the values were the cardinality of the
#   size of each input element at i?
#
# - I think optimizing this will somehow involve transitivity of <

# let's do a brute force one...
#
# this is quadratic on time
def smaller_elements_right_1(arr)
  res = Array.new(arr.size)
  res[arr.size - 1] = 0

  (arr.size - 2).downto(0).each do |i|
    num_els = 0
    (i...arr.size).each do |j|
      # here we're looking at arr[i] multiple times -- what can we
      # store so that we only need to look at it once?
      num_els += 1 if arr[j] < arr[i]
    end

    res[i] = num_els
  end

  return res
end

# upon consultation with the book ... :(
#
# the book's solution involves keeping a sorted list of the elements seen so far,
# moving from the right.
#
# I'm pretty sure that updating that sorted list is O(n), making the overall solution
# O(n^2). (Lookups are log but insertions are not, per the relevant python library docs.)
#
# and I don't know of a common data structure that would have all of the properties you need.
#
# - fast sorted insertion
# - fast lookup of the number of elements smaller than a given element
#
# But you could probably do a binary search tree where the nodes also store a memo
# of the number of their children. I believe updating the memo would be log(n), as would
# searching and insertion. Not 100% sure if it would suffice / haven't tried it on an example.
