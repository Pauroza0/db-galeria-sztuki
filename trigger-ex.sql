--próba check_cena
INSERT into dzielo(tytul, nr_typ, rok, cena, sprzedaz_nr) VALUES ('Ryby w gazie', 10, 2024, NULL, 3);
UPDATE dzielo SET sprzedaz_nr = 4 WHERE nr = 11;

--próba triggera - check_wystawa_czy_dzielo_jest_dostepne
INSERT INTO dziela_na_wystawie(nr_wystawa, nr_dzielo) VALUES (2, 1); --dzielo juz na innej wystawie w tym czasie
INSERT INTO dziela_na_wystawie(nr_wystawa, nr_dzielo) VALUES (1, 7); --dzielo wynajmowane w czasie wystawy


--próba triggera - check_wynajem_czy_dzielo_jest_dostepne
INSERT INTO wynajem_dzielo(nr_wynajem, nr_dzielo, cena_za_dzien) VALUES (4, 7, 66.00); -- dzielo wynajmowane w tym czasie
INSERT INTO wynajem_dzielo(nr_wynajem, nr_dzielo, cena_za_dzien) VALUES (1, 11, 90.00); -- dzielo na wystawie w tym czasie
