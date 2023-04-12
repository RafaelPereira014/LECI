----a)
SELECT Ssn, Fname, Lname, Pno FROM(Empresa.WORKS_ON JOIN Empresa.EMPLOYEE ON Essn=Ssn)
----b)
SELECT Fname,Lname FROM Empresa.EMPLOYEE WHERE Super_ssn=(SELECT Ssn FROM Empresa.EMPLOYEE WHERE Fname='Carlos' and Minit='D' and Lname='Gomes')
----c)
SELECT Pname, hours_workd FROM Empresa.PROJECT JOIN (SELECT Pno, SUM(Hours) AS hours_workd FROM Empresa.WORKS_ON GROUP BY Pno) AS Worked_Table ON Pnumber=Pno
----d)
SELECT Fname, Lname FROM Empresa.PROJECT JOIN Empresa.WORKS_ON ON Pnumber=Pno JOIN (SELECT Fname, Lname, Ssn FROM Empresa.EMPLOYEE WHERE Dno=3) AS employeesDEP3 ON Essn=Ssn WHERE Hours>20
----e)
SELECT Fname,Minit,Lname FROM Empresa.EMPLOYEE LEFT JOIN Empresa.WORKS_ON ON Essn=Ssn WHERE Pno IS NULL
----f)
SELECT Dname,AVG(Salary) as salario_medio FROM Empresa.DEPARTMENT JOIN (SELECT * FROM Empresa.EMPLOYEE WHERE Sex='F') as Dep_Females ON Dnumber=Dno GROUP BY Dname
----g)
SELECT Fname,Minit,Lname,DEP_QTY FROM Empresa.EMPLOYEE JOIN (SELECT Essn, Count(Essn) AS DEP_QTY FROM Empresa.DEPENDENT GROUP BY Essn HAVING COUNT(Essn)>1) AS TWO_OR_MORE ON Ssn=Essn
----h)
SELECT Fname,Minit,Lname FROM Empresa.DEPARTMENT JOIN ( SELECT Fname,Minit,Lname,Ssn FROM Empresa.EMPLOYEE LEFT JOIN Empresa.DEPENDENT ON Ssn=Essn WHERE Essn is NULL) as WITHOUT_DEP ON Mgr_ssn=Ssn
----i)
SELECT Fname, Minit, Lname, Address FROM Empresa.EMPLOYEE JOIN ( SELECT * FROM Empresa.PROJECT JOIN Empresa.DEPT_LOCATIONS ON Dnum=Dnumber WHERE Dlocation!='Aveiro' AND Plocation='Aveiro') AS PROJECTs
ON Dno=Dnum
