--
-- PostgreSQL database dump
--

-- Dumped from database version 11.5
-- Dumped by pg_dump version 11.5

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: allen_is_after(date, date, date, date); Type: FUNCTION; Schema: public; Owner: haifadhila
--

CREATE FUNCTION public.allen_is_after(start_date1 date, end_date1 date, start_date2 date, end_date2 date) RETURNS boolean
    LANGUAGE plpgsql
    AS $$
BEGIN
   RETURN (end_date2 IS NOT NULL) AND (end_date2 < start_date1);
END; $$;


ALTER FUNCTION public.allen_is_after(start_date1 date, end_date1 date, start_date2 date, end_date2 date) OWNER TO haifadhila;

--
-- Name: allen_is_before(date, date, date, date); Type: FUNCTION; Schema: public; Owner: haifadhila
--

CREATE FUNCTION public.allen_is_before(start_date1 date, end_date1 date, start_date2 date, end_date2 date) RETURNS boolean
    LANGUAGE plpgsql
    AS $$
BEGIN
   RETURN (end_date1 IS NOT NULL) AND (end_date1 < start_date2);
END; $$;


ALTER FUNCTION public.allen_is_before(start_date1 date, end_date1 date, start_date2 date, end_date2 date) OWNER TO haifadhila;

--
-- Name: allen_is_during(date, date, date, date); Type: FUNCTION; Schema: public; Owner: haifadhila
--

CREATE FUNCTION public.allen_is_during(start_date1 date, end_date1 date, start_date2 date, end_date2 date) RETURNS boolean
    LANGUAGE plpgsql
    AS $$
BEGIN
   RETURN (start_date2 < start_date1) AND (end_date1 IS NOT NULL) AND ((end_date1 < end_date2) OR (end_date2 IS NULL));
END; $$;


ALTER FUNCTION public.allen_is_during(start_date1 date, end_date1 date, start_date2 date, end_date2 date) OWNER TO haifadhila;

--
-- Name: allen_is_during_inverse(date, date, date, date); Type: FUNCTION; Schema: public; Owner: haifadhila
--

CREATE FUNCTION public.allen_is_during_inverse(start_date1 date, end_date1 date, start_date2 date, end_date2 date) RETURNS boolean
    LANGUAGE plpgsql
    AS $$
BEGIN
   RETURN (start_date1 < start_date2) AND (end_date2 IS NOT NULL) AND ((end_date2 < end_date1) OR (end_date1 IS NULL));
END; $$;


ALTER FUNCTION public.allen_is_during_inverse(start_date1 date, end_date1 date, start_date2 date, end_date2 date) OWNER TO haifadhila;

--
-- Name: allen_is_equal(date, date, date, date); Type: FUNCTION; Schema: public; Owner: haifadhila
--

CREATE FUNCTION public.allen_is_equal(start_date1 date, end_date1 date, start_date2 date, end_date2 date) RETURNS boolean
    LANGUAGE plpgsql
    AS $$
BEGIN
   RETURN (start_date1 = start_date2) AND (end_date1 = end_date2);
END; $$;


ALTER FUNCTION public.allen_is_equal(start_date1 date, end_date1 date, start_date2 date, end_date2 date) OWNER TO haifadhila;

--
-- Name: allen_is_finish(date, date, date, date); Type: FUNCTION; Schema: public; Owner: haifadhila
--

CREATE FUNCTION public.allen_is_finish(start_date1 date, end_date1 date, start_date2 date, end_date2 date) RETURNS boolean
    LANGUAGE plpgsql
    AS $$
BEGIN
   RETURN (start_date2 < start_date1) AND (end_date1 == end_date2);
END; $$;


ALTER FUNCTION public.allen_is_finish(start_date1 date, end_date1 date, start_date2 date, end_date2 date) OWNER TO haifadhila;

--
-- Name: allen_is_finish_inverse(date, date, date, date); Type: FUNCTION; Schema: public; Owner: haifadhila
--

CREATE FUNCTION public.allen_is_finish_inverse(start_date1 date, end_date1 date, start_date2 date, end_date2 date) RETURNS boolean
    LANGUAGE plpgsql
    AS $$
BEGIN
   RETURN (start_date1 < start_date2) AND (end_date2 == end_date1);
END; $$;


ALTER FUNCTION public.allen_is_finish_inverse(start_date1 date, end_date1 date, start_date2 date, end_date2 date) OWNER TO haifadhila;

--
-- Name: allen_is_meet(date, date, date, date); Type: FUNCTION; Schema: public; Owner: haifadhila
--

CREATE FUNCTION public.allen_is_meet(start_date1 date, end_date1 date, start_date2 date, end_date2 date) RETURNS boolean
    LANGUAGE plpgsql
    AS $$
BEGIN
   RETURN (end_date1 IS NOT NULL) AND (end_date1 == start_date2);
END; $$;


ALTER FUNCTION public.allen_is_meet(start_date1 date, end_date1 date, start_date2 date, end_date2 date) OWNER TO haifadhila;

--
-- Name: allen_is_meet_inverse(date, date, date, date); Type: FUNCTION; Schema: public; Owner: haifadhila
--

CREATE FUNCTION public.allen_is_meet_inverse(start_date1 date, end_date1 date, start_date2 date, end_date2 date) RETURNS boolean
    LANGUAGE plpgsql
    AS $$
BEGIN
   RETURN (end_date2 IS NOT NULL) AND (end_date2 == start_date1);
END; $$;


ALTER FUNCTION public.allen_is_meet_inverse(start_date1 date, end_date1 date, start_date2 date, end_date2 date) OWNER TO haifadhila;

--
-- Name: allen_is_overlapping(date, date, date, date); Type: FUNCTION; Schema: public; Owner: haifadhila
--

CREATE FUNCTION public.allen_is_overlapping(start_date1 date, end_date1 date, start_date2 date, end_date2 date) RETURNS boolean
    LANGUAGE plpgsql
    AS $$
BEGIN
   RETURN (end_date1 IS NOT NULL) AND (start_date1 < start_date2) AND (start_date2 < end_date1) AND ((end_date1 < end_date2) OR (end_date2 IS NULL));
END; $$;


ALTER FUNCTION public.allen_is_overlapping(start_date1 date, end_date1 date, start_date2 date, end_date2 date) OWNER TO haifadhila;

