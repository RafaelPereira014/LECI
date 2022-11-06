#encoding: utf8
from os import TMP_MAX
from threading import local
from semantic_network import *
from bayes_net import *
from collections import Counter
import math


class MySemNet(SemanticNetwork):
    def __init__(self):
        SemanticNetwork.__init__(self)
        # IMPLEMENT HERE (if needed)
        pass

    def source_confidence(self,user):
        # IMPLEMENT HERE
        correto = 0
        incorreto = 0
        dcl = list(set([d.relation for d in self.query_local(user=user)
                         if d.relation.__class__.__name__=="AssocOne"]))
        
        for i in dcl:
            tmp = list(([c.relation.entity2 for c in self.query_local(e1=i.entity1, relname=i.name)]))
            
            occurrences = dict()

            for item in tmp:
                occurrences[item] = occurrences.setdefault(item, 0) + 1

            maxs = [a for a, b in occurrences.items() if b == max(occurrences.values())]
            
            if i.entity2 in maxs:
                correto+=1
            else:
                incorreto+=1
                
        confidence = self.conf(correto,incorreto)
        
        return confidence
    
    def conf(self,correct,wrong):
        return (1-(math.pow(0.75,correct)))*math.pow(0.75,wrong)

    def query_with_confidence(self,entity,assoc):
        parents =  { d.relation.entity2 for d in self.query_local(e1=entity) if isinstance(d.relation, Member) or isinstance(d.relation, Subtype) }

        assocs = [ d.relation.entity2 for d in self.query_local(e1=entity, relname=assoc) if isinstance(d.relation, AssocOne) or isinstance(d.relation, AssocSome) ]

        T = len(assocs)
        mc = Counter(assocs)

        dict = {}
        parents_dict = {}

        for i in assocs:
            n = mc.get(i)
            tmp = self.conf2(n,T)
            dict[i] = tmp

        for p in parents:
          
            p_confidence = self.query_with_confidence(p, assoc)

            for decl in p_confidence:
                if decl not in parents_dict:
                    parents_dict[decl] = p_confidence[decl]
                else:
                    parents_dict[decl] += p_confidence[decl]

        for x in parents_dict:
            parents_dict[x] = parents_dict[x] / len(parents)
        
        if not dict:
            parents_dict = {c:parents_dict[c]*0.9 for c in parents_dict}
            return parents_dict

        return dict
    
    def conf2(self,n,T):
        return (n/(2*T)) + (1-(n/(2*T)))*(1-pow(0.95, n))*pow(0.95, T-n)

class MyBN(BayesNet):

    def __init__(self):
        BayesNet.__init__(self)
        # IMPLEMENT HERE (if needed)
        pass

    def individual_probabilities(self):
            variables = list(self.dependencies)       
            res = {}

            for var in variables:
                prob = 0
                anc = self.ancs(var) 
                lcomb = [ c+[(var,True)] for c in self.Combination(anc) ]   
                                                                        
                for conj in lcomb:
                    prob += self.jointProb(conj)             

                res[var] = prob

            return res

    def ancs(self, var):
        lvars = [ v for (v,x) in list(self.dependencies[var].keys())[0] ]   
        lvars2 = lvars

        for v in lvars:
            lvars2 += self.ancs(v)     

        return list(set(lvars2))

    
    def Combination(self, lvars):                          
        if lvars == []:
            return [[]]
        recursive = self.Combination(lvars[1:])                  
        v = lvars[0]
        return [ c+[(v,True)] for c in recursive ] + [ c+[(v,False)] for c in recursive ] 

   


