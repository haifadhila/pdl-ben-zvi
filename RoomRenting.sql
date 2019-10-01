--
-- PostgreSQL database dump
--

-- Dumped from database version 9.6.9
-- Dumped by pg_dump version 9.6.9

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: organization; Type: TABLE; Schema: public; Owner: niraramadhani
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


ALTER TABLE public.organization OWNER TO niraramadhani;

--
-- Name: organization_organization_id_seq; Type: SEQUENCE; Schema: public; Owner: niraramadhani
--

CREATE SEQUENCE public.organization_organization_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.organization_organization_id_seq OWNER TO niraramadhani;

--
-- Name: organization_organization_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: niraramadhani
--

ALTER SEQUENCE public.organization_organization_id_seq OWNED BY public.organization.organization_id;


--
-- Name: renting; Type: TABLE; Schema: public; Owner: niraramadhani
--

CREATE TABLE public.renting (
    rent_id integer NOT NULL,
    room_id integer NOT NULL,
    organization_id integer NOT NULL,
    t_eff_start date,
    t_reg_start date,
    t_eff_end date,
    t_reg_end date,
    t_deletion date
);


ALTER TABLE public.renting OWNER TO niraramadhani;

--
-- Name: renting_rent_id_seq; Type: SEQUENCE; Schema: public; Owner: niraramadhani
--

CREATE SEQUENCE public.renting_rent_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.renting_rent_id_seq OWNER TO niraramadhani;

--
-- Name: renting_rent_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: niraramadhani
--

ALTER SEQUENCE public.renting_rent_id_seq OWNED BY public.renting.rent_id;


--
-- Name: room; Type: TABLE; Schema: public; Owner: niraramadhani
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


ALTER TABLE public.room OWNER TO niraramadhani;

--
-- Name: room_room_id_seq; Type: SEQUENCE; Schema: public; Owner: niraramadhani
--

CREATE SEQUENCE public.room_room_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.room_room_id_seq OWNER TO niraramadhani;

--
-- Name: room_room_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: niraramadhani
--

ALTER SEQUENCE public.room_room_id_seq OWNED BY public.room.room_id;


--
-- Name: organization organization_id; Type: DEFAULT; Schema: public; Owner: niraramadhani
--

ALTER TABLE ONLY public.organization ALTER COLUMN organization_id SET DEFAULT nextval('public.organization_organization_id_seq'::regclass);


--
-- Name: renting rent_id; Type: DEFAULT; Schema: public; Owner: niraramadhani
--

ALTER TABLE ONLY public.renting ALTER COLUMN rent_id SET DEFAULT nextval('public.renting_rent_id_seq'::regclass);


--
-- Name: room room_id; Type: DEFAULT; Schema: public; Owner: niraramadhani
--

ALTER TABLE ONLY public.room ALTER COLUMN room_id SET DEFAULT nextval('public.room_room_id_seq'::regclass);


--
-- Data for Name: organization; Type: TABLE DATA; Schema: public; Owner: niraramadhani
--

COPY public.organization (organization_id, organization_name, t_eff_start, t_reg_start, t_eff_end, t_reg_end, t_deletion) FROM stdin;
1	HMIF	2018-11-10	2018-11-11	\N	\N	\N
2	IMT	2018-02-14	2018-02-14	\N	\N	\N
3	HME	2018-05-03	2018-05-04	\N	\N	\N
4	KM ITB	2018-01-12	2018-01-13	\N	\N	\N
\.


--
-- Name: organization_organization_id_seq; Type: SEQUENCE SET; Schema: public; Owner: niraramadhani
--

SELECT pg_catalog.setval('public.organization_organization_id_seq', 4, true);


--
-- Data for Name: renting; Type: TABLE DATA; Schema: public; Owner: niraramadhani
--

COPY public.renting (rent_id, room_id, organization_id, t_eff_start, t_reg_start, t_eff_end, t_reg_end, t_deletion) FROM stdin;
\.


--
-- Name: renting_rent_id_seq; Type: SEQUENCE SET; Schema: public; Owner: niraramadhani
--

SELECT pg_catalog.setval('public.renting_rent_id_seq', 1, false);


--
-- Data for Name: room; Type: TABLE DATA; Schema: public; Owner: niraramadhani
--

COPY public.room (room_id, room_name, t_eff_start, t_reg_start, t_eff_end, t_reg_end, t_deletion) FROM stdin;
2	Programming	2018-02-05	2018-02-07	\N	\N	\N
4	Auditorium 2	2018-09-03	2018-09-05	\N	\N	\N
5	Multimedia	2018-10-12	2018-10-14	\N	\N	\N
1	Informatika Dasar	2018-01-18	2018-01-20	\N	\N	\N
3	Auditorium 1	2018-06-15	2018-06-17	2019-02-03	2019-01-03	\N
\.


--
-- Name: room_room_id_seq; Type: SEQUENCE SET; Schema: public; Owner: niraramadhani
--

SELECT pg_catalog.setval('public.room_room_id_seq', 5, true);


--
-- Name: organization organization_pkey; Type: CONSTRAINT; Schema: public; Owner: niraramadhani
--

ALTER TABLE ONLY public.organization
    ADD CONSTRAINT organization_pkey PRIMARY KEY (organization_id);


--
-- Name: renting renting_pkey; Type: CONSTRAINT; Schema: public; Owner: niraramadhani
--

ALTER TABLE ONLY public.renting
    ADD CONSTRAINT renting_pkey PRIMARY KEY (rent_id);


--
-- Name: room room_pkey; Type: CONSTRAINT; Schema: public; Owner: niraramadhani
--

ALTER TABLE ONLY public.room
    ADD CONSTRAINT room_pkey PRIMARY KEY (room_id);


--
-- Name: renting organization_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: niraramadhani
--

ALTER TABLE ONLY public.renting
    ADD CONSTRAINT organization_id_fkey FOREIGN KEY (organization_id) REFERENCES public.organization(organization_id);


--
-- Name: renting room_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: niraramadhani
--

ALTER TABLE ONLY public.renting
    ADD CONSTRAINT room_id_fkey FOREIGN KEY (room_id) REFERENCES public.room(room_id);


--
-- PostgreSQL database dump complete
--