--
-- Name: allen_is_overlapping_inverse(date, date, date, date); Type: FUNCTION; Schema: public; Owner: haifadhila
--

CREATE FUNCTION public.allen_is_overlapping_inverse(start_date1 date, end_date1 date, start_date2 date, end_date2 date) RETURNS boolean
    LANGUAGE plpgsql
    AS $$
BEGIN
   RETURN (end_date2 IS NOT NULL) AND (start_date2 < start_date1) AND (start_date1 < end_date2) AND ((end_date2 < end_date1) OR (end_date1 IS NULL));
END; $$;


ALTER FUNCTION public.allen_is_overlapping_inverse(start_date1 date, end_date1 date, start_date2 date, end_date2 date) OWNER TO haifadhila;

--
-- Name: allen_is_start(date, date, date, date); Type: FUNCTION; Schema: public; Owner: haifadhila
--

CREATE FUNCTION public.allen_is_start(start_date1 date, end_date1 date, start_date2 date, end_date2 date) RETURNS boolean
    LANGUAGE plpgsql
    AS $$
BEGIN
   RETURN (end_date1 IS NULL) AND (start_date1 == start_date2) AND ((end_date1 < end_date2) OR (end_date2 IS NULL));
END; $$;


ALTER FUNCTION public.allen_is_start(start_date1 date, end_date1 date, start_date2 date, end_date2 date) OWNER TO haifadhila;

--
-- Name: allen_is_start_inverse(date, date, date, date); Type: FUNCTION; Schema: public; Owner: haifadhila
--

CREATE FUNCTION public.allen_is_start_inverse(start_date1 date, end_date1 date, start_date2 date, end_date2 date) RETURNS boolean
    LANGUAGE plpgsql
    AS $$
BEGIN
   RETURN (end_date2 IS NULL) AND (start_date2 == start_date1) AND ((end_date2 < end_date1) OR (end_date1 IS NULL));
END; $$;


ALTER FUNCTION public.allen_is_start_inverse(start_date1 date, end_date1 date, start_date2 date, end_date2 date) OWNER TO haifadhila;

--
-- Name: bitemporal_join_renting_room(); Type: FUNCTION; Schema: public; Owner: haifadhila
--

CREATE FUNCTION public.bitemporal_join_renting_room() RETURNS TABLE(rent_id integer, room_id integer, room_name character varying, organization_id integer, event_name character varying, t_eff_start date, t_reg_start date, t_eff_end date, t_reg_end date, t_deletion date)
    LANGUAGE plpgsql
    AS $$

DECLARE 
    r record;
	r2 record;
	date_temp_r DATE;
	date_temp_r2 DATE;
BEGIN
   FOR r IN(SELECT * FROM renting)  
	LOOP
		FOR r2 IN(SELECT * FROM ROOM)
		LOOP
			IF (r.t_eff_end IS NULL) THEN date_temp_r := '2099-01-01'; ELSE date_temp_r := r.t_eff_end; END IF;
			IF (r2.t_eff_end IS NULL) THEN date_temp_r2 := '2099-01-01'; ELSE date_temp_r2 := r2.t_eff_end; END IF;
			IF NOT (date_temp_r < r2.t_eff_start OR  date_temp_r2 < r.t_eff_start) THEN
				IF (r.room_id = r2.room_id) THEN
						rent_id := r.rent_id;
						room_id := r.room_id;
						room_name := r2.room_name;
						organization_id := r.organization_id;
						event_name := r.event_name;
						t_eff_start := GREATEST(r.t_eff_start,r2.t_eff_start);

						IF (t_eff_start = r.t_eff_start) THEN
							t_reg_start := r.t_reg_start;
						ELSE
							t_reg_start := r2.t_reg_start;
						END IF;

						IF (r.t_eff_end IS NULL) THEN t_eff_end := r2.t_eff_end;
						ELSIF (r2.t_eff_end IS NULL) THEN t_eff_end := r.t_eff_end;
						ELSE t_eff_end := LEAST(r.t_eff_end,r2.t_eff_end);
						END IF;

						IF (t_eff_end = r.t_eff_end) THEN
							t_reg_end := r.t_reg_end;
							t_deletion := r.t_deletion;
						ELSE
							t_reg_end := r2.t_reg_end;
							t_deletion := r2.t_deletion;
						END IF;	
				END IF;
			END IF;
		END LOOP;
		RETURN NEXT;
   END LOOP;
END; $$;


ALTER FUNCTION public.bitemporal_join_renting_room() OWNER TO haifadhila;

--
-- Name: coalesce_organization(); Type: FUNCTION; Schema: public; Owner: haifadhila
--

CREATE FUNCTION public.coalesce_organization() RETURNS TABLE(organization_id integer, organization_name character varying, t_eff_start date, t_reg_start date, t_eff_end date, t_reg_end date, t_deletion date)
    LANGUAGE plpgsql
    AS $$
DECLARE
    var_x record;
    var_y record;
    min_eff_start date;
    max_eff_end date;
BEGIN
    DROP TABLE IF EXISTS excluded CASCADE;
    CREATE TEMP TABLE IF NOT EXISTS excluded (organization_id integer);

    FOR var_x IN (
        SELECT *
            FROM organization
            ORDER BY organization.organization_id
    ) LOOP
        IF var_x.organization_id NOT IN (SELECT excluded.organization_id FROM excluded) THEN
            INSERT INTO excluded (organization_id) VALUES (var_x.organization_id);
            organization_id = var_x.organization_id;
            organization_name = var_x.organization_name;
            t_eff_start := var_x.t_eff_start;
            t_eff_end := var_x.t_eff_end;
            t_reg_start := var_x.t_reg_start;
            t_reg_end := var_x.t_reg_end;
            FOR var_y IN (
                SELECT *
                    FROM organization
                    WHERE organization.organization_id NOT IN (SELECT excluded.organization_id FROM excluded)
                        AND organization.organization_name = var_x.organization_name
            ) LOOP
                IF var_y.organization_id NOT IN (SELECT excluded.organization_id FROM excluded) THEN
                    IF NOT (
                        allen_is_before(t_eff_start, t_eff_end, var_y.t_eff_start, var_y.t_eff_end) OR
                        allen_is_after(t_eff_start, t_eff_end, var_y.t_eff_start, var_y.t_eff_end)
                    ) THEN
                        IF (var_y.t_eff_start < t_eff_start) THEN
                            t_eff_start := var_y.t_eff_start;
                            t_reg_start := var_y.t_reg_start;
                        END IF;

                        IF (var_y.t_eff_end > t_eff_end OR var_y.t_eff_end IS NULL) THEN
                            t_eff_end := var_y.t_eff_end;
                            t_reg_end := var_y.t_reg_end;
                        END IF;

                        INSERT INTO excluded (organization_id) VALUES (var_y.organization_id);
                    END IF;
                END IF;
            END LOOP;
            RETURN NEXT;
        END IF;
   END LOOP;
