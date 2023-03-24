# BD: Guião 5


## ​Problema 5.1
 
### *a)*


π Fname,Lname,Ssn,Pno,Pname (employee⨝(Essn = Ssn) works_on ⨝ (Pno = Pnumber) project)


### *b)* 

ρ supervisor (π Ssn (σ Fname = 'Carlos'∧ Minit = 'D' ∧ Lname = 'Gomes' (employee))) ⨝ (Super_ssn = supervisor.Ssn) employee


### *c)* 

γ Pname; sum(Hours) -> total (project ⨝ (Pnumber = Pno) works_on )


### *d)* 

π Fname,Hours (σ Dno = 3 employee ⨝ (Ssn = Essn) works_on ⨝ (Pno = Pnumber ∧ Pname = 'Aveiro Digital' ∧ Hours>20) project)

### *e)* 

π Fname, Minit, Lname (σ Pno=null (employee ⟕ Ssn=Essn works_on))

### *f)* 

```
... Write here your answer ...
```


### *g)* 

```
... Write here your answer ...
```


### *h)* 

π Fname, Minit, Lname, Ssn, Dno (σ Essn = null (dependent ⟖ (Essn = Ssn) (employee ⨝ (Ssn = Mgr_ssn) department)))



### *i)* 

π Fname, Minit, Lname, Address (employee ⨝ (σ Plocation = 'Aveiro' (project ⨝ works_on )) ⨝ (σ Dlocation ≠ 'Aveiro' (employee ⨝ (Dno = Dnumber) dept_location)))


## ​Problema 5.2

### *a)*

```
... Write here your answer ...
```

### *b)* 

```
... Write here your answer ...
```


### *c)* 

```
... Write here your answer ...
```


### *d)* 

```
... Write here your answer ...
```


## ​Problema 5.3

### *a)*

π nome (( paciente) ⨝ σ prescricao.numPresc = null (paciente ⟕ (prescricao)))

### *b)* 

γ especialidade;count(especialidade) -> numero ((prescricao) ⨝ (numMedico = numSNS) (medico))

### *c)* 

γ prescricao.farmacia;count(prescricao.farmacia)->numero (prescricao ⨝ (nome=prescricao.farmacia) farmacia)

### *d)* 

σ numPresc = null (σ numRegFarm = 906 (farmaco) ⟗ (nome = nomeFarmaco) presc_farmaco)
### *e)* 

```
... Write here your answer ...
```

### *f)* 

```
... Write here your answer ...
```
