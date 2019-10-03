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

SET default_tablespace = '';

SET default_with_oids = false;

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
\.


--
-- Name: organization_organization_id_seq; Type: SEQUENCE SET; Schema: public; Owner: haifadhila
--

SELECT pg_catalog.setval('public.organization_organization_id_seq', 4, true);


--
-- Name: renting_rent_id_seq; Type: SEQUENCE SET; Schema: public; Owner: haifadhila
--

SELECT pg_catalog.setval('public.renting_rent_id_seq', 5, true);


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

