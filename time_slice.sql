

--
-- Name: organization_transaction_time_slice(date); Type: FUNCTION; Schema: public; Owner: haifadhila
--

CREATE OR REPLACE FUNCTION public.organization_transaction_time_slice(chosen_date date) RETURNS TABLE(organization_id integer, organization_name character varying, t_eff_start date, t_eff_end date)
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


-- ALTER FUNCTION public.organization_transaction_time_slice(chosen_date date) OWNER TO haifadhila;

--
-- Name: organization_valid_time_slice(date); Type: FUNCTION; Schema: public; Owner: haifadhila
--

CREATE OR REPLACE FUNCTION public.organization_valid_time_slice(chosen_date date) RETURNS TABLE(organization_id integer, organization_name character varying, t_reg_start date, t_reg_end date, t_deletion date)
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


-- ALTER FUNCTION public.organization_valid_time_slice(chosen_date date) OWNER TO haifadhila;

--
-- Name: renting_transaction_time_slice(date); Type: FUNCTION; Schema: public; Owner: haifadhila
--

CREATE OR REPLACE FUNCTION public.renting_transaction_time_slice(chosen_date date) RETURNS TABLE(rent_id integer, room_id integer, organization_id integer, event_name character varying, t_eff_start date, t_eff_end date)
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


-- ALTER FUNCTION public.renting_transaction_time_slice(chosen_date date) OWNER TO haifadhila;

--
-- Name: renting_valid_time_slice(date); Type: FUNCTION; Schema: public; Owner: haifadhila
--

CREATE OR REPLACE FUNCTION public.renting_valid_time_slice(chosen_date date) RETURNS TABLE(rent_id integer, room_id integer, organization_id integer, event_name character varying, t_reg_start date, t_reg_end date, t_deletion date)
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


-- ALTER FUNCTION public.renting_valid_time_slice(chosen_date date) OWNER TO haifadhila;

--
-- Name: room_transaction_time_slice(date); Type: FUNCTION; Schema: public; Owner: haifadhila
--

CREATE OR REPLACE FUNCTION public.room_transaction_time_slice(chosen_date date) RETURNS TABLE(room_id integer, room_name character varying, t_eff_start date, t_eff_end date)
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


-- ALTER FUNCTION public.room_transaction_time_slice(chosen_date date) OWNER TO haifadhila;

--
-- Name: room_valid_time_slice(date); Type: FUNCTION; Schema: public; Owner: haifadhila
--

CREATE OR REPLACE FUNCTION public.room_valid_time_slice(chosen_date date) RETURNS TABLE(room_id integer, room_name character varying, t_reg_start date, t_reg_end date, t_deletion date)
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


-- ALTER FUNCTION public.room_valid_time_slice(chosen_date date) OWNER TO haifadhila;

--
-- Name: valid_time_slice(date); Type: FUNCTION; Schema: public; Owner: haifadhila
--

CREATE OR REPLACE FUNCTION public.valid_time_slice(chosen_date date) RETURNS TABLE(rent_id integer, room_id integer, organization_id integer, event_name character varying, t_reg_start date, t_reg_end date, t_deletion date)
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


-- ALTER FUNCTION public.valid_time_slice(chosen_date date) OWNER TO haifadhila;

--
-- Name: valid_time_slice(character varying, date); Type: FUNCTION; Schema: public; Owner: haifadhila
--

CREATE OR REPLACE FUNCTION public.valid_time_slice(table_name character varying, chosen_date date) RETURNS void
    LANGUAGE plpgsql
    AS $$
	BEGIN
		if (table_name = 'room') then
			SELECT * FROM room_valid_time_slice(chosen_date);
		end if;
    END;
$$;


-- ALTER FUNCTION public.valid_time_slice(table_name character varying, chosen_date date) OWNER TO haifadhila;