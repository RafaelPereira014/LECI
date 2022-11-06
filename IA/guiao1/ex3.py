
#3.3(homólogos - elementos da mesma posição)
def homologos(list1,list2):
    if list1 == []:
        return list2
    
    if list2 == []:
        return list1
    
    if list1 == [] and list2 == []:
        return None
    
    return [(list1[0],list2[0])]+homologos(list1[1:],list2[1:])

#---------------------------#
def main():
    list1=[1,2,3]
    list2=[3,4,5]

    print(homologos(list1,list2))

if __name__ == "__main__":
    main()