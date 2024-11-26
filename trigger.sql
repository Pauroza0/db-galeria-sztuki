--Sprawdzenie czy dzieło ma cenę (jest na sprzedaż), przy próbie przypisania go do zamówienia kupna
CREATE OR REPLACE FUNCTION check_czy_dzielo_jest_na_sprzedaz()
RETURNS TRIGGER AS $$
BEGIN
    IF NEW.sprzedaz_nr IS NOT NULL AND NEW.cena IS NULL THEN
        RAISE EXCEPTION 'Cena nie może być NULL, jeśli dzieło ma być sprzedane';
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER check_cena_trigger
BEFORE INSERT OR UPDATE ON dzielo
FOR EACH ROW EXECUTE FUNCTION check_czy_dzielo_jest_na_sprzedaz();

--Sprawdzenie czy czas wystawy nie pokrywa się z datami innych wystaw/wynajmów, które dotyczą tego dzieła
CREATE OR REPLACE FUNCTION check_wystawa_czy_dzielo_jest_dostepne()
RETURNS TRIGGER AS $$
DECLARE
    wystawa_data_rozp DATE;
    wystawa_data_zak DATE;
BEGIN
    SELECT w.data_rozp, w.data_zak 
    INTO wystawa_data_rozp, wystawa_data_zak
    FROM wystawa w 
    WHERE w.nr = NEW.nr_wystawa;

    IF EXISTS (
        --Sprawdzenie konfliktu z wynajmem
        SELECT 1
        FROM wynajem_dzielo wd
        JOIN zamowienie_wynajem zw ON wd.nr_wynajem = zw.nr
        WHERE wd.nr_dzielo = NEW.nr_dzielo
        AND (zw.od_kiedy, zw.do_kiedy) OVERLAPS (wystawa_data_rozp, wystawa_data_zak)
    ) OR EXISTS (
        --Sprawdzenie konfliktu z inną wystawą
        SELECT 1
        FROM dziela_na_wystawie dnw
        JOIN wystawa w ON dnw.nr_wystawa = w.nr
        WHERE dnw.nr_dzielo = NEW.nr_dzielo
        AND dnw.nr_wystawa <> NEW.nr_wystawa
        AND (w.data_rozp, w.data_zak) OVERLAPS (wystawa_data_rozp, wystawa_data_zak)
    ) THEN
        RAISE EXCEPTION 'Dzieło nie może być na wystawie i wynajmowane lub na innej wystawie w tym samym czasie';
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER check_wystawa_czy_dzielo_jest_dostepne
BEFORE INSERT ON dziela_na_wystawie
FOR EACH ROW EXECUTE FUNCTION check_wystawa_czy_dzielo_jest_dostepne();

--Sprawdzenie czy czas wynajmu nie pokrywa się z datami innych wystaw/wynajmów, które dotyczą tego dzieła
CREATE OR REPLACE FUNCTION check_wynajem_czy_dzielo_jest_dostepne()
RETURNS TRIGGER AS $$
DECLARE
    wynajem_od_kiedy DATE;
    wynajem_do_kiedy DATE;
BEGIN
    SELECT zw.od_kiedy, zw.do_kiedy 
    INTO wynajem_od_kiedy, wynajem_do_kiedy 
    FROM zamowienie_wynajem zw 
    WHERE zw.nr = NEW.nr_wynajem;

    IF EXISTS (
        --Sprawdzenie konfliktu z wystawą
        SELECT 1
        FROM dziela_na_wystawie dnw
        JOIN wystawa w ON dnw.nr_wystawa = w.nr
        WHERE dnw.nr_dzielo = NEW.nr_dzielo
        AND (w.data_rozp, w.data_zak) OVERLAPS (wynajem_od_kiedy, wynajem_do_kiedy)
    ) OR EXISTS (
        --Sprawdzenie konfliktu z innym wynajmem
        SELECT 1
        FROM wynajem_dzielo wd
        JOIN zamowienie_wynajem zw ON wd.nr_wynajem = zw.nr
        WHERE wd.nr_dzielo = NEW.nr_dzielo
        AND wd.nr_wynajem <> NEW.nr_wynajem
        AND (zw.od_kiedy, zw.do_kiedy) OVERLAPS (wynajem_od_kiedy, wynajem_do_kiedy)
    ) THEN
        RAISE EXCEPTION 'Dzieło nie może być wynajmowane i na wystawie lub wynajmowane w tym samym czasie';
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER check_wynajem_czy_dzielo_jest_dostepne
BEFORE INSERT ON wynajem_dzielo
FOR EACH ROW EXECUTE FUNCTION check_wynajem_czy_dzielo_jest_dostepne();