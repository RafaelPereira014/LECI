CREATE SCHEMA Empresa;
go

CREATE TABLE Empresa.DEPARTMENT (
	Dname   VARCHAR(15)     NOT NULL,
	Dnumber INT             NOT NULL,
	Mgr_ssn CHAR(9),
	Mgr_start_date DATE,
	PRIMARY KEY (Dnumber)
);


CREATE TABLE Empresa.EMPLOYEE (
	Fname   VARCHAR(15)     NOT NULL,
	Minit   CHAR,
	Lname   VARCHAR(15)     NOT NULL,
	Ssn     CHAR(9)         NOT NULL,
	Bdate   DATE,
	Address VARCHAR(30),
	Sex     CHAR,
	Salary  DECIMAL(10,2),
	Super_ssn CHAR(9),
	Dno     INT             NOT NULL,
	PRIMARY KEY (Ssn),
	FOREIGN KEY (Dno) REFERENCES Empresa.DEPARTMENT(Dnumber)
);

CREATE TABLE Empresa.DEPENDENT(
	Essn    CHAR(9)         NOT NULL,
	Dependent_name VARCHAR(15) NOT NULL,
	Sex     CHAR,
	Bdate   DATE,
	Relationship VARCHAR(8),
	PRIMARY KEY (Essn, Dependent_name),
	FOREIGN KEY (Essn) REFERENCES Empresa.EMPLOYEE (Ssn)
);

CREATE TABLE Empresa.DEPT_LOCATIONS(
	Dnumber INT             NOT NULL,
	Dlocation VARCHAR(15)   NOT NULL,
	PRIMARY KEY (Dnumber, Dlocation),
	FOREIGN KEY (Dnumber) REFERENCES Empresa.DEPARTMENT(Dnumber)
);

CREATE TABLE Empresa.PROJECT(
	Pname		VARCHAR(45)		NOT NULL,
	Pnumber		INT				CHECK(Pnumber> 0),
	Plocation	VARCHAR(15)		NOT NULL,
	Dnum		INT				NOT NULL,

	PRIMARY KEY (Pnumber),
	FOREIGN KEY (Dnum) REFERENCES Empresa.DEPARTMENT (Dnumber)
);
CREATE TABLE Empresa.WORKS_ON(
	Essn	CHAR(9),
	Pno		INT,
	[Hours]	DECIMAL(4,2)	NOT NULL,

	PRIMARY KEY (Essn,Pno),
	FOREIGN KEY (Pno) REFERENCES Empresa.PROJECT (Pnumber),
	FOREIGN KEY (Essn) REFERENCES Empresa.EMPLOYEE (Ssn)
);


