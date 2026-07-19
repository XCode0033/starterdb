--
-- PostgreSQL database dump
--

\restrict QoWmerGaTogG1JR3MJlcOgsg6CXa1BfqKIcd8AtcfMD8ueJ8qFrKAIaMrHzitah

-- Dumped from database version 18.3 (Homebrew)
-- Dumped by pg_dump version 18.3 (Homebrew)

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: dream_tags; Type: TABLE; Schema: public; Owner: xavier
--

CREATE TABLE public.dream_tags (
    dreamtag_id integer NOT NULL,
    dream_id integer,
    tag_id integer
);


ALTER TABLE public.dream_tags OWNER TO xavier;

--
-- Name: dream_tags_dreamtag_id_seq; Type: SEQUENCE; Schema: public; Owner: xavier
--

CREATE SEQUENCE public.dream_tags_dreamtag_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.dream_tags_dreamtag_id_seq OWNER TO xavier;

--
-- Name: dream_tags_dreamtag_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: xavier
--

ALTER SEQUENCE public.dream_tags_dreamtag_id_seq OWNED BY public.dream_tags.dreamtag_id;


--
-- Name: dreams; Type: TABLE; Schema: public; Owner: xavier
--

CREATE TABLE public.dreams (
    dream_id integer CONSTRAINT dreams_id_not_null NOT NULL,
    title character varying(100) DEFAULT 'untitled'::character varying,
    dream_date character varying(50) DEFAULT CURRENT_TIMESTAMP,
    stars integer,
    description text
);


ALTER TABLE public.dreams OWNER TO xavier;

--
-- Name: dreams_id_seq; Type: SEQUENCE; Schema: public; Owner: xavier
--

CREATE SEQUENCE public.dreams_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.dreams_id_seq OWNER TO xavier;

--
-- Name: dreams_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: xavier
--

ALTER SEQUENCE public.dreams_id_seq OWNED BY public.dreams.dream_id;


--
-- Name: tags; Type: TABLE; Schema: public; Owner: xavier
--

CREATE TABLE public.tags (
    tag_id integer NOT NULL,
    tag_name character varying(20),
    tag_year integer
);


ALTER TABLE public.tags OWNER TO xavier;

--
-- Name: tags_tag_id_seq; Type: SEQUENCE; Schema: public; Owner: xavier
--

CREATE SEQUENCE public.tags_tag_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.tags_tag_id_seq OWNER TO xavier;

--
-- Name: tags_tag_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: xavier
--

ALTER SEQUENCE public.tags_tag_id_seq OWNED BY public.tags.tag_id;


--
-- Name: dream_tags dreamtag_id; Type: DEFAULT; Schema: public; Owner: xavier
--

ALTER TABLE ONLY public.dream_tags ALTER COLUMN dreamtag_id SET DEFAULT nextval('public.dream_tags_dreamtag_id_seq'::regclass);


--
-- Name: dreams dream_id; Type: DEFAULT; Schema: public; Owner: xavier
--

ALTER TABLE ONLY public.dreams ALTER COLUMN dream_id SET DEFAULT nextval('public.dreams_id_seq'::regclass);


--
-- Name: tags tag_id; Type: DEFAULT; Schema: public; Owner: xavier
--

ALTER TABLE ONLY public.tags ALTER COLUMN tag_id SET DEFAULT nextval('public.tags_tag_id_seq'::regclass);


--
-- Data for Name: dream_tags; Type: TABLE DATA; Schema: public; Owner: xavier
--

COPY public.dream_tags (dreamtag_id, dream_id, tag_id) FROM stdin;
1	1	1
2	2	2
3	2	4
4	4	4
5	4	6
6	5	5
7	6	6
8	8	3
9	9	1
10	9	5
11	10	6
12	13	1
13	13	5
14	14	3
15	14	4
16	16	2
17	17	1
18	18	4
19	18	6
20	20	3
\.


--
-- Data for Name: dreams; Type: TABLE DATA; Schema: public; Owner: xavier
--