END; $$;


ALTER FUNCTION public.coalesce_organization() OWNER TO haifadhila;

--
-- Name: coalesce_renting(); Type: FUNCTION; Schema: public; Owner: haifadhila
--

CREATE FUNCTION public.coalesce_renting() RETURNS TABLE(rent_id integer, room_id integer, organization_id integer, event_name character varying, t_eff_start date, t_reg_start date, t_eff_end date, t_reg_end date, t_deletion date)
    LANGUAGE plpgsql
    AS $$
DECLARE
    var_x record;
    var_y record;
    min_eff_start date;
    max_eff_end date;
BEGIN
    DROP TABLE IF EXISTS excluded CASCADE;
    CREATE TEMP TABLE IF NOT EXISTS excluded (rent_id integer);

    FOR var_x IN (
        SELECT *
            FROM rent
            ORDER BY renting.rent_id
    ) LOOP
        IF var_x.rent_id NOT IN (SELECT excluded.rent_id FROM excluded) THEN
            INSERT INTO excluded (rent_id) VALUES (var_x.rent_id);
            rent_id = var_x.rent_id;
            room_id = var_x.room_id;
            organization_id = var_x.organization_id;
            event_name = var_x.event_name;
            t_eff_start := var_x.t_eff_start;
            t_eff_end := var_x.t_eff_end;
            t_reg_start := var_x.t_reg_start;
            t_reg_end := var_x.t_reg_end;
            FOR var_y IN (
                SELECT *
                    FROM rent
                    WHERE rent.rent_id NOT IN (SELECT excluded.rent_id FROM excluded)
                        AND rent.room_id = var_x.room_id
                        AND rent.organization_id = var_x.organization_id
                        AND rent.event_name = var_x.event_name
            ) LOOP
                IF var_y.rent_id NOT IN (SELECT excluded.rent_id FROM excluded) THEN
                    IF NOT (
                        allen_is_before(t_eff_start, t_eff_end, var_y.t_eff_start, var_y.t_eff_end) OR
                        allen_is_after(t_eff_start, t_eff_end, var_y.t_eff_start, var_y.t_eff_end)
                    ) THEN
                        IF (var_y.t_eff_start < t_eff_start) THEN
                            t_eff_start := var_y.t_eff_start;
                            t_reg_start := var_y.t_reg_start;
                        END IF;

                        IF (var_y.t_eff_end > t_eff_end OR var_y.t_eff_end IS NULL) THEN
                            t_eff_end := var_y.t_eff_end;
                            t_reg_end := var_y.t_reg_end;
                        END IF;

                        INSERT INTO excluded (rent_id) VALUES (var_y.rent_id);
                    END IF;
                END IF;
            END LOOP;
            RETURN NEXT;
        END IF;
   END LOOP;
END; $$;


ALTER FUNCTION public.coalesce_renting() OWNER TO haifadhila;

--
-- Name: coalesce_room(); Type: FUNCTION; Schema: public; Owner: haifadhila
--

CREATE FUNCTION public.coalesce_room() RETURNS TABLE(room_id integer, room_name character varying, t_eff_start date, t_reg_start date, t_eff_end date, t_reg_end date, t_deletion date)
    LANGUAGE plpgsql
    AS $$
DECLARE
    var_x record;
    var_y record;
    min_eff_start date;
    max_eff_end date;
BEGIN
    DROP TABLE IF EXISTS excluded CASCADE;
    CREATE TEMP TABLE IF NOT EXISTS excluded (room_id integer);

    FOR var_x IN (
        SELECT *
            FROM room
            ORDER BY room.room_id
    ) LOOP
        IF var_x.room_id NOT IN (SELECT excluded.room_id FROM excluded) THEN
            INSERT INTO excluded (room_id) VALUES (var_x.room_id);
            room_id = var_x.room_id;
            room_name = var_x.room_name;
            t_eff_start := var_x.t_eff_start;
            t_eff_end := var_x.t_eff_end;
            t_reg_start := var_x.t_reg_start;
            t_reg_end := var_x.t_reg_end;
            FOR var_y IN (
                SELECT *
                    FROM room
                    WHERE room.room_id NOT IN (SELECT excluded.room_id FROM excluded)
                        AND room.room_name = var_x.room_name
            ) LOOP
                IF var_y.room_id NOT IN (SELECT excluded.room_id FROM excluded) THEN
                    IF NOT (
                        allen_is_before(t_eff_start, t_eff_end, var_y.t_eff_start, var_y.t_eff_end) OR
                        allen_is_after(t_eff_start, t_eff_end, var_y.t_eff_start, var_y.t_eff_end)
                    ) THEN
                        IF (var_y.t_eff_start < t_eff_start) THEN
                            t_eff_start := var_y.t_eff_start;
                            t_reg_start := var_y.t_reg_start;
                        END IF;

                        IF (var_y.t_eff_end > t_eff_end OR var_y.t_eff_end IS NULL) THEN
                            t_eff_end := var_y.t_eff_end;
                            t_reg_end := var_y.t_reg_end;
                        END IF;

                        INSERT INTO excluded (room_id) VALUES (var_y.room_id);
                    END IF;
                END IF;
            END LOOP;
            RETURN NEXT;
        END IF;
   END LOOP;
END; $$;


ALTER FUNCTION public.coalesce_room() OWNER TO haifadhila;

--
-- Name: delete_from_table(character varying, integer); Type: FUNCTION; Schema: public; Owner: haifadhila
--

CREATE FUNCTION public.delete_from_table(table_name character varying, table_id integer) RETURNS void
    LANGUAGE plpgsql
    AS $$
