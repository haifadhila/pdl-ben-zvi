-- A before B
-- A______A
--            B_____B
CREATE OR REPLACE FUNCTION public.allen_is_before(start_date1 date, end_date1 date, start_date2 date, end_date2 date) RETURNS BOOLEAN
    LANGUAGE plpgsql
    AS $$
BEGIN
   RETURN (end_date1 IS NOT NULL) AND (end_date1 < start_date2);
END; $$;

-- A after B
--           A______A
-- B_____B
CREATE OR REPLACE FUNCTION public.allen_is_after(start_date1 date, end_date1 date, start_date2 date, end_date2 date) RETURNS BOOLEAN
    LANGUAGE plpgsql
    AS $$
BEGIN
   RETURN (end_date2 IS NOT NULL) AND (end_date2 < start_date1);
END; $$;

-- A meet B
-- A______A
--        B_____B
CREATE OR REPLACE FUNCTION public.allen_is_meet(start_date1 date, end_date1 date, start_date2 date, end_date2 date) RETURNS BOOLEAN
    LANGUAGE plpgsql
    AS $$
BEGIN
   RETURN (end_date1 IS NOT NULL) AND (end_date1 == start_date2);
END; $$;

-- A meet inverse B
-- B______B
--        A_____A
CREATE OR REPLACE FUNCTION public.allen_is_meet_inverse(start_date1 date, end_date1 date, start_date2 date, end_date2 date) RETURNS BOOLEAN
    LANGUAGE plpgsql
    AS $$
BEGIN
   RETURN (end_date2 IS NOT NULL) AND (end_date2 == start_date1);
END; $$;

-- A overlap B
-- A______A
--     B_____B
CREATE OR REPLACE FUNCTION public.allen_is_overlapping(start_date1 date, end_date1 date, start_date2 date, end_date2 date) RETURNS BOOLEAN
    LANGUAGE plpgsql
    AS $$
BEGIN
   RETURN (end_date1 IS NOT NULL) AND (start_date1 < start_date2) AND (start_date2 < end_date1) AND ((end_date1 < end_date2) OR (end_date2 IS NULL));
END; $$;

-- A overlap inverse B
-- B______B
--     A_____A
CREATE OR REPLACE FUNCTION public.allen_is_overlapping_inverse(start_date1 date, end_date1 date, start_date2 date, end_date2 date) RETURNS BOOLEAN
    LANGUAGE plpgsql
    AS $$
BEGIN
   RETURN (end_date2 IS NOT NULL) AND (start_date2 < start_date1) AND (start_date1 < end_date2) AND ((end_date2 < end_date1) OR (end_date1 IS NULL));
END; $$;

-- A start B
-- A______A
-- B_____________B
CREATE OR REPLACE FUNCTION public.allen_is_start(start_date1 date, end_date1 date, start_date2 date, end_date2 date) RETURNS BOOLEAN
    LANGUAGE plpgsql
    AS $$
BEGIN
   RETURN (end_date1 IS NULL) AND (start_date1 == start_date2) AND ((end_date1 < end_date2) OR (end_date2 IS NULL));
END; $$;

-- A start inverse B
-- A_________A
-- B_____B
CREATE OR REPLACE FUNCTION public.allen_is_start_inverse(start_date1 date, end_date1 date, start_date2 date, end_date2 date) RETURNS BOOLEAN
    LANGUAGE plpgsql
    AS $$
BEGIN
   RETURN (end_date2 IS NULL) AND (start_date2 == start_date1) AND ((end_date2 < end_date1) OR (end_date1 IS NULL));
END; $$;

-- A during B
--    A______A
-- B_____________B
CREATE OR REPLACE FUNCTION public.allen_is_during(start_date1 date, end_date1 date, start_date2 date, end_date2 date) RETURNS BOOLEAN
    LANGUAGE plpgsql
    AS $$
BEGIN
   RETURN (start_date2 < start_date1) AND (end_date1 IS NOT NULL) AND ((end_date1 < end_date2) OR (end_date2 IS NULL));
END; $$;

-- A during inverse B
-- A____________A
--    B________B
CREATE OR REPLACE FUNCTION public.allen_is_during_inverse(start_date1 date, end_date1 date, start_date2 date, end_date2 date) RETURNS BOOLEAN
    LANGUAGE plpgsql
    AS $$
BEGIN
   RETURN (start_date1 < start_date2) AND (end_date2 IS NOT NULL) AND ((end_date2 < end_date1) OR (end_date1 IS NULL));
END; $$;

-- A finish B
--        A______A
-- B_____________B
CREATE OR REPLACE FUNCTION public.allen_is_finish(start_date1 date, end_date1 date, start_date2 date, end_date2 date) RETURNS BOOLEAN
    LANGUAGE plpgsql
    AS $$
BEGIN
   RETURN (start_date2 < start_date1) AND (end_date1 == end_date2);
END; $$;

-- A finish inverse B
-- A____________A
--     B________B
CREATE OR REPLACE FUNCTION public.allen_is_finish_inverse(start_date1 date, end_date1 date, start_date2 date, end_date2 date) RETURNS BOOLEAN
    LANGUAGE plpgsql
    AS $$
BEGIN
   RETURN (start_date1 < start_date2) AND (end_date2 == end_date1);
END; $$;

-- A equal B
-- A________A
-- B________B
CREATE OR REPLACE FUNCTION public.allen_is_equal(start_date1 date, end_date1 date, start_date2 date, end_date2 date) RETURNS BOOLEAN
    LANGUAGE plpgsql
    AS $$
BEGIN
   RETURN (start_date1 = start_date2) AND (end_date1 = end_date2);
END; $$;