COPY public.dreams (dream_id, title, dream_date, stars, description) FROM stdin;
1	Falling through the floor	2026-01-03	3	Kept sinking through each floor of an old house.
2	Flying over the city	2026-01-08	5	Soared above rooftops, could control altitude with my breath.
3	Lost in a school hallway	2026-01-12	2	Endless lockers, couldn't find my classroom.
4	Ocean full of stars	2026-01-15	5	Swam in water that reflected the night sky.
5	Late for a flight	2026-01-19	1	Kept missing the gate no matter how fast I ran.
6	Talking cat gave advice	2026-01-22	4	A cat calmly explained my life problems to me.
7	Endless staircase	2026-01-25	2	Climbed stairs that never reached the top.
8	Reunion with old friend	2026-01-29	5	Sat and talked for hours with someone I hadn't seen in years.
9	Car with no brakes	2026-02-02	1	Rolling downhill unable to stop, woke up in a panic.
10	Underwater city	2026-02-06	4	Explored glowing buildings beneath the sea.
11	Forgot to study for exam	2026-02-09	2	Sat down for a test I never studied for.
12	Garden that whispered	2026-02-13	3	Plants murmured secrets when I walked past.
13	Chased through the woods	2026-02-17	1	Something unseen was always one step behind.
14	Meeting my future self	2026-02-20	5	Had a long conversation with an older version of me.
15	Library with no exit	2026-02-24	2	Every hallway looped back to the same reading room.
16	Dancing in the rain	2026-02-28	4	Danced in a storm that felt warm instead of cold.
17	Giant spider in the attic	2026-03-03	1	Found something enormous hiding above the ceiling.
18	Riding a bicycle on clouds	2026-03-07	5	Pedaled across soft white clouds like solid ground.
19	Forgotten birthday party	2026-03-11	3	Showed up to a party nobody remembered planning.
20	Grandmother's old kitchen	2026-03-15	4	Smelled fresh bread in a kitchen from childhood.
\.


--
-- Data for Name: tags; Type: TABLE DATA; Schema: public; Owner: xavier
--

COPY public.tags (tag_id, tag_name, tag_year) FROM stdin;
1	nightmare	2026
2	flying	2026
3	nostalgia	2026
4	lucid	2026
5	anxiety	2026
6	surreal	2026
\.


--
-- Name: dream_tags_dreamtag_id_seq; Type: SEQUENCE SET; Schema: public; Owner: xavier
--

SELECT pg_catalog.setval('public.dream_tags_dreamtag_id_seq', 20, true);


--
-- Name: dreams_id_seq; Type: SEQUENCE SET; Schema: public; Owner: xavier
--

SELECT pg_catalog.setval('public.dreams_id_seq', 20, true);


--
-- Name: tags_tag_id_seq; Type: SEQUENCE SET; Schema: public; Owner: xavier
--

SELECT pg_catalog.setval('public.tags_tag_id_seq', 6, true);


--
-- Name: dream_tags dream_tags_pkey; Type: CONSTRAINT; Schema: public; Owner: xavier
--

ALTER TABLE ONLY public.dream_tags
    ADD CONSTRAINT dream_tags_pkey PRIMARY KEY (dreamtag_id);


--
-- Name: dreams dreams_pkey; Type: CONSTRAINT; Schema: public; Owner: xavier
--

ALTER TABLE ONLY public.dreams
    ADD CONSTRAINT dreams_pkey PRIMARY KEY (dream_id);


--
-- Name: tags tags_pkey; Type: CONSTRAINT; Schema: public; Owner: xavier
--

ALTER TABLE ONLY public.tags
    ADD CONSTRAINT tags_pkey PRIMARY KEY (tag_id);


--
-- Name: dream_tags dream_tags_dream_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: xavier
--

ALTER TABLE ONLY public.dream_tags
    ADD CONSTRAINT dream_tags_dream_id_fkey FOREIGN KEY (dream_id) REFERENCES public.dreams(dream_id);


--
-- Name: dream_tags dream_tags_tag_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: xavier
--

ALTER TABLE ONLY public.dream_tags
    ADD CONSTRAINT dream_tags_tag_id_fkey FOREIGN KEY (tag_id) REFERENCES public.tags(tag_id);


--
-- PostgreSQL database dump complete
--

\unrestrict QoWmerGaTogG1JR3MJlcOgsg6CXa1BfqKIcd8AtcfMD8ueJ8qFrKAIaMrHzitah

