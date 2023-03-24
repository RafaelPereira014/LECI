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

γ department.Dname; avg(employee.Salary) -> salarioMedio (σ employee.Sex = 'F' (department ⨝ (Dnumber = Dno) employee))


### *g)* 

σ Dependentes ≥ 3 (γ Fname, Minit, Lname; count(Essn) -> Dependentes (employee ⨝ (Ssn = Essn) dependent))


### *h)* 

π Fname, Minit, Lname, Ssn, Dno (σ Essn = null (dependent ⟖ (Essn = Ssn) (employee ⨝ (Ssn = Mgr_ssn) department)))



### *i)* 

π Fname, Minit, Lname, Address (employee ⨝ (σ Plocation = 'Aveiro' (project ⨝ works_on )) ⨝ (σ Dlocation ≠ 'Aveiro' (employee ⨝ (Dno = Dnumber) dept_location)))


## ​Problema 5.2

### *a)*

 π nome (σ  fornecedor = null ( fornecedor ⟕ (nif = fornecedor) encomenda)) 

### *b)* 

γ nome; avg(item.unidades) -> unidades (produto ⨝ (codigo = codProd) item)


### *c)* 

γ ;avg(numProd)-> media (γ numEnc;count(codProd) -> numProd (item))

### *d)* 

 π fornecedor.nome, produto.nome, item.unidades (produto ⨝ (produto.codigo = codProd) (fornecedor ⨝ (nif = fornecedor) (encomenda ⨝ (numero = numEnc) item)))

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

farmaceutica⨝(numRegFarm=numReg) (γ farmacia.nome, presc_farmaco.numRegFarm; count(presc_farmaco.nomeFarmaco)->FarmVendidos (presc_farmaco⨝(presc_farmaco.numPresc=prescricao.numPresc) ((farmacia⨝(nome=farmacia) prescricao))))


### *f)* 

σ Medicos>1 (γ paciente.nome; count(prescricao.numMedico)->Medicos (paciente⨝prescricao))