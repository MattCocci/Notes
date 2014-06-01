# Merge Sort
def MergeSort(toSort):
    
  toReturn = len(toSort) * [0]

  # If length 1, return; else break it up
  if len(toSort) == 1:
    return toSort 
  else:
    sub1 = MergeSort(toSort[ :int(len(toSort)/2)])
    sub2 = MergeSort(toSort[int(len(toSort)/2): ])
    
  # Sort the sublists
  sub1_len = len(sub1)
  sub2_len = len(sub2)

  # Recombine the sublists 
  i = 0; j =0
  for k in range(len(toReturn)):
    if j > sub2_len-1:
	    toReturn[k] = sub1[i]
	    i += 1
    elif i > sub1_len-1:
	    toReturn[k] = sub2[j]
	    j += 1
    elif sub1[i] < sub2[j]:
	    toReturn[k] = sub1[i]
	    i += 1
    else:
      toReturn[k] = sub2[j]
      j += 1

  return toReturn