BEGIN

    IF table_name = 'Room' THEN
        UPDATE Room SET t_deletion = CURRENT_DATE WHERE room_id = table_id;

    ELSIF table_name = 'Organization' THEN
        UPDATE Organization SET t_deletion = CURRENT_DATE WHERE room_id = table_id;

    ELSIF table_name = 'Renting' THEN
        UPDATE Renting SET t_deletion = CURRENT_DATE WHERE room_id = table_id;
    END IF;
END
$$;


ALTER FUNCTION public.delete_from_table(table_name character varying, table_id integer) OWNER TO haifadhila;

--
-- Name: insert_into_organization(character varying, date, date); Type: FUNCTION; Schema: public; Owner: haifadhila
--

CREATE FUNCTION public.insert_into_organization(org_name character varying, t_start date, t_end date) RETURNS void
    LANGUAGE plpgsql
    AS $$
BEGIN
    INSERT INTO Organization (organization_name, t_eff_start, t_reg_start, t_eff_end, t_reg_end)
    VALUES 
        (org_name, t_start, CURRENT_DATE,t_end, CURRENT_DATE);
END
$$;


ALTER FUNCTION public.insert_into_organization(org_name character varying, t_start date, t_end date) OWNER TO haifadhila;

--
-- Name: insert_into_renting(integer, integer, character varying, date, date); Type: FUNCTION; Schema: public; Owner: haifadhila
--

CREATE FUNCTION public.insert_into_renting(room_id integer, org_id integer, event_name character varying, t_start date, t_end date) RETURNS void
    LANGUAGE plpgsql
    AS $$
BEGIN
    INSERT INTO Renting (room_id, organization_id, event_name, t_eff_start, t_reg_start, t_eff_end, t_reg_end)
    VALUES 
        (room_id, org_id, event_name, t_start, CURRENT_DATE, t_end, CURRENT_DATE);
END
$$;


ALTER FUNCTION public.insert_into_renting(room_id integer, org_id integer, event_name character varying, t_start date, t_end date) OWNER TO haifadhila;

--
-- Name: insert_into_room(character varying, date, date); Type: FUNCTION; Schema: public; Owner: haifadhila
--

CREATE FUNCTION public.insert_into_room(room_name character varying, t_start date, t_end date) RETURNS void
    LANGUAGE plpgsql
    AS $$
BEGIN
    INSERT INTO Room (room_name, t_eff_start, t_reg_start, t_eff_end, t_reg_end)
    VALUES 
        (room_name, t_start, CURRENT_DATE,t_end, CURRENT_DATE);
END
$$;


ALTER FUNCTION public.insert_into_room(room_name character varying, t_start date, t_end date) OWNER TO haifadhila;

--
-- Name: organization_projection_organization_name(); Type: FUNCTION; Schema: public; Owner: haifadhila
--

CREATE FUNCTION public.organization_projection_organization_name() RETURNS TABLE(organization_name character varying, t_eff_start date, t_reg_start date, t_eff_end date, t_reg_end date, t_deletion date)
    LANGUAGE plpgsql
    AS $$
BEGIN
   RETURN QUERY SELECT
	   r.organization_name,
	   r.t_eff_start,
	   r.t_reg_start,
	   r.t_eff_end,
	   r.t_reg_end,
	   r.t_deletion 
   FROM
      organization r;
END; $$;


ALTER FUNCTION public.organization_projection_organization_name() OWNER TO haifadhila;

--
-- Name: organization_selection_by_id(integer); Type: FUNCTION; Schema: public; Owner: haifadhila
--

CREATE FUNCTION public.organization_selection_by_id(the_id integer) RETURNS TABLE(organization_id integer, organization_name character varying, t_eff_start date, t_reg_start date, t_eff_end date, t_reg_end date, t_deletion date)
    LANGUAGE plpgsql
    AS $$
BEGIN
   RETURN QUERY SELECT
	   *
   FROM
      organization o
   WHERE o.organization_id = the_id;
END; $$;


ALTER FUNCTION public.organization_selection_by_id(the_id integer) OWNER TO haifadhila;

--
-- Name: organization_transaction_time_slice(date); Type: FUNCTION; Schema: public; Owner: haifadhila
--

CREATE FUNCTION public.organization_transaction_time_slice(chosen_date date) RETURNS TABLE(organization_id integer, organization_name character varying, t_eff_start date, t_eff_end date)
    LANGUAGE plpgsql
    AS $$
BEGIN
   RETURN QUERY SELECT
	   o.organization_id,
	   o.organization_name,
	   o.t_eff_start,
	   o.t_eff_end
   FROM
      organization o
   WHERE
      o.t_reg_start <= chosen_date AND (o.t_deletion >= chosen_date OR o.t_deletion is NULL);
END; $$;


ALTER FUNCTION public.organization_transaction_time_slice(chosen_date date) OWNER TO haifadhila;

--
-- Name: organization_valid_time_slice(date); Type: FUNCTION; Schema: public; Owner: haifadhila
--

CREATE FUNCTION public.organization_valid_time_slice(chosen_date date) RETURNS TABLE(organization_id integer, organization_name character varying, t_reg_start date, t_reg_end date, t_deletion date)
    LANGUAGE plpgsql
    AS $$
BEGIN
   RETURN QUERY SELECT
	   o.organization_id,
	   o.organization_name,
	   o.t_reg_start,
	   o.t_reg_end,
	   o.t_deletion 
   FROM
      organization o
   WHERE
      o.t_eff_start <= chosen_date AND (o.t_eff_end >= chosen_date OR o.t_eff_end is null);
END; $$;


ALTER FUNCTION public.organization_valid_time_slice(chosen_date date) OWNER TO haifadhila;

--
-- Name: renting_projection_event_name(); Type: FUNCTION; Schema: public; Owner: haifadhila
--

CREATE FUNCTION public.renting_projection_event_name() RETURNS TABLE(event_name character varying, t_eff_start date, t_reg_start date, t_eff_end date, t_reg_end date, t_deletion date)
    LANGUAGE plpgsql
    AS $$
BEGIN
   RETURN QUERY SELECT
	   r.event_name,
	   r.t_eff_start,
	   r.t_reg_start,
	   r.t_eff_end,
	   r.t_reg_end,
	   r.t_deletion 
   FROM
      renting r;
END; $$;


ALTER FUNCTION public.renting_projection_event_name() OWNER TO haifadhila;

--
-- Name: renting_selection_by_organization_id(integer); Type: FUNCTION; Schema: public; Owner: haifadhila
--

