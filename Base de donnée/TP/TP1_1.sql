DROP SEQUENCE IF EXISTS NumeroNageur;
CREATE SEQUENCE NumeroNageur START 101;

DROP SEQUENCE IF EXISTS CategorieEpreuveID;
CREATE SEQUENCE CategorieEpreuveID;

DROP SEQUENCE IF EXISTS NumeroOfficiel;
CREATE SEQUENCE NumeroOfficiel;

DROP TABLE IF EXISTS CLUB CASCADE;
create table CLUB (
    NomClub VARCHAR(50),
    Region VARCHAR(100),
    PRIMARY KEY(NomClub)
);

DROP TABLE IF EXISTS NAGEUR CASCADE;
create table NAGEUR (
    NumeroNag INTEGER,
    NomNag VARCHAR(50),
    PrenomNag VARCHAR(50),
    AnneeDeNaissance INTEGER,
    Sexe VARCHAR(1),
    NomClub VARCHAR(50),
    PRIMARY KEY (NumeroNag), 
    FOREIGN KEY (NomClub) REFERENCES CLUB (NomClub)
);
 
DROP TABLE IF EXISTS CATEGORIE_EPREUVE CASCADE;
create table CATEGORIE_EPREUVE (
    NumeroEpreuve INTEGER PRIMARY KEY,
    TypeEpreuve VARCHAR(50) NOT NULL,
    NiveauEpreuve VARCHAR(50) NOT NULL,
    CONSTRAINT TypeEpreuveConstraint CHECK(TypeEpreuve='Parcours à sec' or TypeEpreuve='Propulsion technique' or TypeEpreuve='Technique'),
    CONSTRAINT NiveauEpreuveConstraint CHECK(NiveauEpreuve='Synchro Découverte' or NiveauEpreuve='Synchro Argent' or NiveauEpreuve='Synchro Or')
);

DROP TABLE IF EXISTS OFFICIEL CASCADE;
create table OFFICIEL (
    NumeroJuge INTEGER PRIMARY KEY,
    NomJuge VARCHAR(50),
    PrenomJuge VARCHAR(50),
    Degre VARCHAR(1) DEFAULT 'D',
    NomClub VARCHAR(50),
    FOREIGN KEY (NomClub) REFERENCES CLUB(NomClub),
    CONSTRAINT DegreConstraint CHECK(Degre='A' or Degre='B' or Degre='C' or Degre='D')
);

DROP TABLE IF EXISTS RESULTAT CASCADE;
create table RESULTAT (
    Annee INTEGER,
    Note FLOAT CHECK (Note>=0 AND Note <=10),
    NumeroNag INTEGER,
    NumeroEpreuve INTEGER,
    NumeroJuge INTEGER,
    FOREIGN KEY (NumeroNag) REFERENCES NAGEUR(NumeroNag) on delete CASCADE,
    FOREIGN KEY (NumeroEpreuve) REFERENCES CATEGORIE_EPREUVE(NumeroEpreuve),
    FOREIGN KEY (NumeroJuge) REFERENCES OFFICIEL(NumeroJuge),
    PRIMARY KEY (NumeroNag, NumeroEpreuve, Annee, NumeroJuge)
);



INSERT INTO CLUB VALUES('Angers Nat Synchro', 'Pays de la Loire');
INSERT INTO CLUB VALUES('Leo Lagrange Nantes', 'Pays de la Loire');
select * from CLUB;

INSERT INTO NAGEUR VALUES(nextval('NumeroNageur'), 'ROBERT', 'Léna', 2006, 'F', 'Angers Nat Synchro');
INSERT INTO NAGEUR VALUES(nextval('NumeroNageur'), 'CHAFFES', 'Lila', 2006, 'F', 'Angers Nat Synchro');
INSERT INTO NAGEUR VALUES(nextval('NumeroNageur'), 'LECOURT', 'Clément', 2008, 'F', 'Angers Nat Synchro');

select * from NAGEUR;

INSERT INTO OFFICIEL VALUES(nextval('NumeroOfficiel'), 'BOZEC', 'Rachel', default, 'Leo Lagrange Nantes');
INSERT INTO CATEGORIE_EPREUVE VALUES(nextval('CategorieEpreuveID'), 'Propulsion technique', 'Synchro Or');

INSERT INTO RESULTAT VALUES(
    2023, 
    7.8, 
    (SELECT NumeroNag FROM NAGEUR 
        WHERE NomNag='CHAFFES' AND PrenomNag='Lila' 
            AND AnneeDeNaissance=2006 AND NomClub='Angers Nat Synchro'),
    (SELECT NumeroEpreuve FROM CATEGORIE_EPREUVE 
        WHERE TypeEpreuve='Propulsion technique' AND NiveauEpreuve='Synchro Or'),
    (SELECT NumeroJuge FROM OFFICIEL
        WHERE NomJuge='BOZEC' AND PrenomJuge='Rachel' AND NomClub='Leo Lagrange Nantes')
);

SELECT * from RESULTAT;

UPDATE OFFICIEL SET Degre='A' WHERE NomJuge='BOZEC' AND PrenomJuge='Rachel' AND NomClub='Leo Lagrange Nantes';
 
SELECT * FROM OFFICIEL;
    
ALTER TABLE CATEGORIE_EPREUVE DROP CONSTRAINT NiveauEpreuveConstraint;
ALTER TABLE CATEGORIE_EPREUVE ADD CONSTRAINT NiveauEpreuveConstraint CHECK(NiveauEpreuve='Synchro Découverte' or NiveauEpreuve='Synchro Argent' or NiveauEpreuve='Synchro Or');

DELETE FROM NAGEUR WHERE NomNag='CHAFFES' AND PrenomNag='Lila' 
            AND AnneeDeNaissance=2006 AND NomClub='Angers Nat Synchro';

SELECT * FROM NAGEUR;

DROP TABLE IF EXISTS CLUB CASCADE;