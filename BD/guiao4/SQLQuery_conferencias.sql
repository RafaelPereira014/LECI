CREATE SCHEMA conferencias;
 go

 CREATE TABLE conferencias.instituicao(
    endereco VARCHAR(30) NOT NULL PRIMARY KEY,
    nome VARCHAR(20)
 );

 CREATE TABLE conferencias.pessoa(
    nome VARCHAR(20),
    endereco_mail VARCHAR(20) NOT NULL PRIMARY KEY,
    endereco VARCHAR(30) NOT NULL REFERENCES conferencias.instituicao(endereco)
 );

CREATE TABLE conferencias.autor(
    endereco_mail varchar(20) NOT NULL REFERENCES conferencias.pessoa(endereco_mail),
    PRIMARY KEY(endereco_mail)
);

CREATE TABLE conferencias.participante(
    endereco_mail varchar(20) NOT NULL REFERENCES conferencias.pessoa(endereco_mail),
    PRIMARY KEY(endereco_mail)
); 


CREATE TABLE conferencias.artigo_cientifico(
    titulo varchar(20) NOT NULL,
    num_regist INT NOT NULL PRIMARY KEY
);

CREATE TABLE conferencias.tem(
    num_registo INT NOT NULL REFERENCES conferencias.artigo_cientifico(num_regist),
    endereco_mail varchar(20) NOT NULL REFERENCES conferencias.autor(endereco_mail),
    PRIMARY KEY(num_registo,endereco_mail)
 );


CREATE TABLE conferencias.estudante(
    localizacao_comprovativo VARCHAR(20),
    endereco_mail varchar(20) NOT NULL REFERENCES conferencias.participante(endereco_mail) PRIMARY KEY
);

CREATE TABLE conferencias.n_estudante(
    ref_transacao_bancaria INT,
    endereco_mail varchar(20) NOT NULL REFERENCES conferencias.participante(endereco_mail) PRIMARY KEY
);