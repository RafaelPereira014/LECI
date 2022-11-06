
#2.1
def separar(list):
    if (list == []):
        return [],[]
    
    a = separar(list[1:])

    return [list[0][0]]+a[0],[list[0][1]]+a[1]

#2.2

def remove_e_conta(list,elem):
    if (list == []):
        return [],0
    else:
        (tmp,count) = remove_e_conta(list[1:],elem)
    
        if list[0] == elem:
            return tmp,count+1
        else:
            return [list[0]]+tmp,count
    
#2.3






#----------------------#
def main():

    list1=[(1,2),(3,4),(5,6)]
    list2=[1,2,3,4,5,6,7]
    elem=2

    print(separar(list1))
    print(remove_e_conta(list2,elem))

if __name__ == "__main__":
    main()
