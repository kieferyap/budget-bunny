--
-- PostgreSQL database dump
--

-- Dumped from database version 9.5.2
-- Dumped by pg_dump version 9.5.2

SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
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


SET search_path = public, pg_catalog;

--
-- Name: features_seq; Type: SEQUENCE; Schema: public; Owner: kiefer
--

CREATE SEQUENCE features_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE features_seq OWNER TO kiefer;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: features; Type: TABLE; Schema: public; Owner: kiefer
--

CREATE TABLE features (
    feature_id integer DEFAULT nextval('features_seq'::regclass) NOT NULL,
    requirement_key character varying(8) NOT NULL,
    description text NOT NULL,
    is_bug boolean DEFAULT false,
    inserted_on timestamp without time zone DEFAULT now()
);


ALTER TABLE features OWNER TO kiefer;

--
-- Name: localizable_words_seq; Type: SEQUENCE; Schema: public; Owner: kiefer
--

CREATE SEQUENCE localizable_words_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE localizable_words_seq OWNER TO kiefer;

--
-- Name: localizable_words; Type: TABLE; Schema: public; Owner: kiefer
--

CREATE TABLE localizable_words (
    localizable_word_id integer DEFAULT nextval('localizable_words_seq'::regclass) NOT NULL,
    wording_key character varying(64) NOT NULL,
    localization_en text NOT NULL,
    localization_jp text,
    localization_zh text,
    inserted_on timestamp without time zone DEFAULT now()
);


ALTER TABLE localizable_words OWNER TO kiefer;

--
-- Data for Name: features; Type: TABLE DATA; Schema: public; Owner: kiefer
--

COPY features (feature_id, requirement_key, description, is_bug, inserted_on) FROM stdin;
1	GEN-0001	Create Single View App, Project Structure	f	2016-04-07 15:05:20.809082
2	GEN-0002	Core Data	f	2016-04-07 15:05:20.811046
3	GEN-0003	Scripts for Localization, Images, Screen Constants, Cell Identifiers	f	2016-04-07 15:05:20.813123
4	GEN-0004	Application Icon	f	2016-04-07 15:05:20.817772
5	GEN-0005	LaTeX Document	f	2016-04-07 15:05:20.819195
6	GEN-0006	Unit Testing and UI Testing on Git	f	2016-04-07 15:05:20.820827
7	GEN-0007	Storyboard -- tabs and screens	f	2016-04-07 15:05:20.822396
8	ACC-0001	Add New Account Screen	f	2016-04-07 15:05:29.876237
9	ACC-0002	Account Display Screen	f	2016-04-07 15:05:29.878102
10	ACC-0003	Edit Account Screen	f	2016-04-07 15:05:29.879729
11	BUD-0001	Add New Budget Screen	f	2016-04-07 15:05:29.881611
12	BUD-0002	Budget Display Screen	f	2016-04-07 15:05:29.883045
13	BUD-0003	Budget Calculation -- Monthly, Weekly, Daily	f	2016-04-07 15:05:29.884516
14	BUD-0004	Budget Editing	f	2016-04-07 15:05:29.885677
15	BUD-0005	Budget Category Editing	f	2016-04-07 15:05:29.887012
16	DSH-0001	Posting a new transaction (Post, Amount, Notes)	f	2016-04-07 15:05:29.888922
17	DSH-0002	Posting a new transaction (Type, Category/Subcategory)	f	2016-04-07 15:05:29.976284
18	DSH-0003	Dashboard Account Display, Spent Today, and Transaction List	f	2016-04-07 15:05:29.978551
19	STN-0001	Settings screen	f	2016-04-07 15:05:29.980151
20	RCD-0001	Calendar Display	f	2016-04-07 15:05:29.983488
21	RCD-0002	Calendar Monthly Navigation	f	2016-04-07 15:05:29.984826
22	RCD-0003	Calendar Yearly/Monthly Switching	f	2016-04-07 15:05:29.986116
23	RCD-0004	Calendar Yearly Navigation	f	2016-04-07 15:05:29.987309
24	RCD-0005	Data: Total	f	2016-04-07 15:05:29.988329
25	RCD-0006	Data: Transactions	f	2016-04-07 15:05:30.075898
26	RCD-0007	Data: Graphs	f	2016-04-07 15:05:30.077332
27	RCD-0008	Targets: New Target	f	2016-04-07 15:05:30.078858
28	RCD-0009	Targets: Display Target	f	2016-04-07 15:05:30.080395
\.


--
-- Name: features_seq; Type: SEQUENCE SET; Schema: public; Owner: kiefer
--

SELECT pg_catalog.setval('features_seq', 28, true);


--
-- Data for Name: localizable_words; Type: TABLE DATA; Schema: public; Owner: kiefer
--

COPY localizable_words (localizable_word_id, wording_key, localization_en, localization_jp, localization_zh, inserted_on) FROM stdin;
1	LBL_ACCOUNT	Account	アカウント	帐户	2016-04-07 15:05:30.083118
2	LBL_BUDGET	Budget	バジェット	预算	2016-04-07 15:05:30.085258
\.


--
-- Name: localizable_words_seq; Type: SEQUENCE SET; Schema: public; Owner: kiefer
--

SELECT pg_catalog.setval('localizable_words_seq', 2, true);


--
-- Name: features_pkey; Type: CONSTRAINT; Schema: public; Owner: kiefer
--

ALTER TABLE ONLY features
    ADD CONSTRAINT features_pkey PRIMARY KEY (feature_id);


--
-- Name: localizable_words_pkey; Type: CONSTRAINT; Schema: public; Owner: kiefer
--

ALTER TABLE ONLY localizable_words
    ADD CONSTRAINT localizable_words_pkey PRIMARY KEY (localizable_word_id);


--
-- Name: public; Type: ACL; Schema: -; Owner: kiefer
--

REVOKE ALL ON SCHEMA public FROM PUBLIC;
REVOKE ALL ON SCHEMA public FROM kiefer;
GRANT ALL ON SCHEMA public TO kiefer;
GRANT ALL ON SCHEMA public TO PUBLIC;


--
-- PostgreSQL database dump complete
--

