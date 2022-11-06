
#1
def listLength(list):
    if list == []:
        return 0

    return 1 + listLength(list[1:])


#2
def listSum(list):
    if list == []:
        return 0
    
    return list[0]+listSum(list[1:])

#3
def findValue(list,elem):
    if (list == []):
        return False

    return list[0]==elem or findValue(list[1:],elem)       


#4
def listsConcat(list1,list2):
    if (list1  == []):
        return list2
    
    return [list1[0]]+listsConcat(list1[1:],list2)

#5
def inverted_list(list):
    if list == []:
        return []

    list.reverse()

    return list

#6
def list_capicua(list):
    if list == []:
        return []
    
    return list == inverted_list(list)
#7
def concatListOfLists(listOfLists):
    if (listOfLists == []):
        return []
    
    return [listOfLists[0]]+concatListOfLists(listOfLists[1:])

#8
def replaceElem_list(list,elem1,elem2):
    if (list == []):
        return []

    if list[0] == elem1:
        list[0] = elem2
    
    return [list[0]]+replaceElem_list(list[1:],elem1,elem2)
    
#9 (iterative way)
def orderd_list(list1,list2):
    if list1 == []:
        return list2
    
    list1.extend(list2)
    sorted(list1)
    return list1

#10

def sub_list(list):
    if(list == []):
        return [[]]

    total = sub_list(list[1:])

    return total + [[list[0]] + y for y in total]

#-----------------------------------#


def main():
    
    list1 = [1,2,3,4,5,6,7,8]
    list2 = [10,11,11,10]
    list3 = [1,2,3]
    listOfLists = [14,list1,list2]
    emptyList = []

    #1
    print(listLength(list1))
    print(listLength(list2))

    #2
    print(listSum(list1))
    print(listSum(list2))

    #3
    print(findValue(list1,12))
    print(findValue(list2,12))

    #4
    print(listsConcat(list1,list2))

    #5
    print(inverted_list(list1))
    print(inverted_list(list2))

    #6
    print(list_capicua(list1)) #suposto dar falso ? 
    print(list_capicua(list2))

    #7
    print(concatListOfLists(listOfLists)) #kinda ?

    #8
    print(replaceElem_list(list1,2,11))
    print(replaceElem_list(list2,10,11))

    #9
    print(orderd_list(list1,list2))

    #10
    print(sub_list(list3))

   

if __name__ == "__main__":
    main()