CREATE FUNCTION public.renting_selection_by_organization_id(the_id integer) RETURNS TABLE(rent_id integer, room_id integer, organization_id integer, event_name character varying, t_eff_start date, t_reg_start date, t_eff_end date, t_reg_end date, t_deletion date)
    LANGUAGE plpgsql
    AS $$
BEGIN
   RETURN QUERY SELECT
	   *
   FROM
      renting r
   WHERE r.organization_id = the_id;
END; $$;


ALTER FUNCTION public.renting_selection_by_organization_id(the_id integer) OWNER TO haifadhila;

--
-- Name: renting_selection_by_rent_id(integer); Type: FUNCTION; Schema: public; Owner: haifadhila
--

CREATE FUNCTION public.renting_selection_by_rent_id(the_id integer) RETURNS TABLE(rent_id integer, room_id integer, organization_id integer, event_name character varying, t_eff_start date, t_reg_start date, t_eff_end date, t_reg_end date, t_deletion date)
    LANGUAGE plpgsql
    AS $$
BEGIN
   RETURN QUERY SELECT
	   *
   FROM
      renting r
   WHERE r.rent_id = the_id;
END; $$;


ALTER FUNCTION public.renting_selection_by_rent_id(the_id integer) OWNER TO haifadhila;

--
-- Name: renting_selection_by_room_id(integer); Type: FUNCTION; Schema: public; Owner: haifadhila
--

CREATE FUNCTION public.renting_selection_by_room_id(the_id integer) RETURNS TABLE(rent_id integer, room_id integer, organization_id integer, event_name character varying, t_eff_start date, t_reg_start date, t_eff_end date, t_reg_end date, t_deletion date)
    LANGUAGE plpgsql
    AS $$
BEGIN
   RETURN QUERY SELECT
	   *
   FROM
      renting r
   WHERE r.room_id = the_id;
END; $$;


ALTER FUNCTION public.renting_selection_by_room_id(the_id integer) OWNER TO haifadhila;

--
-- Name: renting_transaction_time_slice(date); Type: FUNCTION; Schema: public; Owner: haifadhila
--

CREATE FUNCTION public.renting_transaction_time_slice(chosen_date date) RETURNS TABLE(rent_id integer, room_id integer, organization_id integer, event_name character varying, t_eff_start date, t_eff_end date)
    LANGUAGE plpgsql
    AS $$
BEGIN
   RETURN QUERY SELECT
       r.rent_id,
	   r.room_id,
	   r.organization_id,
	   r.event_name,
	   r.t_eff_start,
	   r.t_eff_end
   FROM
      renting r
   WHERE
       r.t_reg_start <= chosen_date AND (r.t_deletion >= chosen_date OR r.t_deletion is NULL);
END; $$;


ALTER FUNCTION public.renting_transaction_time_slice(chosen_date date) OWNER TO haifadhila;

--
-- Name: renting_valid_time_slice(date); Type: FUNCTION; Schema: public; Owner: haifadhila
--

CREATE FUNCTION public.renting_valid_time_slice(chosen_date date) RETURNS TABLE(rent_id integer, room_id integer, organization_id integer, event_name character varying, t_reg_start date, t_reg_end date, t_deletion date)
    LANGUAGE plpgsql
    AS $$
BEGIN
   RETURN QUERY SELECT
       r.rent_id,
	   r.room_id,
	   r.organization_id,
	   r.event_name,
	   r.t_reg_start,
	   r.t_reg_end,
	   r.t_deletion 
   FROM
      renting r
   WHERE
   	r.t_eff_start <= chosen_date AND (r.t_eff_end >= chosen_date OR r.t_eff_end is null);
END; $$;


ALTER FUNCTION public.renting_valid_time_slice(chosen_date date) OWNER TO haifadhila;

--
-- Name: room_projection_room_name(); Type: FUNCTION; Schema: public; Owner: haifadhila
--

CREATE FUNCTION public.room_projection_room_name() RETURNS TABLE(room_name character varying, t_eff_start date, t_reg_start date, t_eff_end date, t_reg_end date, t_deletion date)
    LANGUAGE plpgsql
    AS $$
BEGIN
   RETURN QUERY SELECT
	   r.room_name,
	   r.t_eff_start,
	   r.t_reg_start,
	   r.t_eff_end,
	   r.t_reg_end,
	   r.t_deletion 
   FROM
      room r;
END; $$;


ALTER FUNCTION public.room_projection_room_name() OWNER TO haifadhila;

--
-- Name: room_selection_by_id(integer); Type: FUNCTION; Schema: public; Owner: haifadhila
--

CREATE FUNCTION public.room_selection_by_id(the_id integer) RETURNS TABLE(room_id integer, room_name character varying, t_eff_start date, t_reg_start date, t_eff_end date, t_reg_end date, t_deletion date)
    LANGUAGE plpgsql
    AS $$
BEGIN
   RETURN QUERY SELECT
	   *
   FROM
      room r
   WHERE r.room_id = the_id;
END; $$;


ALTER FUNCTION public.room_selection_by_id(the_id integer) OWNER TO haifadhila;

--
-- Name: room_selection_by_room_id(integer); Type: FUNCTION; Schema: public; Owner: haifadhila
--

CREATE FUNCTION public.room_selection_by_room_id(the_id integer) RETURNS TABLE(rent_id integer, room_id integer, organization_id integer, event_name character varying, t_eff_start date, t_reg_start date, t_eff_end date, t_reg_end date, t_deletion date)
    LANGUAGE plpgsql
    AS $$
BEGIN
   RETURN QUERY SELECT
	   *
   FROM
      room r
   WHERE r.room_id = the_id;
END; $$;


ALTER FUNCTION public.room_selection_by_room_id(the_id integer) OWNER TO haifadhila;

--
-- Name: room_transaction_time_slice(date); Type: FUNCTION; Schema: public; Owner: haifadhila
--

CREATE FUNCTION public.room_transaction_time_slice(chosen_date date) RETURNS TABLE(room_id integer, room_name character varying, t_eff_start date, t_eff_end date)
    LANGUAGE plpgsql
    AS $$
BEGIN
   RETURN QUERY SELECT
	   r.room_id,
	   r.room_name,
	   r.t_eff_start,
	   r.t_eff_end
   FROM
      room r
   WHERE
      r.t_reg_start <= chosen_date AND (r.t_deletion >= chosen_date OR r.t_deletion is NULL) ;
