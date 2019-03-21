# 2. Find the smallest window to be sorted.
#
# The first attempt that worked was to sort the array and
# see what's different.
#
# linearithmic time (if sort is), linear space
def smallest_sort_window_1(arr)
  sorted = arr.dup.sort

  left = 0
  right = arr.size - 1

  (0...arr.size).each do |l|
    if sorted[l] != arr[l]
      left = l
      break
    end
  end

  (arr.size - 1).downto(0).each do |r|
    if sorted[r] != arr[r]
      right = r
      break
    end
  end

  return [left, right]
end

# some thoughts:
#
# we can define an array as:
#     a sorted prefix, which must start from the min_value
#   + an unsorted middle
#   + a sorted suffix, which must end with the max_value
#
# e.g.:
#   [1]          = p[]  + u[1]    + m[]
#   [2, 1]       = p[]  + u[2, 1] + m[]
#   [1, 3, 2]    = p[1] + u[3, 2] + m[]
#   [1, 3, 2, 4] = p[1] + u[3, 2] + m[4]
#
# it then remains to identify the bounds of the prefix & suffix.
#
# (this didn't lead to a concrete soln)
#
# ---------------------------------------------------------
#
# another thing to note:
#
# [3, 5, 4, 1, 2]
#     ^     ^
#    max   min
#
# min is at i=4, so we need to at sort from i=0 up to 4
# (so that the min value can be at the front)
#
# max is at i=1, so we need to also sort from i=1 up to N
# (so that the max value can be at the end)
#
# ---------------------------------------------------------
#
# [3, 7, 5, 6, 9]
#
# min at beginning, max at end, what then?
#
# peel off max & min when they are at the beginning and end,
# and search the resulting subarray.
#
# for a given subarray, & opposite cursors l and r
#
# - if arr[l] is the min value, move l right (else leave alone)
# - if arr[r] is the max value, move r left (else leave alone)
#
# if both were left alone, we're done.
# otherwise, remove l & r and check the new subarray.

# quadratic time, constant space
def smallest_sort_window_2(arr, l = 0, r = arr.size - 1)
  return [nil, nil] if l >= r

  next_l, next_r = l, r

  next_l += 1 if min_on_left?(arr, l, r)
  next_r -= 1 if max_on_right?(arr, l, r)

  if next_l == l && next_r == r
    return [l, r]
  end

  return smallest_sort_window_2(arr, next_l, next_r)
end

def min_on_left?(arr, l, r)
  min = arr[l]

  l.upto(r).each do |i|
    return false if arr[i] < min
  end

  return true
end

def max_on_right?(arr, l, r)
  max = arr[r]

  r.downto(l).each do |i|
    return false if arr[i] > max
  end

  return true
end

# the above seems unlikely to be the most efficient solution.
#
# - for one thing, we could be checking to see *where* the
#   first element that's smaller than the first resides.
#   I'm looking at the whole array and then "throwing out"
#   what I saw.
#
# - for another, I doubt that the lower bound on actually
#   sorting is lower than the lower bound on essentially
#   asking "to what degree" the array is unsorted.
#
# ---------------------------------------------------------
#
# upon consultation with the book... :(
#
def smallest_sort_window_3(arr)

  # right bound:
  # *last* element that is l.t. the running max (from left)

  right = nil
  max_seen = arr.first

  (0...arr.size).each do |l|
    if arr[l] >= max_seen
      max_seen = arr[l]
    else
      right = l
    end
  end

  # left bound:
  # *last* element that is g.t. the running min (from left)

  left = nil
  min_seen = arr.last

  (arr.size - 1).downto(0).each do |r|
    if arr[r] <= min_seen
      min_seen = arr[r]
    else
      left = r
    end
  end

  return [left, right]
end

# I was hung up on (e.g.) getting the left bound by scanning
# from the left and stopping when I'd found it. But that wouldn't
# work, because (e.g.) knowing if the array is in nondecreasing order
# means checking all the way to the last element.
#
# The book's solution still feels "backwards" and it'd be nice
# if I could find a way to adjust my intuition.

# oblique strategies for future array problems:
#
# - what if I use a running ____ ?
# - do I need the first element where ____ is true, or the last one?
# - do I need to scan the whole array to determine this value?
#   - (in other words, it may not be safe to break)
