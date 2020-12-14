--
-- PostgreSQL database dump
--

-- Dumped from database version 12.4 (Debian 12.4-1.pgdg90+1)
-- Dumped by pg_dump version 12.4 (Debian 12.4-1.pgdg90+1)

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
-- Name: citext; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS citext WITH SCHEMA public;


--
-- Name: EXTENSION citext; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION citext IS 'data type for case-insensitive character strings';


SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: language; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.language (
    id integer NOT NULL,
    name text
);


ALTER TABLE public.language OWNER TO postgres;

--
-- Name: language_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.language_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.language_id_seq OWNER TO postgres;

--
-- Name: language_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.language_id_seq OWNED BY public.language.id;


--
-- Name: partner; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.partner (
    id integer NOT NULL,
    operator_id integer NOT NULL,
    name public.citext NOT NULL,
    description text
);


ALTER TABLE public.partner OWNER TO postgres;

--
-- Name: partner_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.partner_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.partner_id_seq OWNER TO postgres;

--
-- Name: partner_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.partner_id_seq OWNED BY public.partner.id;


--
-- Name: price_plan; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.price_plan (
    price_id integer NOT NULL,
    price_name public.citext NOT NULL,
    price_plan_type smallint NOT NULL,
    price_schema_type smallint NOT NULL,
    price_serv_cont_type smallint NOT NULL,
    price_charge_type smallint NOT NULL,
    price_rental_type smallint
);


ALTER TABLE public.price_plan OWNER TO postgres;

--
-- Name: price_plan_price_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.price_plan_price_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.price_plan_price_id_seq OWNER TO postgres;

--
-- Name: price_plan_price_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.price_plan_price_id_seq OWNED BY public.price_plan.price_id;


--
-- Name: provisioning; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.provisioning (
    provisioning_id integer NOT NULL,
    endpoint_url text NOT NULL
);


ALTER TABLE public.provisioning OWNER TO postgres;

--
-- Name: provisioning_provisioning_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.provisioning_provisioning_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.provisioning_provisioning_id_seq OWNER TO postgres;

--
-- Name: provisioning_provisioning_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.provisioning_provisioning_id_seq OWNED BY public.provisioning.provisioning_id;


--
-- Name: service; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.service (
    service_id integer NOT NULL,
    service_name public.citext NOT NULL,
    operator_id integer NOT NULL,
    partner_id integer NOT NULL,
    service_price_plan integer,
    service_channel integer[],
    service_subs_consent smallint NOT NULL,
    service_description text,
    CONSTRAINT service_operator_id_check CHECK ((operator_id >= 0)),
    CONSTRAINT service_partner_id_check CHECK ((partner_id >= 0)),
    CONSTRAINT service_service_channel_check CHECK ((0 < ALL (service_channel))),
    CONSTRAINT service_service_price_plan_check CHECK ((service_price_plan >= 0))
);


ALTER TABLE public.service OWNER TO postgres;

--
-- Name: service_message; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.service_message (
    service_id integer,
    message_type smallint NOT NULL,
    message_lang integer,
    message_content text,
    message_channel smallint NOT NULL,
    message_status smallint NOT NULL,
    CONSTRAINT service_message_message_lang_check CHECK ((message_lang >= 0)),
    CONSTRAINT service_message_service_id_check CHECK ((service_id >= 0))
);


ALTER TABLE public.service_message OWNER TO postgres;

--
-- Name: service_provision; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.service_provision (
    id integer NOT NULL,
    service_id integer,
    provision_cycle smallint NOT NULL,
    provisioning_id integer,
    CONSTRAINT service_provision_provisioning_id_check CHECK ((provisioning_id >= 0)),
    CONSTRAINT service_provision_service_id_check CHECK ((service_id >= 0))
);


ALTER TABLE public.service_provision OWNER TO postgres;

--
-- Name: service_provision_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.service_provision_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.service_provision_id_seq OWNER TO postgres;

--
-- Name: service_provision_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.service_provision_id_seq OWNED BY public.service_provision.id;


--
-- Name: service_service_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.service_service_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.service_service_id_seq OWNER TO postgres;

--
-- Name: service_service_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.service_service_id_seq OWNED BY public.service.service_id;


--
-- Name: subscription_channel; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.subscription_channel (
    id integer NOT NULL,
    name text
);


ALTER TABLE public.subscription_channel OWNER TO postgres;

--
-- Name: subscription_channel_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.subscription_channel_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.subscription_channel_id_seq OWNER TO postgres;

--
-- Name: subscription_channel_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.subscription_channel_id_seq OWNED BY public.subscription_channel.id;


--
-- Name: language id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.language ALTER COLUMN id SET DEFAULT nextval('public.language_id_seq'::regclass);


--
-- Name: partner id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.partner ALTER COLUMN id SET DEFAULT nextval('public.partner_id_seq'::regclass);


--
-- Name: price_plan price_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.price_plan ALTER COLUMN price_id SET DEFAULT nextval('public.price_plan_price_id_seq'::regclass);


--
-- Name: provisioning provisioning_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.provisioning ALTER COLUMN provisioning_id SET DEFAULT nextval('public.provisioning_provisioning_id_seq'::regclass);


--
-- Name: service service_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.service ALTER COLUMN service_id SET DEFAULT nextval('public.service_service_id_seq'::regclass);


