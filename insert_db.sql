INSERT INTO artysta (imie, nazwisko, miasto, kod_pocztowy, ulica_dom, nr_tel) VALUES
(NULL, 'Kowalski', 'Warszawa', '00-001', 'Aleje Jerozolimskie 10', '123456789'),
('Anna', 'Nowak', 'Kraków', '30-001', 'Rynek Główny 20', '987654321'),
('Piotr', 'Wiśniewski', 'Gdańsk', '80-001', 'Długa 15', '112233445'),
('Maria', 'Zielińska', 'Poznań', '60-001', 'Święty Marcin 30', '556677889'),
('Tomasz', 'Kaczmarek', 'Wrocław', '50-001', 'Plac Grunwaldzki 5', '665544332'),
('Ewa', 'Mazur', 'Łódź', '90-001', 'Piotrkowska 40', '774411223'),
('Michał', 'Lewandowski', 'Szczecin', '70-001', 'Wały Chrobrego 8', NULL);

INSERT INTO klient (imie, nazwisko, miasto, kod_pocztowy, ulica_dom, nr_tel) VALUES
('Katarzyna', 'Domańska', 'Lublin', '20-001', 'Narutowicza 15', '111222333'),
('Grzegorz', 'Szymański', 'Rzeszów', '35-001', '3 Maja 10', '222333444'),
('Łukasz', 'Kamiński', 'Opole', '45-001', 'Krakowska 25', '333444555'),
('Magdalena', 'Woźniak', 'Bydgoszcz', '85-001', 'Gdańska 30', '444555666'),
('Paweł', 'Nowacki', 'Zielona Góra', '65-001', 'Wrocławska 5', '555666777'),
('Joanna', 'Czarnecka', 'Kielce', '25-001', 'Sienkiewicza 40', '666777888'),
('Marcin', 'Pawlak', 'Radom', '26-600', 'Żeromskiego 12', '777888999');

INSERT INTO kurator (imie, nazwisko, miasto, kod_pocztowy, ulica_dom, nr_tel) VALUES
('Agnieszka', 'Zalewska', 'Gdynia', '81-001', 'Świętojańska 50', '888999111'),
('Rafał', 'Kowal', 'Legnica', '59-220', 'Mickiewicza 8', '999111222'),
('Kinga', 'Nowicka', 'Elbląg', '82-300', 'Grunwaldzka 18', '111222333'),
('Mariusz', 'Lis', 'Słupsk', '76-200', 'Kościuszki 22', '222333444');


INSERT INTO galeria (miasto, kod_pocztowy, ulica_dom, nr_tel) VALUES 
('Gdańsk', '80-001', 'Długa 50', '123123123'),
('Warszawa','00-002','Nowy Świat 10','456456456'),
('Wrocław','50-002','Wita Stwosza 15','789789789');

INSERT INTO typ_dziela (forma, material) VALUES
('Obraz', 'Akryl'),
('Obraz', 'Olej'),
('Obraz', 'Akwarela'),
('Obraz', 'Pastele'),
('Rzeźba', 'Metal'),
('Rzeźba', 'Gips'),
('Rzeźba', 'Drewno'),
('Performance', 'brak'),
('Fotografia', 'brak'),
('Instalacja', 'Metal');

INSERT INTO zamowienie_kupna (nr_klient, data_zlozenia, data_realizacji) VALUES
(1, '2024-01-01', '2024-02-03'),
(1, '2024-01-15', '2024-02-03'),
(2, '2024-04-05', '2024-05-04'),
(3, '2024-05-10', NULL);

INSERT INTO dzielo (tytul, nr_typ, rok, cena, sprzedaz_nr) VALUES
('Świt na jeziorze', 1, 2023, 5550.00, 1),
('Zimowa nostalgia', 3, 2024, 6450.00, 1),
('Portret damy', 2, 2010, 11250.00, 2),
('Pamięć natury', 5, 2014, 4895.50, 2),
('Rytm miasta', 5, 2018, 7830.00, 3),
('Ekspresja kolorów', 6, 2010, 34000.00, 4),
('Wschód słońca w górach', 9, 2020, 2500.00, NULL),
('Abstrakcja 101', 8, 2021, NULL, NULL),
('Spacer nad morzem', 4, NULL, 5780.00, NULL),
('Ścieżki wspomnień', 7, 2014, NULL, NULL),
('Martwa natura z jabłkami', 2, 2003, NULL, NULL);


INSERT INTO artysta_dzielo (nr_artysta, nr_dzielo) VALUES
(1, 1),
(1, 2),
(2, 3),
(7, 3),
(4, 4),
(5, 4),
(5, 5),
(3, 6),
(5, 7),
(6, 8),
(6, 9),
(5, 10),
(6, 10),
(5, 11);

INSERT INTO wystawa (tytul, data_rozp, data_zak, cena_biletu, sprzedane_bilety, nr_kurator, nr_galeria) VALUES
('Kolory emocji', '2024-01-01', '2024-01-31', 50.00, 258, 1, 1),
('Przestrzeń i harmonia', '2024-01-15', '2024-01-31', 90.00, 687, 2, 2),
('Sztuka w ruchu', '2024-03-01', '2024-04-30', 90.00, 300, 1, 3),
('Puszki', '2030-05-01', '2030-05-31', NULL, NULL, 3, 1);

INSERT INTO dziela_na_wystawie (nr_wystawa, nr_dzielo) VALUES
(1, 1),
(1, 2),
(1, 3),
(1, 4),
(2, 11),
(2, 10),
(2, 9),
(3, 7),
(3, 6),
(3, 10),
(3, 11);

INSERT INTO zamowienie_wynajem (nr_klient, od_kiedy, do_kiedy) VALUES
(5, '2024-01-01', '2024-01-15'),
(5, '2024-05-15', '2024-05-31'),
(1, '2024-02-01', '2024-02-08'),
(6, '2024-01-01', '2024-01-10');

INSERT INTO wynajem_dzielo (nr_wynajem, nr_dzielo, cena_za_dzien) VALUES 
(1, 7, 66.00),
(1, 6, 90.00),
(2, 7, 66.00),
(3, 5, 90.00),
(3, 6, 95.00),
(4, 11, 66.00);