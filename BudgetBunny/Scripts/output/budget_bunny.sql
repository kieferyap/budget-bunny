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
3	MENULABEL_ACCOUNT	Account	アカウント	帐户	2016-04-26 14:10:39.122605
4	MENULABEL_ADD_ACCOUNT	Add New Account	追加	新帐户	2016-04-26 14:10:39.173172
5	MENULABEL_CURRENCY_PICKER	Currency	通貨	货币	2016-04-26 14:10:39.175402
6	LABEL_NAME	Account Name	アカウント名	货币的名称	2016-04-26 14:10:39.177616
7	TEXTFIELD_NAME_PLACEHOLDER	My Wallet	私の財布	我的钱包	2016-04-26 14:10:39.179932
8	LABEL_CURRENCY	Currency	通貨	货币	2016-04-26 14:10:39.181916
9	LABEL_STARTING_BALANCE	Starting Balance	開始残高	起始余额	2016-04-26 14:10:39.222807
10	TEXTFIELD_STARTING_BALANCE_PLACEHOLDER	100	1000	600	2016-04-26 14:10:39.225605
11	LABEL_IS_DEFAULT_ACCOUNT	Default Account	デフォルトのアカウント	默认帐户	2016-04-26 14:10:39.228502
12	LABEL_IS_DEFAULT_ACCOUNT_DESCRIPTION	The default account to use for everyday transactions	毎日に使うアカウント	毎天用的帐户	2016-04-26 14:10:39.232309
13	LABEL_LOADING	Loading...	ローディング中...	加載...	2016-05-31 11:22:49.822924
14	BUTTON_DONE	Done	完了	完成	2016-05-31 11:22:49.906702
17	ERRORLABEL_ERROR_TITLE	Error	[Not localizaed yet]	[Not localizaed yet]	2016-05-31 11:22:49.917326
18	LABEL_OK	OK	OK	OK	2016-05-31 11:22:49.922245
15	ERRORLABEL_NAME_CURRENCY_NOT_EMPTY	The name and initial amount must not be left blank.	[Not localizaed yet]	[Not localizaed yet]	2016-05-31 11:22:49.910952
16	ERRORLABEL_INTERNAL_ERROR	An internal error has occured. Please try again later.	[Not localizaed yet]	[Not localizaed yet]	2016-05-31 11:22:49.914506
19	BUTTON_DELETE	Delete	削除	[Not localized yet]	2016-05-31 11:22:49.961696
20	LABEL_DEFAULT	DEFAULT	デフォルト	[Not localized yet]	2016-05-31 11:22:49.963989
21	LABEL_NO_ACCOUNTS	There are no accounts yet.\\n\\nTo add a new account, tap the + sign located at the upper right corner of the screen.	[Not localized yet]	[Not localized yet]	2016-05-31 11:22:50.021745
22	BUTTON_SAVE	Save	[Not localized yet]	[Not localized yet]	2016-05-31 11:22:50.024915
24	BUTTON_DELETE_ACCOUNT	Delete account	[Not localized yet]	[Not localized yet]	2016-05-31 11:22:50.030863
25	LABEL_ACCOUNT_INFO	Information	[Not localized yet]	[Not localized yet]	2016-05-31 11:22:50.033551
26	LABEL_ACCOUNT_ACTIONS	Actions	[Not localized yet]	[Not localized yet]	2016-05-31 11:22:50.036227
27	LABEL_CURRENT_AMOUNT	Current amount	[Not localized yet]	[Not localized yet]	2016-05-31 11:22:50.123935
28	ERRORLABEL_DUPLICATE_ACCOUNT_NAME	The account name already exists.	[Not localized yet]	[Not localized yet]	2016-05-31 11:22:50.127694
29	BUTTON_VIEW	View	[Not localized yet]	[Not localized yet]	2016-05-31 11:22:50.131815
23	BUTTON_SET_AS_DEFAULT	Set as Default	[Not localized yet]	[Not localized yet]	2016-05-31 11:22:50.027973
31	LABEL_WARNING_DELETE_ACCOUNT_TITLE	Warning: This action cannot be undone.	[Not localized yet]	[Not localized yet]	2016-05-31 11:22:50.224483
32	LABEL_WARNING_DELETE_ACCOUNT_MESSAGE	The account, and all its associated transactions will be deleted. Are you sure?	[Not localized yet]	[Not localized yet]	2016-05-31 11:22:50.228509
33	BUTTON_CANCEL	Cancel	[Not localized yet]	[Not localized yet]	2016-05-31 11:22:50.231106
30	BUTTON_SET_DEFAULT	Set\\nDefault	[Not localized yet]	[Not localized yet]	2016-05-31 11:22:50.135839
34	BUTTON_DEFAULT_ACCOUNT_MESSAGE	This is the default account.	[Not localized yet]	[Not localized yet]	2016-06-01 16:18:51.206354
35	BUTTON_DEFAULT_ACCOUNT_DESCRIPTION	Default accounts cannot be deleted.	[Not localized yet]	[Not localized yet]	2016-06-01 16:18:51.248275
\.


--
-- Name: localizable_words_seq; Type: SEQUENCE SET; Schema: public; Owner: kiefer
--

SELECT pg_catalog.setval('localizable_words_seq', 35, true);


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

