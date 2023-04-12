CREATE SCHEMA Prescricao;
GO

CREATE TABLE Prescricao.Medico(
    numSNS              INT         PRIMARY KEY,
    nome                VARCHAR(45) NOT NULL,
    especialidade       VARCHAR(45),                      
);

CREATE TABLE Prescricao.Paciente(
    numUtente           INT         PRIMARY KEY,
    nome                VARCHAR(45) NOT NULL,
    dataNasc            DATE        NOT NULL,
    endereco            TEXT,
);

CREATE TABLE Prescricao.Farmacia(
    nome                VARCHAR(45) PRIMARY KEY,
    telefone            INT         UNIQUE,
    endereco            TEXT,                      
);

CREATE TABLE Prescricao.Farmaceutica(
    numReg              INT         PRIMARY KEY,
    nome                VARCHAR(45),
    endereco            TEXT,                      
);

CREATE TABLE Prescricao.Farmaco(
    numRegFarm          INT,
    nome                VARCHAR(45),
    formula             TEXT,      
	FOREIGN KEY (numRegFarm)REFERENCES Prescricao.Farmaceutica(numReg),
    PRIMARY KEY (numRegFarm, nome)
	
);

CREATE TABLE Prescricao.Prescricao(
    numPresc            INT         PRIMARY KEY,
    dataProc            DATE,
	numUtente           INT         NOT NULL REFERENCES Prescricao.Paciente(numUtente),
    numMedico           INT         NOT NULL REFERENCES Prescricao.Medico(numSNS),
    farmacia            VARCHAR(45) REFERENCES Prescricao.Farmacia(nome)
);

CREATE TABLE Prescricao.Presc_farmaco(
    numPresc            INT	REFERENCES Prescricao.Prescricao(numPresc),
    numRegFarm          INT,
    nomeFarmaco         VARCHAR(45),
    FOREIGN KEY (numRegFarm, nomeFarmaco) REFERENCES Prescricao.Farmaco(numRegFarm, nome),
    PRIMARY KEY (numPresc, numRegFarm, nomeFarmaco)
);