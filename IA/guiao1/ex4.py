#4.1

test = lambda x: True if ( (x%2)!=0 ) else False
print(test(10))

#4.2

test2 = lambda x: True if (x>0) else False
print(test2(-4))

#4.3
test3 = lambda x,y: True if abs(x)<abs(y) else False
print(test3(-2,3))

#4.4

#4.5
functs = lambda f,g,h: lambda x,y,z : h(f(x,y),g(y,z))

#4.6
func = lambda lista,f : True if f == True else False
print(func([1,2,3],True))

#4.10
def smallerAndOther(lista,compare):
    elem = min(lista)
    otherElem = [e for e in lista if e!= elem]
    return elem,otherElem

print(smallerAndOther([1,-6,3],lambda x,y:x<y))

