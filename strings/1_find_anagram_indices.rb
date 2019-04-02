# brute force (attempt)
#
def find_anagram_indices_1(str, word)
  found = []
  word_letters = word.split('').sort

  (0..(str.size - word.size)).each do |i|
    window = i...(i + word.size)
    window_letters = str[window].split('').sort
    found.push(i) if window_letters == word_letters
  end

  return found
end

# thoughts: is there something we can precompute w/r/t letter counts?
#
# what if we generated the sorted list of letters for each window in advance?
# - insertion into the list is expensive
# - if we had a structure that was efficient to insert and remove from,
#   that stays in order, we can use it to pass the window / create the
#   sorted lists. but we'd have to traverse it every time (if it's a tree)
#
# if we had a histogram of letter counts, that would be efficient to update

# next thought: we don't need to sort anything if we have two hashes.
# (but we need fast comparison of the hashes).

# optimization idea: if the last window was an anagram,
# and moving the window meant adding and removing the same letter,
# then the current window is an anagram.

# what if we precomputed, for each letter, which windows it was within?
# assuming fast lookup, we can, for each letter in the search word,
# see if the current window is in its set of windows
#
# that would be log(n) * # of letters?
# log(n) would be for set intersection. we'd fold from the left:
# (a's windows int. b's windows) int. c's windows, etc.
#
# what about the insertions? for each letter we'd have to "generate" multiple
# windows. but it seems closed-form-ish? for instance, the "set" of windows
# could in fact be a Range of starting elements -- intersection
# is constant time.
#
# in other words, for each letter in the string, we store the min window-start
# and the max window-start. then, for each letter in the word, we fetch the
# "ranges" and min/max over all of them.
#
# ---------------------------------------------------------------------------
#
# after consulting the book :(
#
# I was on the right track with the hashes. but the way to make this efficient
# is to avoid the hash comparison altogether -- you just use one hash (of counts),
# and start by adding all of the letters in the word, then remove all of the
# letters in the first window. then you move the window and update the counts.
#
# essentially you maintain a hash of the difference in the counts.
#
# also, whenever a value is decremented, you check if it's zero and remove
# the key if so. so the "check" just becomes whether or not the hash is empty.

def find_anagram_indices_2(str, word)
  found = []
  counts = Hash.new(0)
  str_letters = str.split('')
  word_letters = word.split('')

  # add word letters to counts
  word_letters.each do |ltr|
    counts[ltr] = 0 unless counts[ltr]
    counts[ltr] += 1
  end

  # loop over the first window
  window_letters = str_letters[0...word.size]
  window_letters.each do |ltr|
    counts[ltr] -= 1 if counts[ltr]
    counts.delete(ltr) if counts[ltr] == 0
  end
  found.push(0) if counts.empty?

  # do the rest in a loop (only need to update leading & trailing edge)
  str_indices = 1..(str.size - word.size)
  str_indices.each do |i|
    outgoing = str_letters[i - 1]
    incoming = str_letters[i + word.size - 1]

    counts[outgoing] -= 1
    counts[incoming] += 1

    counts.delete(incoming) if counts[incoming] == 0
    counts.delete(outgoing) if counts[outgoing] == 0

    found.push(i) if counts.empty?
  end

  return found
end
