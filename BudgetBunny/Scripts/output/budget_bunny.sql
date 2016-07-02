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
1	GEN-0001	Create single view app, project structure.	f	2016-05-01 19:45:48.613827
2	GEN-0002	Core data	f	2016-05-01 19:45:48.650281
3	GEN-0003	Scripts for localization, images, screen constants, cell identifiers	f	2016-05-01 19:45:48.653613
4	GEN-0004	Application icon	f	2016-05-01 19:45:48.657628
5	GEN-0005	LaTeX document	f	2016-05-01 19:45:48.659673
6	GEN-0006	Unit testing and UI testing on Git	f	2016-05-01 19:45:48.662047
7	GEN-0007	Storyboard - tabs and screens	f	2016-05-01 19:45:48.66453
8	ACC-0001	Add new account screen	f	2016-05-01 19:45:48.66708
9	ACC-0002	Account display screen	f	2016-05-01 19:45:48.669069
10	ACC-0003	Edit account screen	f	2016-05-01 19:45:48.712514
11	BUD-0001	Add new budget screen	f	2016-05-01 19:45:48.71517
12	BUD-0002	Budget display screen	f	2016-05-01 19:45:48.717503
13	BUD-0003	Budget calculation - monthly, weekly, daily	f	2016-05-01 19:45:48.720231
14	BUD-0004	Budget editing	f	2016-05-01 19:45:48.722133
15	BUD-0005	Budget category editing	f	2016-05-01 19:45:48.724232
16	DSH-0001	Posting a new transaction (Post, Amount, Notes)	f	2016-05-01 19:45:48.7277
17	DSH-0002	Posting a new transaction (Type, Category/Subcategory)	f	2016-05-01 19:45:48.730651
18	DSH-0003	Dashboard Account Display, Spent Today, and Transaction List	f	2016-05-01 19:45:48.733641
19	STN-0001	Settings screen	f	2016-05-01 19:45:48.811393
20	RCD-0001	Calendar Display	f	2016-05-01 19:45:48.814644
21	RCD-0002	Calendar Monthly Navigation	f	2016-05-01 19:45:48.817038
22	RCD-0003	Calendar Yearly/Monthly Switching	f	2016-05-01 19:45:48.81947
23	RCD-0004	Calendar Yearly Navigation	f	2016-05-01 19:45:48.821763
24	RCD-0005	Data: Total	f	2016-05-01 19:45:48.823611
25	RCD-0006	Data: Transactions	f	2016-05-01 19:45:48.825624
26	RCD-0007	Data: Graphs	f	2016-05-01 19:45:48.827447
27	RCD-0008	Targets: New Target	f	2016-05-01 19:45:48.829423
28	RCD-0009	Targets: Display Target	f	2016-05-01 19:45:49.688233
\.


--
-- Name: features_seq; Type: SEQUENCE SET; Schema: public; Owner: kiefer
--

SELECT pg_catalog.setval('features_seq', 28, true);


--
-- Data for Name: localizable_words; Type: TABLE DATA; Schema: public; Owner: kiefer
--

