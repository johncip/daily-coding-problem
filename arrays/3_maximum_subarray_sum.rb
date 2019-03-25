# 2. Find the maximum sum of any subarray.

# brute force is to check every subarray, I'm not going
# to bother with that.

# various things we can store
#
# - start index of a subarray
# - end index of a subarray
# - current subarray sum
# - max subarray sum seen so far
# - current index
# - whether elements remain (derive from cur idx)


# strategy: assume the max sum is the whole array sum.
#
# then identity negative subarray sums anchored at
# the start and end, and subtract them if they exist.
#
# this works on the book example, but feels wrong,
# because of the complexity, the lack of generality
# that looking for negative numbers has, and the
# potential for the negative sums to overlap.
#
# (I could check for the overlap but am not going to
# bother since I'm fairly sure this isn't the right
# solution.)
#
# also I'm just realizing that this won't work
# on an array with only negative values, at least not
# without more condition checking.
#
def most_negative_left_sum(arr)
  min_sum = 0
  sum = 0
  last_added = nil

  (0...arr.size).each do |i|
    sum += arr[i]
    next unless sum < min_sum
    min_sum = sum
    last_added = i
  end

  return [min_sum, last_added]
end

def most_negative_right_sum(arr)
  min_sum = 0
  sum = 0
  last_added = nil

  (arr.size - 1).downto(0).each do |i|
    sum += arr[i]
    next unless sum < min_sum
    min_sum = sum
    last_added = i
  end

  return [min_sum, last_added]
end

def maximum_subarray_sum_1(arr)
  sum = arr.sum

  lsum, lidx = most_negative_left_sum(arr)
  rsum, ridx = most_negative_right_sum(arr)

  sum -= lsum if lidx
  sum -= rsum if ridx

  return sum
end

# potential invariant:
#
# max_sum = max(0, cur_sum) + max_sum(rest)
#   -- where rest can't skip any on the left
#   -- and we have no way of skipping stuff on the right
#   ... so this is useless


# let's just try coding something...
def maximum_subarray_sum_2(arr)
  sum = 0

  (0...arr.size).each do |i|
    sum += arr[i]
    sum = sum < 0 ? 0 : sum
  end

  return sum
end

# ^^^ works for the book example but I suspect that
# it won't know when to stop on the right.

# after consultation with the book ... :(
def maximum_subarray_sum_3(arr)
  sum = -999
  max = -999

  (0...arr.size).each do |i|
    sum += arr[i]
    sum = sum < 0 ? 0 : sum
    max = [sum, max].max
  end

  return max
end