END; $$;


ALTER FUNCTION public.room_transaction_time_slice(chosen_date date) OWNER TO haifadhila;

--
-- Name: room_valid_time_slice(date); Type: FUNCTION; Schema: public; Owner: haifadhila
--

CREATE FUNCTION public.room_valid_time_slice(chosen_date date) RETURNS TABLE(room_id integer, room_name character varying, t_reg_start date, t_reg_end date, t_deletion date)
    LANGUAGE plpgsql
    AS $$
BEGIN
   RETURN QUERY SELECT
	   r.room_id,
	   r.room_name,
	   r.t_reg_start,
	   r.t_reg_end,
	   r.t_deletion 
   FROM
      room r
   WHERE
      r.t_eff_start <= chosen_date AND (r.t_eff_end >= chosen_date OR r.t_eff_end is null);
END; $$;


ALTER FUNCTION public.room_valid_time_slice(chosen_date date) OWNER TO haifadhila;


SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: room; Type: TABLE; Schema: public; Owner: haifadhila
--

CREATE TABLE public.room (
    room_id integer NOT NULL,
    room_name character varying(50) NOT NULL,
    t_eff_start date,
    t_reg_start date,
    t_eff_end date,
    t_reg_end date,
    t_deletion date
);


ALTER TABLE public.room OWNER TO haifadhila;

--
-- Name: update_organization(character varying, integer, character varying); Type: FUNCTION; Schema: public; Owner: haifadhila
--

CREATE FUNCTION public.update_organization(chosen_field character varying, chosen_id integer, new_entry character varying) RETURNS void
    LANGUAGE plpgsql
    AS $$
DECLARE
    organization_name_prev VARCHAR(50);
	t_start DATE;
    t_end DATE;

BEGIN
	SELECT Organization.organization_name, Organization.t_eff_start, Organization.t_eff_end into organization_name_prev, t_start, t_end FROM Organization WHERE organization_id = chosen_id;

    UPDATE Organization SET t_deletion = CURRENT_DATE WHERE organization_id = chosen_id;
    IF chosen_field = 'organization_name' THEN
        IF (t_end IS NULL) THEN
            INSERT INTO Organization (organization_name, t_eff_start, t_reg_start, t_eff_end, t_reg_end)
            VALUES (new_entry, t_start, CURRENT_DATE, t_end, NULL);
        ELSIF (t_end IS NOT NULL) THEN
            INSERT INTO Organization (organization_name, t_eff_start, t_reg_start, t_eff_end, t_reg_end)
            VALUES (new_entry, t_start, CURRENT_DATE, t_end, CURRENT_DATE);
        END IF;

    ELSIF chosen_field = 't_eff_start' THEN        
        IF (t_end IS NULL) THEN
            INSERT INTO Organization (organization_name, t_eff_start, t_reg_start, t_eff_end, t_reg_end)
            VALUES (organization_name_prev, to_date(new_entry,'YYYY-MM-DD'), CURRENT_DATE, t_end, NULL);
        ELSIF (t_end IS NOT NULL) THEN
            INSERT INTO Organization (organization_name, t_eff_start, t_reg_start, t_eff_end, t_reg_end)
            VALUES (organization_name_prev, to_date(new_entry,'YYYY-MM-DD'), CURRENT_DATE, t_end, CURRENT_DATE);
        END IF;

    ELSIF chosen_field = 't_eff_end' THEN
        INSERT INTO Organization (organization_name, t_eff_start, t_reg_start, t_eff_end, t_reg_end)
        VALUES (organization_name_prev, t_start, CURRENT_DATE, to_date(new_entry,'YYYY-MM-DD'), CURRENT_DATE);
    END IF;

END
$$;


ALTER FUNCTION public.update_organization(chosen_field character varying, chosen_id integer, new_entry character varying) OWNER TO haifadhila;

--
-- Name: update_renting(character varying, integer, character varying); Type: FUNCTION; Schema: public; Owner: haifadhila
--

CREATE FUNCTION public.update_renting(chosen_field character varying, chosen_id integer, new_entry character varying) RETURNS void
    LANGUAGE plpgsql
    AS $$
DECLARE
    room_id_prev integer;
    org_id_prev integer;
    event_name_prev VARCHAR(50);
	t_start DATE;
    t_end DATE;

BEGIN
	SELECT Renting.room_id, Renting.organization_id, Renting.event_name, Renting.t_eff_start, Renting.t_eff_end 
    into room_id_prev, org_id_prev, event_name_prev, t_start, t_end FROM Renting WHERE rent_id = chosen_id;

    UPDATE Renting SET t_deletion = CURRENT_DATE WHERE rent_id = chosen_id;
    IF chosen_field = 'room_id' THEN
        IF (t_end IS NULL) THEN
            INSERT INTO Renting (room_id, organization_id, event_name, t_eff_start, t_reg_start, t_eff_end, t_reg_end)
            VALUES (new_entry::integer, org_id_prev, event_name_prev, t_start, CURRENT_DATE, t_end, NULL);
        ELSIF (t_end IS NOT NULL) THEN
            INSERT INTO Renting (room_id, organization_id, event_name, t_eff_start, t_reg_start, t_eff_end, t_reg_end)
            VALUES (new_entry::integer, org_id_prev, event_name_prev, t_start, CURRENT_DATE, t_end, CURRENT_DATE);
        END IF;
    
        ELSIF chosen_field = 'organization_id' THEN
        IF (t_end IS NULL) THEN
            INSERT INTO Renting (room_id, organization_id, event_name, t_eff_start, t_reg_start, t_eff_end, t_reg_end)
            VALUES (room_id_prev, new_entry::integer, event_name_prev, t_start, CURRENT_DATE, t_end, NULL);
        ELSIF (t_end IS NOT NULL) THEN
            INSERT INTO Renting (room_id, organization_id, event_name, t_eff_start, t_reg_start, t_eff_end, t_reg_end)
            VALUES (room_id_prev, new_entry::integer, event_name_prev, t_start, CURRENT_DATE, t_end, CURRENT_DATE);
        END IF;

    ELSIF chosen_field = 'event_name' THEN
        IF (t_end IS NULL) THEN
            INSERT INTO Renting (room_id, organization_id, event_name, t_eff_start, t_reg_start, t_eff_end, t_reg_end)
            VALUES (room_id_prev, org_id_prev, new_entry, t_start, CURRENT_DATE, t_end, NULL);
        ELSIF (t_end IS NOT NULL) THEN
            INSERT INTO Renting (room_id, organization_id, event_name, t_eff_start, t_reg_start, t_eff_end, t_reg_end)
            VALUES (room_id_prev, org_id_prev, new_entry, t_start, CURRENT_DATE, t_end, CURRENT_DATE);
        END IF;

    ELSIF chosen_field = 't_eff_start' THEN        
        IF (t_end IS NULL) THEN
            INSERT INTO Renting (room_id, organization_id, event_name, t_eff_start, t_reg_start, t_eff_end, t_reg_end)
            VALUES (room_id_prev, organization_id_prev, event_name_prev, new_entry::DATE, CURRENT_DATE, t_end, NULL);
        ELSIF (t_end IS NOT NULL) THEN
            INSERT INTO Renting (room_id, organization_id, event_name, t_eff_start, t_reg_start, t_eff_end, t_reg_end)
            VALUES (room_id_prev, organization_id_prev, event_name_prev, new_entry::DATE, CURRENT_DATE, t_end, CURRENT_DATE);
        END IF;

    ELSIF chosen_field = 't_eff_end' THEN
        INSERT INTO Renting (room_id, organization_id, event_name, t_eff_start, t_reg_start, t_eff_end, t_reg_end)
        VALUES (room_id_prev, organization_id_prev, event_name_prev, t_start, CURRENT_DATE, new_entry::DATE, CURRENT_DATE);
    END IF;

