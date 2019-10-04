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