COPY localizable_words (localizable_word_id, wording_key, localization_en, localization_jp, localization_zh, inserted_on) FROM stdin;
33	LABEL_WARNING_DELETE_ACCOUNT_MESSAGE	The account, and all its associated transactions will be deleted. Are you sure?	アカウントとアカウントの取引を削除します。	[Not localized yet]	2016-06-01 01:57:06.689566
34	BUTTON_CANCEL	Cancel	キャンセル	[Not localized yet]	2016-06-01 01:57:06.693366
6	LABEL_CURRENCY	Currency	通貨	货币	2016-05-01 19:45:58.272206
7	LABEL_STARTING_BALANCE	Starting Balance	開始残高	起始余额	2016-05-01 19:45:58.313389
23	BUTTON_DELETE_ACCOUNT	Delete Account	アカウントを削除	[Not localized yet]	2016-05-21 20:52:42.968125
8	TEXTFIELD_STARTING_BALANCE_PLACEHOLDER	100	1000	600	2016-05-01 19:45:58.317714
31	BUTTON_DELETE_ACCOUNT_DISABLED	Default accounts cannot be deleted.	削除できません	[Not localized yet]	2016-06-01 01:45:23.348516
41	LABEL_BUDGET	Budget	[Not localized yet]	[Not localized yet]	2016-06-26 18:50:05.216897
42	LABEL_BUDGET_NAME	Budget Name	[Not localized yet]	[Not localized yet]	2016-06-26 18:50:05.222798
9	LABEL_IS_DEFAULT_ACCOUNT	Default Account	デフォルトのアカウント	默认帐户	2016-05-01 19:45:58.32213
43	TEXTFIELD_BUDGET_PLACEHOLDER	Food and Groceries	[Not localized yet]	[Not localized yet]	2016-06-26 18:50:05.227585
29	BUTTON_SET_DEFAULT	Set\\nDefault	デフォルト\\nとして設定	[Not localized yet]	2016-05-29 17:17:59.750267
35	MENULABEL_EDIT_ACCOUNT	Edit Account	編集	[Not localized yet]	2016-06-06 22:47:07.784103
44	LABEL_MONTHLY	Monthly	[Not localized yet]	[Not localized yet]	2016-06-26 18:50:05.23151
55	ERRORLABEL_NO_CATEGORIES	Please add at least one category.	[Not localized yet]	[Not localized yet]	2016-07-02 19:39:08.737418
2	MENULABEL_ADD_ACCOUNT	Add New Account	追加	新帐户	2016-05-01 19:45:58.256828
3	MENULABEL_CURRENCY_PICKER	Currency	通貨	货币	2016-05-01 19:45:58.260746
4	LABEL_NAME	Account Name	アカウント名	货币的名称	2016-05-01 19:45:58.26445
5	TEXTFIELD_NAME_PLACEHOLDER	My Wallet	私の財布	我的钱包	2016-05-01 19:45:58.26876
10	LABEL_IS_DEFAULT_ACCOUNT_DESCRIPTION	The default account to use for everyday transactions	毎日に使うアカウント	毎天用的帐户	2016-05-01 19:45:58.327688
12	BUTTON_DONE	Done	完了	完成	2016-05-01 19:46:00.824602
15	LABEL_OK	OK	OK	OK	2016-05-01 19:58:59.708225
16	ERRORLABEL_ERROR_TITLE	Error	エラー	[Not localizaed yet]	2016-05-01 20:29:22.122071
45	LABEL_WEEKLY	Weekly	[Not localized yet]	[Not localized yet]	2016-06-26 18:50:05.235436
17	ERRORLABEL_INTERNAL_ERROR	An internal error has occured. Please try again later.	内部エラーが発生しました。	[Not localizaed yet]	2016-05-10 01:04:25.576925
18	BUTTON_DELETE	Delete	削除	[Not localized yet]	2016-05-15 16:44:05.227482
19	LABEL_DEFAULT	DEFAULT	デフォルト	[Not localized yet]	2016-05-15 20:54:52.783206
21	BUTTON_SAVE	Save	保存	[Not localized yet]	2016-05-21 20:52:42.958043
11	GUIDELABEL_LOADING	Loading...	ローディング中...	加載...	2016-05-01 19:45:58.331333
20	GUIDELABEL_NO_ACCOUNTS	There are no accounts yet.\\n\\nTo add a new account, tap the + sign located at the upper right corner of the screen.	[アカウントがありません。\\n\\n新しいアカウントを追加するには、+ をタップしてください。	[Not localized yet]	2016-05-21 20:52:42.711997
46	LABEL_DAILY	Daily	[Not localized yet]	[Not localized yet]	2016-06-26 18:50:05.312173
47	TEXTFIELD_XLY_BUDGET_PLACEHOLDER	1000	[Not localized yet]	[Not localized yet]	2016-06-26 18:50:05.316798
27	ERRORLABEL_DUPLICATE_ACCOUNT_NAME	The account name already exists.	アカウントの名前が既に存在します。	[Not localized yet]	2016-05-21 21:22:39.38273
22	BUTTON_SET_AS_DEFAULT	Set as Default	デフォルトとして設定	[Not localized yet]	2016-05-21 20:52:42.963768
32	LABEL_WARNING_DELETE_ACCOUNT_TITLE	Warning: This action cannot be undone.	このアクションは元に戻すことはできません	[Not localized yet]	2016-06-01 01:57:06.664948
36	MENULABEL_BUDGETS	Budgets	バジェット	[Not localized yet]	2016-06-07 01:38:11.819856
37	MENULABEL_DASHBOARD	Dashboard	ダッシュボード	[Not localized yet]	2016-06-07 01:38:11.82618
38	MENULABEL_RECORDS	Records	記録	[Not localized yet]	2016-06-07 01:38:11.830419
56	ERRORLABEL_CATEGORY_NOT_EMPTY	The category name must not be left blank.	[Not localized yet]	[Not localized yet]	2016-07-02 19:39:57.0491
48	TEXTFIELD_NEW_CATEGORY_PLACEHOLDER	Add New Category	[Not localized yet]	[Not localized yet]	2016-06-26 18:50:05.321636
28	BUTTON_EDIT	Edit	編集	[Not localized yet]	2016-05-28 16:58:29.215243
26	LABEL_CURRENT_BALANCE	Current Balance	経常収支	[Not localized yet]	2016-05-21 20:52:43.054826
39	ERRORLABEL_TOO_MANY_ACCOUNTS	The number of accounts created has been exceeded.\\nKindly delete an account before proceeding.	アカウント数の上限を超えています。	[Not localized yet]	2016-06-23 01:02:37.812749
49	ERRORLABEL_DUPLICATE_CATEGORY_NAME	The category name already exists in this budget.	[Not localized yet]	[Not localized yet]	2016-06-26 18:50:05.327302
30	BUTTON_SET_AS_DEFAULT_DISABLED	This is the default account.	このアカウントはデフォルトです	[Not localized yet]	2016-06-01 01:45:23.069191
50	LABEL_MONTHLY_BUDGET	Monthly Budget	[Not localized yet]	[Not localized yet]	2016-06-26 18:59:13.41209
51	LABEL_WEEKLY_BUDGET	Weekly Budget	[Not localized yet]	[Not localized yet]	2016-06-26 18:59:13.415938
52	LABEL_DAILY_BUDGET	Daily Budget	[Not localized yet]	[Not localized yet]	2016-06-26 18:59:13.420882
53	ERRORLABEL_TOO_MANY_CATEGORIES	The number of categories created has been exceeded.\\nKindly delete an category before proceeding.	[Not localized yet]	[Not localized yet]	2016-06-30 01:40:44.607786
54	ERRORLABEL_DUPLICATE_BUDGET_NAME	The budget name already exists.	[Not localized yet]	[Not localized yet]	2016-06-30 01:40:44.712521
14	ERRORLABEL_NAME_AMOUNT_NOT_EMPTY	The name and amount must not be left blank.	アカウントの名前とアカウントの残高を入力してください。	[Not localizaed yet]	2016-05-01 19:58:57.219882
1	MENULABEL_ACCOUNT	Accounts	アカウント	帐户	2016-05-01 19:45:58.215002
40	MENULABEL_ADD_BUDGET	Add New Budget	[Not localized yet]	[Not localized yet]	2016-06-26 18:50:04.955272
\.


--
-- Name: localizable_words_seq; Type: SEQUENCE SET; Schema: public; Owner: kiefer
--

SELECT pg_catalog.setval('localizable_words_seq', 56, true);


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

