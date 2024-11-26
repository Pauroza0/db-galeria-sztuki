--Widok dla dzieł i ich autorów
CREATE VIEW widok_dziela_autorzy AS SELECT a.nr AS numer_artysty, imie, nazwisko, d.nr AS numer_dziela, tytul 
FROM (artysta a INNER JOIN artysta_dzielo ad ON a.nr = ad.nr_artysta)
INNER JOIN dzielo d ON d.nr = ad.nr_dzielo

--Wyszukaj dzieła i ich autorów
SELECT a.nr, imie, nazwisko, tytul 
FROM (artysta a INNER JOIN artysta_dzielo ad ON a.nr = ad.nr_artysta)
INNER JOIN dzielo d ON d.nr = ad.nr_dzielo 
ORDER BY d.tytul

--Użycie widoku do powyższego zapytania
SELECT numer_dziela, tytul 
FROM widok_dziela_autorzy 
WHERE numer_artysty = 1

--Wyszukaj dzieła konkretnego autora
SELECT d.nr, tytul
FROM (artysta a INNER JOIN artysta_dzielo ad ON a.nr = ad.nr_artysta)
INNER JOIN dzielo d ON d.nr = ad.nr_dzielo
WHERE A.nr = 1
ORDER BY d.tytul

--Wyszukaj dzieła, które są na sprzedaż
SELECT * FROM dzielo 
WHERE sprzedaz_nr IS NULL AND cena IS NOT NULL 

--Oblicz zysk ze sprzedaży biletów na minionych wystawach
SELECT nr, tytuł, sprzedane_bilety * cena_biletu AS zysk
FROM wystawa
WHERE data_zak < CURRENT_DATE

--Oblicz zysk ze sprzedaży biletów na wystawach, według kuratorów odpowiadających za wystawę
SELECT kurator.nr, imie, nazwisko, SUM(cena_biletu * sprzedane_bilety) AS zysk_z_wystaw
FROM kurator, wystawa
WHERE kurator.nr = wystawa.nr_kurator AND wystawa.data_zak < CURRENT_DATE
GROUP BY kurator.nr

--Wyszukaj dzieła, które nigdy nie były wystawiane i nie są sprzedane
SELECT nr, tytul, typ
FROM dzielo
WHERE nr NOT IN (SELECT nr_dzielo FROM dziela_na_wystawie) AND sprzedaz_nr IS NULL

--Oblicz zysk na dzien dla każdej wystawy
SELECT nr, tytul, (data_zak - data_rozp) AS czas_trwania, ROUND(((cena_biletu * sprzedane_bilety) / (data_zak - data_rozp)), 2) AS zysk_na_dzien 
FROM wystawa 
WHERE data_zak < CURRENT_DATE

--Wyszukaj wszystkie dzieła, które są obrazami
SELECT d.nr, d.tytul, t.material 
FROM dzielo d 
INNER JOIN typ_dziela t ON t.nr = d.nr_typ WHERE forma = 'Obraz'


--Widok niezrealizowanych zamówień i dzieł, których dotyczą
CREATE VIEW niezrealizowane_zamowienia_kupna AS
SELECT zk.nr as numer_zamowienia, k.nr AS numer_klienta, k.imie, k.nazwisko, d.nr AS numer_dziela, d.tytul 
FROM (klient k INNER JOIN zamowienie_kupna zk ON zk.nr_klient = k.nr)
INNER JOIN dzielo d ON d.sprzedaz_nr = zk.nr WHERE zk.data_realizacji IS NULL