--
-- Name: service_provision id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.service_provision ALTER COLUMN id SET DEFAULT nextval('public.service_provision_id_seq'::regclass);


--
-- Name: subscription_channel id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.subscription_channel ALTER COLUMN id SET DEFAULT nextval('public.subscription_channel_id_seq'::regclass);


--
-- Data for Name: language; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.language (id, name) FROM stdin;
2	nepali
3	sinhala
1	english
\.


--
-- Data for Name: partner; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.partner (id, operator_id, name, description) FROM stdin;
1	1	Partner1	Partner 1 description
2	1	Partner2	Partner 2 description
\.


--
-- Data for Name: price_plan; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.price_plan (price_id, price_name, price_plan_type, price_schema_type, price_serv_cont_type, price_charge_type, price_rental_type) FROM stdin;
1	pricePlan1	101	113	112	121	130
2	pricePlan2	101	113	112	121	133
3	pricePlan3	101	115	112	121	\N
4	pricePlan4	101	115	112	121	\N
\.


--
-- Data for Name: provisioning; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.provisioning (provisioning_id, endpoint_url) FROM stdin;
1	http://ncelo.com/subscription/
2	http://ncelo.com/unsubscription/
3	http://ncelo.com/grace/
4	http://ncelo.com/subscription/
5	http://ncelo.com/suspend/
\.


--
-- Data for Name: service; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.service (service_id, service_name, operator_id, partner_id, service_price_plan, service_channel, service_subs_consent, service_description) FROM stdin;
1	Service1	1	1	1	{1}	1	Service 1 description
2	Service2	1	1	2	{1,2}	1	Service 2 description
\.


--
-- Data for Name: service_message; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.service_message (service_id, message_type, message_lang, message_content, message_channel, message_status) FROM stdin;
1	0	1	Consent message 111	1	0
1	0	1	Consent message 112	2	0
1	0	2	Consent message 122	2	0
2	0	2	Consent message 221	1	0
2	0	1	Consent message 212	2	0
\.


--
-- Data for Name: service_provision; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.service_provision (id, service_id, provision_cycle, provisioning_id) FROM stdin;
1	1	150	1
2	1	150	4
3	1	151	2
4	2	150	4
5	2	151	2
\.


--
-- Data for Name: subscription_channel; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.subscription_channel (id, name) FROM stdin;
1	ussd
2	sms
\.


--
-- Name: language_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.language_id_seq', 3, true);


--
-- Name: partner_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.partner_id_seq', 2, true);


--
-- Name: price_plan_price_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.price_plan_price_id_seq', 4, true);


--
-- Name: provisioning_provisioning_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.provisioning_provisioning_id_seq', 5, true);


--
-- Name: service_provision_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.service_provision_id_seq', 5, true);


--
-- Name: service_service_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.service_service_id_seq', 2, true);


--
-- Name: subscription_channel_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.subscription_channel_id_seq', 2, true);


--
-- Name: language language_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.language
    ADD CONSTRAINT language_pkey PRIMARY KEY (id);


--
-- Name: partner partner_name_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.partner
    ADD CONSTRAINT partner_name_key UNIQUE (name);


--
-- Name: partner partner_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.partner
    ADD CONSTRAINT partner_pkey PRIMARY KEY (id);


--
-- Name: price_plan price_plan_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.price_plan
    ADD CONSTRAINT price_plan_pkey PRIMARY KEY (price_id);


--
-- Name: price_plan price_plan_price_name_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.price_plan
    ADD CONSTRAINT price_plan_price_name_key UNIQUE (price_name);


--
-- Name: provisioning provisioning_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.provisioning
    ADD CONSTRAINT provisioning_pkey PRIMARY KEY (provisioning_id);


--
-- Name: service service_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.service
    ADD CONSTRAINT service_pkey PRIMARY KEY (service_id);


--
-- Name: service_provision service_provision_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.service_provision
    ADD CONSTRAINT service_provision_pkey PRIMARY KEY (id);


--
-- Name: service service_service_name_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.service
    ADD CONSTRAINT service_service_name_key UNIQUE (service_name);


--
-- Name: subscription_channel subscription_channel_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.subscription_channel
    ADD CONSTRAINT subscription_channel_pkey PRIMARY KEY (id);


--
-- Name: service_message service_message_message_lang_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.service_message
    ADD CONSTRAINT service_message_message_lang_fkey FOREIGN KEY (message_lang) REFERENCES public.language(id) ON DELETE RESTRICT;


--
-- Name: service_message service_message_service_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.service_message
    ADD CONSTRAINT service_message_service_id_fkey FOREIGN KEY (service_id) REFERENCES public.service(service_id) ON DELETE CASCADE;


--
-- Name: service_provision service_provision_provisioning_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.service_provision
    ADD CONSTRAINT service_provision_provisioning_id_fkey FOREIGN KEY (provisioning_id) REFERENCES public.provisioning(provisioning_id) ON DELETE RESTRICT;


--
-- Name: service_provision service_provision_service_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.service_provision
    ADD CONSTRAINT service_provision_service_id_fkey FOREIGN KEY (service_id) REFERENCES public.service(service_id) ON DELETE CASCADE;


--
-- Name: service service_service_price_plan_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.service
    ADD CONSTRAINT service_service_price_plan_fkey FOREIGN KEY (service_price_plan) REFERENCES public.price_plan(price_id) ON DELETE RESTRICT;


--
-- PostgreSQL database dump complete
--

