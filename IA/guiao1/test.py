def homologos(list_1, list_2):
	if list_1 == [] and list_2 == []:
		return None
	elif len(list_1) == 1:
		return [(list_1[0], list_2[0])]
	else:
		return [(list_1[0],list_2[0])]+homologos(list_1[1:], list_2[1:])

print(homologos([1,2,3],[2,4,5]))