END
$$;


ALTER FUNCTION public.update_renting(chosen_field character varying, chosen_id integer, new_entry character varying) OWNER TO haifadhila;

--
-- Name: update_room(character varying, integer, character varying); Type: FUNCTION; Schema: public; Owner: haifadhila
--

CREATE FUNCTION public.update_room(chosen_field character varying, chosen_id integer, new_entry character varying) RETURNS void
    LANGUAGE plpgsql
    AS $$
DECLARE
    room_name_prev VARCHAR(50);
	t_start DATE;
    t_end DATE;

BEGIN
	SELECT Room.room_name, Room.t_eff_start, Room.t_eff_end into room_name_prev, t_start, t_end FROM Room WHERE room_id = chosen_id;

    UPDATE Room SET t_deletion = CURRENT_DATE WHERE room_id = chosen_id;
    IF chosen_field = 'room_name' THEN
        IF (t_end IS NULL) THEN
            INSERT INTO Room (room_name, t_eff_start, t_reg_start, t_eff_end, t_reg_end)
            VALUES (new_entry, t_start, CURRENT_DATE, t_end, NULL);
        ELSIF (t_end IS NOT NULL) THEN
            INSERT INTO Room (room_name, t_eff_start, t_reg_start, t_eff_end, t_reg_end)
            VALUES (new_entry, t_start, CURRENT_DATE, t_end, CURRENT_DATE);
        END IF;

    ELSIF chosen_field = 't_eff_start' THEN        
        IF (t_end IS NULL) THEN
            INSERT INTO Room (room_name, t_eff_start, t_reg_start, t_eff_end, t_reg_end)
            VALUES (room_name_prev, to_date(new_entry,'YYYY-MM-DD'), CURRENT_DATE, t_end, NULL);
        ELSIF (t_end IS NOT NULL) THEN
            INSERT INTO Room (room_name, t_eff_start, t_reg_start, t_eff_end, t_reg_end)
            VALUES (room_name_prev, to_date(new_entry,'YYYY-MM-DD'), CURRENT_DATE, t_end, CURRENT_DATE);
        END IF;

    ELSIF chosen_field = 't_eff_end' THEN
        INSERT INTO Room (room_name, t_eff_start, t_reg_start, t_eff_end, t_reg_end)
        VALUES (room_name_prev, t_start, CURRENT_DATE, to_date(new_entry,'YYYY-MM-DD'), CURRENT_DATE);
    END IF;

END
$$;


ALTER FUNCTION public.update_room(chosen_field character varying, chosen_id integer, new_entry character varying) OWNER TO haifadhila;

--
-- Name: valid_time_slice(date); Type: FUNCTION; Schema: public; Owner: haifadhila
--

CREATE FUNCTION public.valid_time_slice(chosen_date date) RETURNS TABLE(rent_id integer, room_id integer, organization_id integer, event_name character varying, t_reg_start date, t_reg_end date, t_deletion date)
    LANGUAGE plpgsql
    AS $$
BEGIN
   RETURN QUERY SELECT
       r.rent_id,
	   r.room_id,
	   r.organization_id,
	   r.event_name,
	   r.t_reg_start,
	   r.t_reg_end,
	   r.t_deletion 
   FROM
      renting r
   WHERE
      t_eff_start <= chosen_date AND t_eff_end >= chosen_date;
END; $$;


ALTER FUNCTION public.valid_time_slice(chosen_date date) OWNER TO haifadhila;

--
-- Name: valid_time_slice(character varying, date); Type: FUNCTION; Schema: public; Owner: haifadhila
--

CREATE FUNCTION public.valid_time_slice(table_name character varying, chosen_date date) RETURNS void
    LANGUAGE plpgsql
    AS $$
	BEGIN
		if (table_name = 'room') then
			SELECT * FROM room_valid_time_slice(chosen_date);
		end if;
    END;
$$;


ALTER FUNCTION public.valid_time_slice(table_name character varying, chosen_date date) OWNER TO haifadhila;

--
-- Name: organization; Type: TABLE; Schema: public; Owner: haifadhila
--

CREATE TABLE public.organization (
    organization_id integer NOT NULL,
    organization_name character varying(50) NOT NULL,
    t_eff_start date,
    t_reg_start date,
    t_eff_end date,
    t_reg_end date,
    t_deletion date
);


ALTER TABLE public.organization OWNER TO haifadhila;

--
-- Name: organization_organization_id_seq; Type: SEQUENCE; Schema: public; Owner: haifadhila
--

CREATE SEQUENCE public.organization_organization_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.organization_organization_id_seq OWNER TO haifadhila;

--
-- Name: organization_organization_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: haifadhila
--

ALTER SEQUENCE public.organization_organization_id_seq OWNED BY public.organization.organization_id;


