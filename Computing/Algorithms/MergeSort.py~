

# Merge Sort

def MergeSort(toSort):
    
    toReturn = len(toSort) * [0]

    # If lenght 1, return; else break it up
    if len(toSort) == 1:
	return toSort 
    elif len(toSort)%2 != 0:
	sub1 = toSort[0:len(toSort)/2]
	sub2 = toSort[len(toSort)/2:len(toSort)]
    else:
	sub1 = toSort[0:len(toSort)/2]
	sub2 = toSort[len(toSort)/2:len(toSort)]
    
    # Sort the sublists
    sub1_sort = MergeSort(sub1)
    sub2_sort = MergeSort(sub2)
    sub1_len = len(sub1_sort)
    sub2_len = len(sub2_sort)

    # Recombine the sublists 
    i = 0; j =0
    for k in range(len(toReturn)):
	if i > sub1_len-1:
	    toReturn[k] = sub2_sort[j]
	    j += 1
	elif j > sub2_len-1:
	    toReturn[k] = sub1_sort[i]
	    i += 1
	else:
	    if sub1_sort[i] < sub2_sort[j]:
		toReturn[k] = sub1_sort[i]
		i += 1
	    else:
		toReturn[k] = sub2_sort[j]
		j += 1
    return toReturn











