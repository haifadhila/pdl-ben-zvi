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
3	4	3	Pelatihan Lomba	2019-09-01	2019-08-23	2019-09-07	2019-08-23	2019-09-01
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

SELECT pg_catalog.setval('public.renting_rent_id_seq', 4, true);


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

