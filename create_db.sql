CREATE TABLE artysta (
  nr INT PRIMARY KEY,
  imie VARCHAR(50),
  nazwisko VARCHAR(100) NOT NULL,
  miasto VARCHAR(50),
  kod_pocztowy CHAR(6),
  ulica_dom VARCHAR(100),
  nr_tel VARCHAR(11),
);

CREATE TABLE klient (
  nr INT PRIMARY KEY,
  imie VARCHAR(50),
  nazwisko VARCHAR(100) NOT NULL,
  miasto VARCHAR(50),
  kod_pocztowy CHAR(6),
  ulica_dom VARCHAR(100),
  nr_tel VARCHAR(11),
);

CREATE TABLE kurator (
  nr INT PRIMARY KEY,
  imie VARCHAR(50),
  nazwisko VARCHAR(100) NOT NULL,
  miasto VARCHAR(50),
  kod_pocztowy CHAR(6),
  ulica_dom VARCHAR(100),
  nr_tel VARCHAR(11),
);

CREATE TABLE galeria (
  nr INT PRIMARY KEY,
  miasto VARCHAR(50) NOT NULL,
  kod_pocztowy CHAR(6) NOT NULL,
  ulica_dom VARCHAR(100) NOT NULL,
  nr_tel VARCHAR(11) NOT NULL,
);

CREATE TABLE zamowienie_kupna (
  nr INT PRIMARY KEY,
  nr_klient INT NOT NULL,
  data_zlozenia DATE NOT NULL,
  data_realizacji DATE,
  CONSTRAINT zam_kup_fk FOREIGN KEY(nr_klient) REFERENCES klient(nr)
);

CREATE TABLE typ_dziela (
  id SERIAL PRIMARY KEY,
  forma VARCHAR(50) NOT NULL,
  material VARCHAR(50) NOT NULL,
  UNIQUE (forma, material)
);

CREATE TABLE dzielo (
  nr INT PRIMARY KEY,
  tytul VARCHAR(64) NOT NULL,
  typ_id INT NOT NULL,
  rok INT,
  cena NUMERIC(10, 2),
  sprzedaz_nr INT,
  CONSTRAINT dzielo_fk FOREIGN KEY (sprzedaz_nr) REFERENCES zamowienie_kupna(nr),
  CONSTRAINT dzielo_typ_fk FOREIGN KEY (typ) REFERENCES typ_dziela(id)
);

CREATE TABLE artysta_dzielo (
  nr_artysta INT NOT NULL,
  nr_dzielo INT NOT NULL,
  PRIMARY KEY(nr_artysta, nr_dzielo),
  CONSTRAINT artysta_dzielo_artysta_fk FOREIGN KEY (nr_artysta) REFERENCES artysta(nr),
  CONSTRAINT artysta_dzielo_dzielo_fk FOREIGN KEY (nr_dzielo) REFERENCES dzielo(nr)
);

CREATE TABLE wystawa (
  nr INT PRIMARY KEY,
  tytul VARCHAR(100) NOT NULL,
  data_rozp DATE NOT NULL,
  data_zak DATE NOT NULL,
  cena_biletu NUMERIC(10, 2),
  sprzedane_bilety INT,
  nr_kurator INT NOT NULL,
  nr_galeria INT NOT NULL,
  CONSTRAINT wystawa_galeria_fk FOREIGN KEY (nr_galeria) REFERENCES galeria(nr),
  CONSTRAINT wystawa_kurator_fk FOREIGN KEY (nr_kurator) REFERENCES kurator(nr)
);

CREATE TABLE dziela_na_wystawie (
  nr_wystawa INT REFERENCES wystawa(nr),
  nr_dzielo INT REFERENCES dzielo(nr),
  PRIMARY KEY(nr_wystawa, nr_dzielo)
);

CREATE TABLE zamowienie_wynajem (
  nr INT PRIMARY KEY,
  nr_klient DATE NOT NULL,
  od_kiedy DATE NOT NULL,
  do_kiedy DATE NOT NULL,
  CONSTRAINT zam_wynajem_klient_fk FOREIGN KEY(nr_klient) REFERENCES klient(nr)
);

CREATE TABLE wynajem_dzielo (
  nr_wynajem INT NOT NULL,
  nr_dzielo INT NOT NULL,
  cena_za_dzien NUMERIC(10, 2),
  PRIMARY KEY(nr_wynajem, nr_dzielo),
  CONSTRAINT wynajem_nr_fk FOREIGN KEY(nr_wynajem) REFERENCES zamowienie_wynajem(nr),
  CONSTRAINT wynajem_dzielo_fk FOREIGN KEY(nr_dzielo) REFERENCES dzielo(nr)
);