--
-- Name: renting; Type: TABLE; Schema: public; Owner: haifadhila
--

CREATE TABLE public.renting (
    rent_id integer NOT NULL,
    room_id integer NOT NULL,
    organization_id integer NOT NULL,
    event_name character varying(50) NOT NULL,
    t_eff_start date,
    t_reg_start date,
    t_eff_end date,
    t_reg_end date,
    t_deletion date
);


ALTER TABLE public.renting OWNER TO haifadhila;

--
-- Name: renting_rent_id_seq; Type: SEQUENCE; Schema: public; Owner: haifadhila
--

CREATE SEQUENCE public.renting_rent_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.renting_rent_id_seq OWNER TO haifadhila;

--
-- Name: renting_rent_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: haifadhila
--

ALTER SEQUENCE public.renting_rent_id_seq OWNED BY public.renting.rent_id;


--
-- Name: room_room_id_seq; Type: SEQUENCE; Schema: public; Owner: haifadhila
--

CREATE SEQUENCE public.room_room_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.room_room_id_seq OWNER TO haifadhila;

--
-- Name: room_room_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: haifadhila
--

ALTER SEQUENCE public.room_room_id_seq OWNED BY public.room.room_id;


--
-- Name: organization organization_id; Type: DEFAULT; Schema: public; Owner: haifadhila
--

ALTER TABLE ONLY public.organization ALTER COLUMN organization_id SET DEFAULT nextval('public.organization_organization_id_seq'::regclass);


--
-- Name: renting rent_id; Type: DEFAULT; Schema: public; Owner: haifadhila
--

ALTER TABLE ONLY public.renting ALTER COLUMN rent_id SET DEFAULT nextval('public.renting_rent_id_seq'::regclass);


--
-- Name: room room_id; Type: DEFAULT; Schema: public; Owner: haifadhila
--

ALTER TABLE ONLY public.room ALTER COLUMN room_id SET DEFAULT nextval('public.room_room_id_seq'::regclass);


--
-- Data for Name: organization; Type: TABLE DATA; Schema: public; Owner: haifadhila
--

COPY public.organization (organization_id, organization_name, t_eff_start, t_reg_start, t_eff_end, t_reg_end, t_deletion) FROM stdin;
1	HMIF	2018-11-10	2018-11-11	\N	\N	\N
2	IMT	2018-02-14	2018-02-14	\N	\N	\N
3	HME	2018-05-03	2018-05-04	\N	\N	\N
4	KM ITB	2018-01-12	2018-01-13	\N	\N	\N
\.


--
-- Data for Name: renting; Type: TABLE DATA; Schema: public; Owner: haifadhila
--

COPY public.renting (rent_id, room_id, organization_id, event_name, t_eff_start, t_reg_start, t_eff_end, t_reg_end, t_deletion) FROM stdin;
1	1	1	Rapat Awal Semester	2019-08-19	2019-08-15	2019-08-20	2019-08-15	\N
2	5	4	Rakor Kabinet	2019-08-23	2019-08-19	2019-08-23	2019-08-19	\N
4	4	3	Pelatihan Lomba	2019-09-01	2019-09-06	2019-09-15	2019-09-06	\N
5	2	2	LPJ Himpunan	2019-09-06	2019-09-01	\N	\N	\N
3	4	3	Pelatihan Lomba	2019-09-01	2019-08-23	2019-09-07	2019-08-23	2019-09-06
6	1	3	Syukuran Wisuda	2019-06-22	2019-10-03	2019-06-25	2019-10-03	\N
7	1	1	Syukuran Wisuda	2019-07-01	2019-10-03	2019-07-02	2019-10-03	\N
8	6	3	Latihan Lomba Akhir	2019-09-29	2019-09-20	2019-10-05	2019-09-20	\N
\.


--
-- Data for Name: room; Type: TABLE DATA; Schema: public; Owner: haifadhila
--

COPY public.room (room_id, room_name, t_eff_start, t_reg_start, t_eff_end, t_reg_end, t_deletion) FROM stdin;
2	Programming	2018-02-05	2018-02-07	\N	\N	\N
4	Auditorium 2	2018-09-03	2018-09-05	\N	\N	\N
5	Multimedia	2018-10-12	2018-10-14	\N	\N	\N
1	Informatika Dasar	2018-01-18	2018-01-20	\N	\N	\N
3	Auditorium 1	2018-06-15	2018-06-17	2019-02-03	2019-01-03	\N
6	Ruang Sementara	2019-05-01	2019-05-01	2019-10-01	2019-05-01	\N
\.


--
-- Name: organization_organization_id_seq; Type: SEQUENCE SET; Schema: public; Owner: haifadhila
--

SELECT pg_catalog.setval('public.organization_organization_id_seq', 4, true);


--
-- Name: renting_rent_id_seq; Type: SEQUENCE SET; Schema: public; Owner: haifadhila
--

SELECT pg_catalog.setval('public.renting_rent_id_seq', 7, true);


--
-- Name: room_room_id_seq; Type: SEQUENCE SET; Schema: public; Owner: haifadhila
--

SELECT pg_catalog.setval('public.room_room_id_seq', 5, true);


--
-- Name: organization organization_pkey; Type: CONSTRAINT; Schema: public; Owner: haifadhila
--

ALTER TABLE ONLY public.organization
    ADD CONSTRAINT organization_pkey PRIMARY KEY (organization_id);


--
-- Name: renting renting_pkey; Type: CONSTRAINT; Schema: public; Owner: haifadhila
--

ALTER TABLE ONLY public.renting
    ADD CONSTRAINT renting_pkey PRIMARY KEY (rent_id);


--
-- Name: room room_pkey; Type: CONSTRAINT; Schema: public; Owner: haifadhila
--

ALTER TABLE ONLY public.room
    ADD CONSTRAINT room_pkey PRIMARY KEY (room_id);


--
-- Name: renting organization_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: haifadhila
--

ALTER TABLE ONLY public.renting
    ADD CONSTRAINT organization_id_fkey FOREIGN KEY (organization_id) REFERENCES public.organization(organization_id);


--
-- Name: renting room_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: haifadhila
--

ALTER TABLE ONLY public.renting
    ADD CONSTRAINT room_id_fkey FOREIGN KEY (room_id) REFERENCES public.room(room_id);


--
-- PostgreSQL database dump complete
--

