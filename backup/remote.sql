--
-- PostgreSQL database dump
--

-- Dumped from database version 10.3 (Debian 10.3-1.pgdg90+1)
-- Dumped by pg_dump version 14.15 (Homebrew)

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

--
-- Name: classExercises; Type: TABLE; Schema: public; Owner: phoenix_lib
--

CREATE TABLE public."classExercises" (
    id integer NOT NULL,
    "exerciseId" integer,
    index integer,
    "classMovementCategoryId" integer,
    notes text,
    duration integer DEFAULT 1,
    repetitions integer DEFAULT 1,
    "createdAt" timestamp with time zone NOT NULL,
    "updatedAt" timestamp with time zone NOT NULL
);


ALTER TABLE public."classExercises" OWNER TO phoenix_lib;

--
-- Name: classExercises_id_seq; Type: SEQUENCE; Schema: public; Owner: phoenix_lib
--

CREATE SEQUENCE public."classExercises_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."classExercises_id_seq" OWNER TO phoenix_lib;

--
-- Name: classExercises_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: phoenix_lib
--

ALTER SEQUENCE public."classExercises_id_seq" OWNED BY public."classExercises".id;


--
-- Name: classMovementCategories; Type: TABLE; Schema: public; Owner: phoenix_lib
--

CREATE TABLE public."classMovementCategories" (
    id integer NOT NULL,
    index integer,
    "classId" integer,
    "labelId" integer,
    "createdAt" timestamp with time zone NOT NULL,
    "updatedAt" timestamp with time zone NOT NULL
);


ALTER TABLE public."classMovementCategories" OWNER TO phoenix_lib;

--
-- Name: classMovementCategories_id_seq; Type: SEQUENCE; Schema: public; Owner: phoenix_lib
--

CREATE SEQUENCE public."classMovementCategories_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."classMovementCategories_id_seq" OWNER TO phoenix_lib;

--
-- Name: classMovementCategories_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: phoenix_lib
--

ALTER SEQUENCE public."classMovementCategories_id_seq" OWNED BY public."classMovementCategories".id;


--
-- Name: classTemplates; Type: TABLE; Schema: public; Owner: phoenix_lib
--

CREATE TABLE public."classTemplates" (
    id integer NOT NULL,
    "genreId" integer,
    "templateId" text,
    "createdAt" timestamp with time zone NOT NULL,
    "updatedAt" timestamp with time zone NOT NULL
);


ALTER TABLE public."classTemplates" OWNER TO phoenix_lib;

--
-- Name: classTemplates_id_seq; Type: SEQUENCE; Schema: public; Owner: phoenix_lib
--

CREATE SEQUENCE public."classTemplates_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."classTemplates_id_seq" OWNER TO phoenix_lib;

--
-- Name: classTemplates_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: phoenix_lib
--

ALTER SEQUENCE public."classTemplates_id_seq" OWNED BY public."classTemplates".id;


--
-- Name: classes; Type: TABLE; Schema: public; Owner: phoenix_lib
--

CREATE TABLE public.classes (
    id integer NOT NULL,
    name text,
    status integer,
    "genreId" integer,
    "createdBy" integer,
    notes text,
    "categorySummary" text,
    "durationSummary" integer,
    "createdAt" timestamp with time zone NOT NULL,
    "updatedAt" timestamp with time zone NOT NULL,
    revision integer DEFAULT 1
);


ALTER TABLE public.classes OWNER TO phoenix_lib;

--
-- Name: classes_id_seq; Type: SEQUENCE; Schema: public; Owner: phoenix_lib
--

CREATE SEQUENCE public.classes_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.classes_id_seq OWNER TO phoenix_lib;

--
-- Name: classes_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: phoenix_lib
--

ALTER SEQUENCE public.classes_id_seq OWNED BY public.classes.id;


--
-- Name: exercise_labels; Type: TABLE; Schema: public; Owner: phoenix_lib
--

CREATE TABLE public.exercise_labels (
    id integer NOT NULL,
    "exerciseId" integer,
    "genreId" integer,
    "movementId" integer,
    "createdAt" timestamp with time zone NOT NULL,
    "updatedAt" timestamp with time zone NOT NULL
);


ALTER TABLE public.exercise_labels OWNER TO phoenix_lib;

--
-- Name: exercise_labels_id_seq; Type: SEQUENCE; Schema: public; Owner: phoenix_lib
--

CREATE SEQUENCE public.exercise_labels_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.exercise_labels_id_seq OWNER TO phoenix_lib;

--
-- Name: exercise_labels_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: phoenix_lib
--

ALTER SEQUENCE public.exercise_labels_id_seq OWNED BY public.exercise_labels.id;


--
-- Name: exercises; Type: TABLE; Schema: public; Owner: phoenix_lib
--

CREATE TABLE public.exercises (
    id integer NOT NULL,
    name text,
    description text,
    springs text,
    photo text,
    video text,
    "createdAt" timestamp with time zone NOT NULL,
    "updatedAt" timestamp with time zone NOT NULL,
    revision integer DEFAULT 1
);


ALTER TABLE public.exercises OWNER TO phoenix_lib;

--
-- Name: exercises_id_seq; Type: SEQUENCE; Schema: public; Owner: phoenix_lib
--

CREATE SEQUENCE public.exercises_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.exercises_id_seq OWNER TO phoenix_lib;

--
-- Name: exercises_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: phoenix_lib
--

ALTER SEQUENCE public.exercises_id_seq OWNED BY public.exercises.id;


--
-- Name: labels; Type: TABLE; Schema: public; Owner: phoenix_lib
--

CREATE TABLE public.labels (
    id integer NOT NULL,
    type integer,
    name text,
    description text,
    color text,
    "createdAt" timestamp with time zone NOT NULL,
    "updatedAt" timestamp with time zone NOT NULL
);


ALTER TABLE public.labels OWNER TO phoenix_lib;

--
-- Name: labels_id_seq; Type: SEQUENCE; Schema: public; Owner: phoenix_lib
--

CREATE SEQUENCE public.labels_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.labels_id_seq OWNER TO phoenix_lib;

--
-- Name: labels_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: phoenix_lib
--

ALTER SEQUENCE public.labels_id_seq OWNED BY public.labels.id;


--
-- Name: ping; Type: TABLE; Schema: public; Owner: phoenix_lib
--

CREATE TABLE public.ping (
    id integer NOT NULL,
    "lastPing" timestamp with time zone
);


ALTER TABLE public.ping OWNER TO phoenix_lib;

--
-- Name: ping_id_seq; Type: SEQUENCE; Schema: public; Owner: phoenix_lib
--

CREATE SEQUENCE public.ping_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.ping_id_seq OWNER TO phoenix_lib;

--
-- Name: ping_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: phoenix_lib
--

ALTER SEQUENCE public.ping_id_seq OWNED BY public.ping.id;


--
-- Name: templates; Type: TABLE; Schema: public; Owner: phoenix_lib
--

CREATE TABLE public.templates (
    id integer NOT NULL,
    categories text,
    "createdAt" timestamp with time zone NOT NULL,
    "updatedAt" timestamp with time zone NOT NULL
);


ALTER TABLE public.templates OWNER TO phoenix_lib;

--
-- Name: templates_id_seq; Type: SEQUENCE; Schema: public; Owner: phoenix_lib
--

CREATE SEQUENCE public.templates_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.templates_id_seq OWNER TO phoenix_lib;

--
-- Name: templates_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: phoenix_lib
--

ALTER SEQUENCE public.templates_id_seq OWNED BY public.templates.id;


--
-- Name: users; Type: TABLE; Schema: public; Owner: phoenix_lib
--

CREATE TABLE public.users (
    id integer NOT NULL,
    "firstName" text,
    "lastName" text,
    email text,
    password text,
    "lastLogin" timestamp with time zone,
    "createdAt" timestamp with time zone NOT NULL,
    "updatedAt" timestamp with time zone NOT NULL,
    permissions text,
    logins integer DEFAULT 0
);


ALTER TABLE public.users OWNER TO phoenix_lib;

--
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: phoenix_lib
--

CREATE SEQUENCE public.users_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.users_id_seq OWNER TO phoenix_lib;

--
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: phoenix_lib
--

ALTER SEQUENCE public.users_id_seq OWNED BY public.users.id;


--
-- Name: classExercises id; Type: DEFAULT; Schema: public; Owner: phoenix_lib
--

ALTER TABLE ONLY public."classExercises" ALTER COLUMN id SET DEFAULT nextval('public."classExercises_id_seq"'::regclass);


--
-- Name: classMovementCategories id; Type: DEFAULT; Schema: public; Owner: phoenix_lib
--

ALTER TABLE ONLY public."classMovementCategories" ALTER COLUMN id SET DEFAULT nextval('public."classMovementCategories_id_seq"'::regclass);


--
-- Name: classTemplates id; Type: DEFAULT; Schema: public; Owner: phoenix_lib
--

ALTER TABLE ONLY public."classTemplates" ALTER COLUMN id SET DEFAULT nextval('public."classTemplates_id_seq"'::regclass);


--
-- Name: classes id; Type: DEFAULT; Schema: public; Owner: phoenix_lib
--

ALTER TABLE ONLY public.classes ALTER COLUMN id SET DEFAULT nextval('public.classes_id_seq'::regclass);


--
-- Name: exercise_labels id; Type: DEFAULT; Schema: public; Owner: phoenix_lib
--

ALTER TABLE ONLY public.exercise_labels ALTER COLUMN id SET DEFAULT nextval('public.exercise_labels_id_seq'::regclass);


--
-- Name: exercises id; Type: DEFAULT; Schema: public; Owner: phoenix_lib
--

ALTER TABLE ONLY public.exercises ALTER COLUMN id SET DEFAULT nextval('public.exercises_id_seq'::regclass);


--
-- Name: labels id; Type: DEFAULT; Schema: public; Owner: phoenix_lib
--

ALTER TABLE ONLY public.labels ALTER COLUMN id SET DEFAULT nextval('public.labels_id_seq'::regclass);


--
-- Name: ping id; Type: DEFAULT; Schema: public; Owner: phoenix_lib
--

ALTER TABLE ONLY public.ping ALTER COLUMN id SET DEFAULT nextval('public.ping_id_seq'::regclass);


--
-- Name: templates id; Type: DEFAULT; Schema: public; Owner: phoenix_lib
--

ALTER TABLE ONLY public.templates ALTER COLUMN id SET DEFAULT nextval('public.templates_id_seq'::regclass);


--
-- Name: users id; Type: DEFAULT; Schema: public; Owner: phoenix_lib
--

ALTER TABLE ONLY public.users ALTER COLUMN id SET DEFAULT nextval('public.users_id_seq'::regclass);


--
-- Data for Name: classExercises; Type: TABLE DATA; Schema: public; Owner: phoenix_lib
--

COPY public."classExercises" (id, "exerciseId", index, "classMovementCategoryId", notes, duration, repetitions, "createdAt", "updatedAt") FROM stdin;
3078	142	0	829	<span style="font-family: Roboto, Helvetica, Arial, sans-serif;">On Long box on the ground</span>	1	10	2018-07-09 03:09:32.252+00	2018-07-09 03:09:32.252+00
3083	50	5	829	<span style="font-family: Roboto, Helvetica, Arial, sans-serif;">On Long box on the ground</span>	1	10	2018-07-09 03:09:32.253+00	2018-07-09 03:09:32.253+00
3088	126	2	830		1	10	2018-07-09 03:09:32.268+00	2018-07-09 03:09:32.268+00
4893	5	0	1261		3	7	2018-10-09 23:54:25.072+00	2018-10-09 23:54:25.072+00
3093	206	7	830		1	10	2018-07-09 03:09:32.268+00	2018-07-09 03:09:32.268+00
3098	129	12	830		1	10	2018-07-09 03:09:32.269+00	2018-07-09 03:09:32.269+00
3103	166	4	831	<br>	2	10	2018-07-09 03:09:32.295+00	2018-07-09 03:09:32.295+00
3108	262	9	831		1	1	2018-07-09 03:09:32.296+00	2018-07-09 03:09:32.296+00
3113	188	0	832		2	10	2018-07-09 03:09:32.316+00	2018-07-09 03:09:32.316+00
2994	239	0	810		2	8	2018-07-09 02:56:53.009+00	2018-07-09 02:56:53.009+00
3000	340	6	810		1	8	2018-07-09 02:56:53.012+00	2018-07-09 02:56:53.012+00
3117	135	4	832		1	10	2018-07-09 03:09:32.316+00	2018-07-09 03:09:32.316+00
3122	156	0	835		1	10	2018-07-09 03:09:32.332+00	2018-07-09 03:09:32.332+00
3126	156	4	835		1	10	2018-07-09 03:09:32.333+00	2018-07-09 03:09:32.333+00
3131	187	1	837		1	10	2018-07-09 03:09:32.355+00	2018-07-09 03:09:32.355+00
3135	114	3	838		1	10	2018-07-09 03:09:32.355+00	2018-07-09 03:09:32.355+00
3005	24	0	812	Leave ball under sacrum	1	10	2018-07-09 02:56:53.045+00	2018-07-09 02:56:53.045+00
3010	354	5	812		1	10	2018-07-09 02:56:53.046+00	2018-07-09 02:56:53.046+00
3015	9	0	815	check back in see how it feels after both sides are done	1	5	2018-07-09 02:56:53.07+00	2018-07-09 02:56:53.07+00
3020	87	4	816		1	10	2018-07-09 02:56:53.07+00	2018-07-09 02:56:53.07+00
3025	88	9	816		1	1	2018-07-09 02:56:53.071+00	2018-07-09 02:56:53.071+00
3140	402	0	841	Add 10 Pulses and weights&nbsp;	1	10	2018-07-09 12:30:33.4+00	2018-07-09 12:30:33.4+00
3145	408	5	841	<span style="font-family: Roboto, Helvetica, Arial, sans-serif;">Add 10 Pulses and weights. Take ball or mat out from behind scapular.&nbsp;</span>	1	10	2018-07-09 12:30:33.401+00	2018-07-09 12:30:33.401+00
3150	428	4	842		1	10	2018-07-09 12:30:33.421+00	2018-07-09 12:30:33.421+00
3155	54	1	845	Notes...	1	10	2018-07-09 12:30:33.443+00	2018-07-09 12:30:33.443+00
3033	392	3	817		1	10	2018-07-09 02:56:53.096+00	2018-07-09 02:56:53.096+00
4896	27	0	1262		1	1	2018-10-09 23:54:25.101+00	2018-10-09 23:54:25.101+00
4903	289	1	1278		1	1	2019-04-14 02:15:13.937+00	2019-04-14 02:15:13.937+00
4906	143	1	1285		2	1	2022-04-26 01:34:59.568+00	2022-04-26 01:34:59.568+00
3160	374	6	845	Notes...	2	8	2018-07-09 12:30:33.444+00	2018-07-09 12:30:33.444+00
3165	89	1	846	Notes...	1	10	2018-07-09 12:30:33.468+00	2018-07-09 12:30:33.468+00
3169	284	0	849	Notes...	1	10	2018-07-09 12:30:33.468+00	2018-07-09 12:30:33.468+00
3174	257	1	848	Or reverse Plank	1	10	2018-07-09 12:30:33.469+00	2018-07-09 12:30:33.469+00
4755	198	2	1237		1	10	2018-09-02 06:06:47.634+00	2018-09-02 06:06:47.634+00
4760	151	1	1238		1	10	2018-09-02 06:06:47.67+00	2018-09-02 06:06:47.67+00
4765	32	1	1239	<span style="font-family: Roboto, Helvetica, Arial, sans-serif;">Ball between knees&nbsp;</span>	1	10	2018-09-02 06:06:47.694+00	2018-09-02 06:06:47.694+00
4770	438	0	1241	x 10 rest stretch back x 10 more then change springs for Footwork V	2	10	2018-09-02 06:06:47.711+00	2018-09-02 06:06:47.711+00
4775	206	5	1241	10 each side	1	10	2018-09-02 06:06:47.712+00	2018-09-02 06:06:47.712+00
4780	132	1	1240		1	10	2018-09-02 06:06:47.712+00	2018-09-02 06:06:47.712+00
4784	229	5	1240		1	3	2018-09-02 06:06:47.713+00	2018-09-02 06:06:47.713+00
4788	127	3	1244	<span style="font-family: Roboto, Helvetica, Arial, sans-serif;">BLUE in chest lift</span>	1	10	2018-09-02 06:06:47.746+00	2018-09-02 06:06:47.746+00
4792	397	0	1245	Replace Magic Circle with Ball	2	10	2018-09-02 06:06:47.747+00	2018-09-02 06:06:47.747+00
4796	59	1	1242	Ball between thighs gentle squeeze.	1	10	2018-09-02 06:06:47.748+00	2018-09-02 06:06:47.748+00
4803	400	2	1246		1	10	2018-09-02 06:06:59.259+00	2018-09-02 06:06:59.259+00
4807	244	6	1246		2	10	2018-09-02 06:06:59.26+00	2018-09-02 06:06:59.26+00
4811	18	3	1247		1	8	2018-09-02 06:06:59.26+00	2018-09-02 06:06:59.26+00
4817	360	9	1247	LEFT SIDE	1	10	2018-09-02 06:06:59.261+00	2018-09-02 06:06:59.261+00
4822	246	2	1248		1	10	2018-09-02 06:06:59.262+00	2018-09-02 06:06:59.262+00
4831	57	1	1250		1	10	2018-09-02 06:06:59.306+00	2018-09-02 06:06:59.306+00
4839	99	2	1251		1	10	2018-09-02 06:06:59.307+00	2018-09-02 06:06:59.307+00
4845	286	2	1253		1	10	2018-09-02 06:07:08.436+00	2018-09-02 06:07:08.436+00
4849	403	2	1254		1	10	2018-09-02 06:07:08.437+00	2018-09-02 06:07:08.437+00
4855	406	8	1254		1	10	2018-09-02 06:07:08.438+00	2018-09-02 06:07:08.438+00
4860	410	13	1254		1	10	2018-09-02 06:07:08.439+00	2018-09-02 06:07:08.439+00
4865	42	3	1255		1	1	2018-09-02 06:07:08.442+00	2018-09-02 06:07:08.442+00
4873	259	0	1257		1	10	2018-09-02 06:07:08.486+00	2018-09-02 06:07:08.486+00
4881	53	5	1258		1	10	2018-09-02 06:07:08.487+00	2018-09-02 06:07:08.487+00
4890	102	4	1259		1	5	2018-09-02 06:07:08.488+00	2018-09-02 06:07:08.488+00
3079	141	1	829	On the long box on the ground next to the bed	2	10	2018-07-09 03:09:32.253+00	2018-07-09 03:09:32.253+00
3084	49	6	829	<span style="font-family: Roboto, Helvetica, Arial, sans-serif;">On Long box on the ground</span>	1	10	2018-07-09 03:09:32.253+00	2018-07-09 03:09:32.253+00
3089	127	3	830		1	10	2018-07-09 03:09:32.268+00	2018-07-09 03:09:32.268+00
4894	9	1	1261		1	1	2018-10-09 23:54:25.073+00	2018-10-09 23:54:25.073+00
3094	151	8	830		1	6	2018-07-09 03:09:32.268+00	2018-07-09 03:09:32.268+00
3099	211	0	831		1	10	2018-07-09 03:09:32.295+00	2018-07-09 03:09:32.295+00
3104	262	5	831	<span style="font-family: Roboto, Helvetica, Arial, sans-serif;">Hold in Plank for Mountain climber</span>	1	1	2018-07-09 03:09:32.296+00	2018-07-09 03:09:32.296+00
3109	197	10	831		1	10	2018-07-09 03:09:32.296+00	2018-07-09 03:09:32.296+00
3114	135	1	832		1	10	2018-07-09 03:09:32.316+00	2018-07-09 03:09:32.316+00
3118	150	5	832	Stretch glute on last one	2	10	2018-07-09 03:09:32.317+00	2018-07-09 03:09:32.317+00
2995	240	1	810		2	8	2018-07-09 02:56:53.009+00	2018-07-09 02:56:53.009+00
2997	4	3	810	Settle into a neutral spine. Find this place during footwork&nbsp;	1	1	2018-07-09 02:56:53.011+00	2018-07-09 02:56:53.011+00
3002	265	0	811		2	10	2018-07-09 02:56:53.025+00	2018-07-09 02:56:53.025+00
3007	27	2	812	<span style="font-family: Roboto, Helvetica, Arial, sans-serif;">Leave ball under sacrum</span>	1	10	2018-07-09 02:56:53.045+00	2018-07-09 02:56:53.045+00
3123	157	1	835		1	10	2018-07-09 03:09:32.332+00	2018-07-09 03:09:32.332+00
3127	157	5	835		1	10	2018-07-09 03:09:32.333+00	2018-07-09 03:09:32.333+00
3132	115	0	838	30 seconds	1	2	2018-07-09 03:09:32.355+00	2018-07-09 03:09:32.355+00
3136	162	0	839		1	10	2018-07-09 03:09:32.355+00	2018-07-09 03:09:32.355+00
3141	403	1	841	<span style="font-family: Roboto, Helvetica, Arial, sans-serif;">Add 10 Pulses and weights&nbsp;</span>	1	10	2018-07-09 12:30:33.401+00	2018-07-09 12:30:33.401+00
3147	40	1	842		1	1	2018-07-09 12:30:33.421+00	2018-07-09 12:30:33.421+00
3152	91	0	844	Notes...	1	10	2018-07-09 12:30:33.443+00	2018-07-09 12:30:33.443+00
3157	54	3	845	Notes...	1	10	2018-07-09 12:30:33.444+00	2018-07-09 12:30:33.444+00
3162	26	1	843	Notes...	1	10	2018-07-09 12:30:33.444+00	2018-07-09 12:30:33.444+00
3171	104	0	847	demonstrate! If they can't do it on Box it can be done on the mat.&nbsp;	4	6	2018-07-09 12:30:33.469+00	2018-07-09 12:30:33.469+00
3012	353	1	814	<span style="font-family: Roboto, Helvetica, Arial, sans-serif;">second side&nbsp;</span>	1	10	2018-07-09 02:56:53.059+00	2018-07-09 02:56:53.059+00
3017	82	1	816		1	10	2018-07-09 02:56:53.07+00	2018-07-09 02:56:53.07+00
3022	85	6	816		1	10	2018-07-09 02:56:53.07+00	2018-07-09 02:56:53.07+00
3026	81	10	816		1	10	2018-07-09 02:56:53.071+00	2018-07-09 02:56:53.071+00
3030	255	0	817		1	10	2018-07-09 02:56:53.095+00	2018-07-09 02:56:53.095+00
3034	393	4	817		1	10	2018-07-09 02:56:53.096+00	2018-07-09 02:56:53.096+00
4897	249	1	1262		1	1	2018-10-09 23:54:25.101+00	2018-10-09 23:54:25.101+00
4904	424	2	1278		1	1	2019-04-14 02:15:13.937+00	2019-04-14 02:15:13.937+00
4905	5	0	1285		4	1	2022-04-26 01:34:59.568+00	2022-04-26 01:34:59.568+00
3038	393	8	817		1	1	2018-07-09 02:56:53.096+00	2018-07-09 02:56:53.096+00
4757	173	4	1237		2	10	2018-09-02 06:06:47.635+00	2018-09-02 06:06:47.635+00
4762	129	3	1238	With ball between knees	1	10	2018-09-02 06:06:47.67+00	2018-09-02 06:06:47.67+00
4767	33	3	1239	<span style="font-family: Roboto, Helvetica, Arial, sans-serif;">Ball between knees&nbsp;</span>	1	10	2018-09-02 06:06:47.694+00	2018-09-02 06:06:47.694+00
4772	127	2	1241	2+ RED&nbsp;	1	10	2018-09-02 06:06:47.711+00	2018-09-02 06:06:47.711+00
4777	213	7	1241	Drop Springs down to 1 BLUE&nbsp;	1	10	2018-09-02 06:06:47.712+00	2018-09-02 06:06:47.712+00
4782	134	3	1240		1	10	2018-09-02 06:06:47.712+00	2018-09-02 06:06:47.712+00
4790	176	5	1244	<span style="font-family: Roboto, Helvetica, Arial, sans-serif;">BLUE in chest lift</span>	1	10	2018-09-02 06:06:47.747+00	2018-09-02 06:06:47.747+00
4799	74	4	1242	10 each side	3	10	2018-09-02 06:06:47.748+00	2018-09-02 06:06:47.748+00
4801	285	0	1246		1	10	2018-09-02 06:06:59.257+00	2018-09-02 06:06:59.257+00
4805	8	4	1246	To point of control&nbsp;	1	10	2018-09-02 06:06:59.259+00	2018-09-02 06:06:59.259+00
4809	14	1	1247		1	8	2018-09-02 06:06:59.26+00	2018-09-02 06:06:59.26+00
4815	425	7	1247		1	10	2018-09-02 06:06:59.261+00	2018-09-02 06:06:59.261+00
4820	25	0	1248		2	10	2018-09-02 06:06:59.262+00	2018-09-02 06:06:59.262+00
4824	37	4	1248		1	10	2018-09-02 06:06:59.262+00	2018-09-02 06:06:59.262+00
4828	112	1	1249		1	10	2018-09-02 06:06:59.263+00	2018-09-02 06:06:59.263+00
4833	436	3	1250	RIGHT side 10 each	3	10	2018-09-02 06:06:59.306+00	2018-09-02 06:06:59.306+00
4837	97	0	1251		2	10	2018-09-02 06:06:59.307+00	2018-09-02 06:06:59.307+00
4841	435	0	1252		1	1	2018-09-02 06:06:59.327+00	2018-09-02 06:06:59.327+00
4844	400	1	1253		1	10	2018-09-02 06:07:08.436+00	2018-09-02 06:07:08.436+00
4848	20	1	1254	1/2 way pulses&nbsp;	1	10	2018-09-02 06:07:08.436+00	2018-09-02 06:07:08.436+00
4854	20	7	1254	<span style="font-family: Roboto, Helvetica, Arial, sans-serif;">1/2 way pulses&nbsp;</span>	1	10	2018-09-02 06:07:08.438+00	2018-09-02 06:07:08.438+00
4859	409	12	1254		1	10	2018-09-02 06:07:08.439+00	2018-09-02 06:07:08.439+00
4864	41	2	1255		1	1	2018-09-02 06:07:08.442+00	2018-09-02 06:07:08.442+00
4868	382	6	1255		1	1	2018-09-02 06:07:08.443+00	2018-09-02 06:07:08.443+00
4872	384	3	1256		1	10	2018-09-02 06:07:08.444+00	2018-09-02 06:07:08.444+00
4876	52	0	1258		1	10	2018-09-02 06:07:08.486+00	2018-09-02 06:07:08.486+00
4880	52	4	1258		1	10	2018-09-02 06:07:08.487+00	2018-09-02 06:07:08.487+00
4884	61	8	1258		1	10	2018-09-02 06:07:08.487+00	2018-09-02 06:07:08.487+00
4888	99	2	1259	<span style="font-family: Roboto, Helvetica, Arial, sans-serif;">Magic circle between ankles&nbsp;</span>	1	10	2018-09-02 06:07:08.488+00	2018-09-02 06:07:08.488+00
3080	46	2	829	On Long box on the ground	1	10	2018-07-09 03:09:32.253+00	2018-07-09 03:09:32.253+00
3087	128	1	830		1	10	2018-07-09 03:09:32.268+00	2018-07-09 03:09:32.268+00
4895	340	2	1261		1	1	2018-10-09 23:54:25.073+00	2018-10-09 23:54:25.073+00
4898	384	2	1262		1	1	2018-10-09 23:54:25.101+00	2018-10-09 23:54:25.101+00
3092	151	6	830		1	6	2018-07-09 03:09:32.268+00	2018-07-09 03:09:32.268+00
3097	206	11	830		1	1	2018-07-09 03:09:32.269+00	2018-07-09 03:09:32.269+00
3102	262	3	831	Hold in Plank for Plank to Row	1	1	2018-07-09 03:09:32.295+00	2018-07-09 03:09:32.295+00
3107	226	8	831	On last one walk hands back to feet to roll up.	1	10	2018-07-09 03:09:32.296+00	2018-07-09 03:09:32.296+00
3112	238	2	833		1	10	2018-07-09 03:09:32.316+00	2018-07-09 03:09:32.316+00
2996	242	2	810		1	8	2018-07-09 02:56:53.011+00	2018-07-09 02:56:53.011+00
2998	5	4	810	Use lower abs to pull pubic bone to belly button.	1	8	2018-07-09 02:56:53.011+00	2018-07-09 02:56:53.011+00
3003	266	1	811		2	10	2018-07-09 02:56:53.026+00	2018-07-09 02:56:53.026+00
3121	201	2	834		1	10	2018-07-09 03:09:32.332+00	2018-07-09 03:09:32.332+00
3130	186	0	837		1	10	2018-07-09 03:09:32.354+00	2018-07-09 03:09:32.354+00
3142	404	2	841	<span style="font-family: Roboto, Helvetica, Arial, sans-serif;">Add 10 Pulses and weights&nbsp;</span>	1	10	2018-07-09 12:30:33.401+00	2018-07-09 12:30:33.401+00
3146	31	0	842	Head down	1	10	2018-07-09 12:30:33.421+00	2018-07-09 12:30:33.421+00
3151	42	5	842		1	10	2018-07-09 12:30:33.422+00	2018-07-09 12:30:33.422+00
3156	52	2	845	Notes...	1	10	2018-07-09 12:30:33.443+00	2018-07-09 12:30:33.443+00
3161	24	0	843	Notes...	1	10	2018-07-09 12:30:33.444+00	2018-07-09 12:30:33.444+00
3166	90	2	846	10 each side	1	10	2018-07-09 12:30:33.468+00	2018-07-09 12:30:33.468+00
3008	352	3	812		1	10	2018-07-09 02:56:53.046+00	2018-07-09 02:56:53.046+00
3013	354	2	814	<span style="font-family: Roboto, Helvetica, Arial, sans-serif;">second side&nbsp;</span>	1	10	2018-07-09 02:56:53.059+00	2018-07-09 02:56:53.059+00
3018	85	2	816		1	10	2018-07-09 02:56:53.07+00	2018-07-09 02:56:53.07+00
3023	86	7	816		1	10	2018-07-09 02:56:53.071+00	2018-07-09 02:56:53.071+00
3027	82	11	816		1	10	2018-07-09 02:56:53.071+00	2018-07-09 02:56:53.071+00
3031	427	1	817		1	10	2018-07-09 02:56:53.095+00	2018-07-09 02:56:53.095+00
3035	394	5	817		1	10	2018-07-09 02:56:53.096+00	2018-07-09 02:56:53.096+00
3170	429	1	849	10 each side	3	10	2018-07-09 12:30:33.468+00	2018-07-09 12:30:33.468+00
3175	235	2	848		2	8	2018-07-09 12:30:33.469+00	2018-07-09 12:30:33.469+00
4907	400	2	1285		9	1	2022-04-26 01:34:59.569+00	2022-04-26 01:34:59.569+00
4758	174	5	1237		1	10	2018-09-02 06:06:47.635+00	2018-09-02 06:06:47.635+00
3039	394	9	817		1	1	2018-07-09 02:56:53.096+00	2018-07-09 02:56:53.096+00
4763	146	4	1238	Throwing ball into the air and catching it.&nbsp;	2	10	2018-09-02 06:06:47.67+00	2018-09-02 06:06:47.67+00
4768	211	4	1239	Ball under feet	2	10	2018-09-02 06:06:47.694+00	2018-09-02 06:06:47.694+00
4773	128	3	1241		1	10	2018-09-02 06:06:47.711+00	2018-09-02 06:06:47.711+00
4778	236	8	1241		1	10	2018-09-02 06:06:47.712+00	2018-09-02 06:06:47.712+00
4786	129	1	1244	BLUE Feet Parallel&nbsp;	1	10	2018-09-02 06:06:47.746+00	2018-09-02 06:06:47.746+00
4794	115	2	1245	30 seconds each side	1	2	2018-09-02 06:06:47.747+00	2018-09-02 06:06:47.747+00
4798	62	3	1242	<span style="font-family: Roboto, Helvetica, Arial, sans-serif;">Ball between thighs gentle squeeze.</span>	1	10	2018-09-02 06:06:47.748+00	2018-09-02 06:06:47.748+00
3081	48	3	829	<span style="font-family: Roboto, Helvetica, Arial, sans-serif;">On Long box on the ground</span>	1	10	2018-07-09 03:09:32.253+00	2018-07-09 03:09:32.253+00
3085	142	7	829	<span style="font-family: Roboto, Helvetica, Arial, sans-serif;">On Long box on the ground</span>	2	10	2018-07-09 03:09:32.253+00	2018-07-09 03:09:32.253+00
3090	151	4	830		1	6	2018-07-09 03:09:32.268+00	2018-07-09 03:09:32.268+00
3095	206	9	830		1	10	2018-07-09 03:09:32.269+00	2018-07-09 03:09:32.269+00
3100	214	1	831		1	1	2018-07-09 03:09:32.295+00	2018-07-09 03:09:32.295+00
3105	167	6	831	<span style="font-family: Roboto, Helvetica, Arial, sans-serif;">On last one walk hands back to feet to roll up. Roll down into plank.</span>	1	10	2018-07-09 03:09:32.296+00	2018-07-09 03:09:32.296+00
3110	160	0	833		1	10	2018-07-09 03:09:32.316+00	2018-07-09 03:09:32.316+00
2999	9	5	810		2	8	2018-07-09 02:56:53.011+00	2018-07-09 02:56:53.011+00
3004	267	2	811		2	10	2018-07-09 02:56:53.026+00	2018-07-09 02:56:53.026+00
3009	353	4	812		1	10	2018-07-09 02:56:53.046+00	2018-07-09 02:56:53.046+00
3014	9	0	813	Feel the difference in sides	1	5	2018-07-09 02:56:53.059+00	2018-07-09 02:56:53.059+00
3019	86	3	816		1	10	2018-07-09 02:56:53.07+00	2018-07-09 02:56:53.07+00
3024	87	8	816		1	10	2018-07-09 02:56:53.071+00	2018-07-09 02:56:53.071+00
3115	150	2	832	before switching sides glute stretch&nbsp;	1	10	2018-07-09 03:09:32.316+00	2018-07-09 03:09:32.316+00
3119	199	0	834		1	10	2018-07-09 03:09:32.332+00	2018-07-09 03:09:32.332+00
3124	154	2	835		1	10	2018-07-09 03:09:32.333+00	2018-07-09 03:09:32.333+00
3128	184	0	836		1	10	2018-07-09 03:09:32.333+00	2018-07-09 03:09:32.333+00
3133	114	1	838		1	10	2018-07-09 03:09:32.355+00	2018-07-09 03:09:32.355+00
3137	215	1	839		1	10	2018-07-09 03:09:32.356+00	2018-07-09 03:09:32.356+00
4899	129	0	1269		1	1	2019-03-08 02:19:00.756+00	2019-03-08 02:19:00.756+00
4908	92	0	1288		1	1	2022-04-26 01:34:59.624+00	2022-04-26 01:34:59.624+00
3028	336	0	818		1	10	2018-07-09 02:56:53.095+00	2018-07-09 02:56:53.095+00
3032	391	2	817		1	10	2018-07-09 02:56:53.096+00	2018-07-09 02:56:53.096+00
3036	391	6	817		1	1	2018-07-09 02:56:53.096+00	2018-07-09 02:56:53.096+00
4813	23	5	1247	10 each side	1	10	2018-09-02 06:06:59.26+00	2018-09-02 06:06:59.26+00
4814	21	6	1247		1	10	2018-09-02 06:06:59.261+00	2018-09-02 06:06:59.261+00
4819	361	11	1247	RIGHT SIDE&nbsp;	1	10	2018-09-02 06:06:59.261+00	2018-09-02 06:06:59.261+00
4823	248	3	1248		1	10	2018-09-02 06:06:59.262+00	2018-09-02 06:06:59.262+00
4827	105	0	1249		2	10	2018-09-02 06:06:59.263+00	2018-09-02 06:06:59.263+00
4832	58	2	1250		1	10	2018-09-02 06:06:59.306+00	2018-09-02 06:06:59.306+00
4836	62	6	1250		1	1	2018-09-02 06:06:59.307+00	2018-09-02 06:06:59.307+00
4840	434	3	1251		3	10	2018-09-02 06:06:59.309+00	2018-09-02 06:06:59.309+00
4843	399	0	1253		1	10	2018-09-02 06:07:08.435+00	2018-09-02 06:07:08.435+00
4847	402	0	1254		1	10	2018-09-02 06:07:08.436+00	2018-09-02 06:07:08.436+00
4853	405	6	1254		1	10	2018-09-02 06:07:08.437+00	2018-09-02 06:07:08.437+00
4858	408	11	1254		1	10	2018-09-02 06:07:08.438+00	2018-09-02 06:07:08.438+00
4863	39	1	1255		1	1	2018-09-02 06:07:08.442+00	2018-09-02 06:07:08.442+00
4867	35	5	1255		1	1	2018-09-02 06:07:08.443+00	2018-09-02 06:07:08.443+00
4871	292	2	1256		1	10	2018-09-02 06:07:08.444+00	2018-09-02 06:07:08.444+00
4875	261	2	1257		1	10	2018-09-02 06:07:08.486+00	2018-09-02 06:07:08.486+00
4879	56	3	1258		1	10	2018-09-02 06:07:08.487+00	2018-09-02 06:07:08.487+00
4883	341	7	1258		1	10	2018-09-02 06:07:08.487+00	2018-09-02 06:07:08.487+00
4887	98	1	1259	<span style="font-family: Roboto, Helvetica, Arial, sans-serif;">Magic circle between ankles&nbsp;</span>	1	10	2018-09-02 06:07:08.488+00	2018-09-02 06:07:08.488+00
4892	433	1	1260	10 each side&nbsp;	4	10	2018-09-02 06:07:08.52+00	2018-09-02 06:07:08.52+00
3082	47	4	829	<span style="font-family: Roboto, Helvetica, Arial, sans-serif;">On Long box on the ground</span>	1	10	2018-07-09 03:09:32.253+00	2018-07-09 03:09:32.253+00
3086	146	0	830		1	10	2018-07-09 03:09:32.267+00	2018-07-09 03:09:32.267+00
3091	206	5	830		1	10	2018-07-09 03:09:32.268+00	2018-07-09 03:09:32.268+00
3096	151	10	830		1	1	2018-07-09 03:09:32.269+00	2018-07-09 03:09:32.269+00
3101	197	2	831		3	10	2018-07-09 03:09:32.295+00	2018-07-09 03:09:32.295+00
3106	262	7	831	<span style="font-family: Roboto, Helvetica, Arial, sans-serif;">Hold in Plank for Leg Pull Front</span>	1	1	2018-07-09 03:09:32.296+00	2018-07-09 03:09:32.296+00
3001	10	7	810	8 each side	1	8	2018-07-09 02:56:53.012+00	2018-07-09 02:56:53.012+00
3006	26	1	812	<span style="font-family: Roboto, Helvetica, Arial, sans-serif;">Leave ball under sacrum</span>	1	10	2018-07-09 02:56:53.045+00	2018-07-09 02:56:53.045+00
3011	352	0	814	second side&nbsp;	1	10	2018-07-09 02:56:53.059+00	2018-07-09 02:56:53.059+00
3016	81	0	816		3	10	2018-07-09 02:56:53.07+00	2018-07-09 02:56:53.07+00
3021	88	5	816		1	1	2018-07-09 02:56:53.07+00	2018-07-09 02:56:53.07+00
3029	337	1	818		1	10	2018-07-09 02:56:53.095+00	2018-07-09 02:56:53.095+00
3111	131	1	833		1	10	2018-07-09 03:09:32.316+00	2018-07-09 03:09:32.316+00
3116	188	3	832		2	10	2018-07-09 03:09:32.316+00	2018-07-09 03:09:32.316+00
3120	200	1	834		1	10	2018-07-09 03:09:32.332+00	2018-07-09 03:09:32.332+00
3125	154	3	835	second side	1	10	2018-07-09 03:09:32.333+00	2018-07-09 03:09:32.333+00
3129	138	1	836		1	10	2018-07-09 03:09:32.333+00	2018-07-09 03:09:32.333+00
3134	115	2	838		1	1	2018-07-09 03:09:32.355+00	2018-07-09 03:09:32.355+00
3037	392	7	817		1	1	2018-07-09 02:56:53.096+00	2018-07-09 02:56:53.096+00
4900	152	1	1269		1	1	2019-03-08 02:19:00.756+00	2019-03-08 02:19:00.756+00
4909	109	1	1288		1	1	2022-04-26 01:34:59.625+00	2022-04-26 01:34:59.625+00
4851	404	4	1254		1	10	2018-09-02 06:07:08.437+00	2018-09-02 06:07:08.437+00
4852	20	5	1254	<span style="font-family: Roboto, Helvetica, Arial, sans-serif;">1/2 way pulses&nbsp;</span>	1	10	2018-09-02 06:07:08.437+00	2018-09-02 06:07:08.437+00
4857	407	10	1254		1	10	2018-09-02 06:07:08.438+00	2018-09-02 06:07:08.438+00
4862	37	0	1255		1	1	2018-09-02 06:07:08.442+00	2018-09-02 06:07:08.442+00
4866	33	4	1255		1	1	2018-09-02 06:07:08.443+00	2018-09-02 06:07:08.443+00
4870	249	1	1256		1	10	2018-09-02 06:07:08.444+00	2018-09-02 06:07:08.444+00
4874	260	1	1257		1	10	2018-09-02 06:07:08.486+00	2018-09-02 06:07:08.486+00
4878	55	2	1258		1	10	2018-09-02 06:07:08.487+00	2018-09-02 06:07:08.487+00
4882	55	6	1258		1	10	2018-09-02 06:07:08.487+00	2018-09-02 06:07:08.487+00
4886	97	0	1259	Magic circle between ankles&nbsp;	1	10	2018-09-02 06:07:08.488+00	2018-09-02 06:07:08.488+00
4891	431	0	1260		4	10	2018-09-02 06:07:08.52+00	2018-09-02 06:07:08.52+00
4753	216	0	1237		1	10	2018-09-02 06:06:47.634+00	2018-09-02 06:06:47.634+00
4756	143	3	1237	On Reformer. Ball between knees.	1	10	2018-09-02 06:06:47.634+00	2018-09-02 06:06:47.634+00
4761	160	2	1238		1	10	2018-09-02 06:06:47.67+00	2018-09-02 06:06:47.67+00
4766	35	2	1239	<span style="font-family: Roboto, Helvetica, Arial, sans-serif;">Ball between knees&nbsp;</span>	1	10	2018-09-02 06:06:47.694+00	2018-09-02 06:06:47.694+00
4771	126	1	1241		1	1	2018-09-02 06:06:47.711+00	2018-09-02 06:06:47.711+00
4776	131	6	1241	<span style="font-family: Roboto, Helvetica, Arial, sans-serif;">10 each side</span>	1	10	2018-09-02 06:06:47.712+00	2018-09-02 06:06:47.712+00
4781	133	2	1240		1	10	2018-09-02 06:06:47.712+00	2018-09-02 06:06:47.712+00
4785	438	0	1244	At end of 10 knees extend Roll down onto carriage for next series of jumps&nbsp;	1	10	2018-09-02 06:06:47.746+00	2018-09-02 06:06:47.746+00
4789	128	4	1244	<span style="font-family: Roboto, Helvetica, Arial, sans-serif;">BLUE in chest lift</span>	1	10	2018-09-02 06:06:47.746+00	2018-09-02 06:06:47.746+00
4793	398	1	1245	<span style="font-family: Roboto, Helvetica, Arial, sans-serif;">Replace Magic Circle with Ball</span>	1	10	2018-09-02 06:06:47.747+00	2018-09-02 06:06:47.747+00
4901	178	2	1269		1	1	2019-03-08 02:19:00.757+00	2019-03-08 02:19:00.757+00
4797	61	2	1242	<span style="font-family: Roboto, Helvetica, Arial, sans-serif;">Ball between thighs gentle squeeze.</span>	1	10	2018-09-02 06:06:47.748+00	2018-09-02 06:06:47.748+00
4804	141	3	1246		2	10	2018-09-02 06:06:59.259+00	2018-09-02 06:06:59.259+00
4808	16	0	1247		1	8	2018-09-02 06:06:59.26+00	2018-09-02 06:06:59.26+00
4812	245	4	1247	8 Each side	1	8	2018-09-02 06:06:59.26+00	2018-09-02 06:06:59.26+00
3138	9	0	840		1	8	2018-07-09 12:30:33.394+00	2018-07-09 12:30:33.394+00
4818	360	10	1247	RIGHT SIDE	2	10	2018-09-02 06:06:59.261+00	2018-09-02 06:06:59.261+00
4826	38	6	1248		1	10	2018-09-02 06:06:59.263+00	2018-09-02 06:06:59.263+00
4830	436	0	1250	LEFT SIDE 10 each	2	10	2018-09-02 06:06:59.306+00	2018-09-02 06:06:59.306+00
4835	61	5	1250		1	1	2018-09-02 06:06:59.307+00	2018-09-02 06:06:59.307+00
3143	405	3	841	<span style="font-family: Roboto, Helvetica, Arial, sans-serif;">Add 10 Pulses and weights&nbsp;</span>	1	10	2018-07-09 12:30:33.401+00	2018-07-09 12:30:33.401+00
3148	32	2	842	<span style="font-family: Roboto, Helvetica, Arial, sans-serif;">Head down</span>	1	10	2018-07-09 12:30:33.421+00	2018-07-09 12:30:33.421+00
3153	93	1	844	Notes...	1	10	2018-07-09 12:30:33.443+00	2018-07-09 12:30:33.443+00
3158	337	4	845	Notes...	2	10	2018-07-09 12:30:33.444+00	2018-07-09 12:30:33.444+00
3163	27	2	843	10 in each direction	1	10	2018-07-09 12:30:33.444+00	2018-07-09 12:30:33.444+00
3167	101	3	846	Regress no straps&nbsp;	1	10	2018-07-09 12:30:33.468+00	2018-07-09 12:30:33.468+00
3172	426	1	847	at end put box to side of carriage in prep for box pike	1	1	2018-07-09 12:30:33.469+00	2018-07-09 12:30:33.469+00
4754	166	1	1237		1	10	2018-09-02 06:06:47.634+00	2018-09-02 06:06:47.634+00
4759	175	0	1238		1	10	2018-09-02 06:06:47.669+00	2018-09-02 06:06:47.669+00
4764	31	0	1239	Ball between knees&nbsp;	2	10	2018-09-02 06:06:47.694+00	2018-09-02 06:06:47.694+00
4769	214	5	1239	<span style="font-family: Roboto, Helvetica, Arial, sans-serif;">Ball under feet</span>	2	10	2018-09-02 06:06:47.694+00	2018-09-02 06:06:47.694+00
4774	146	4	1241		1	10	2018-09-02 06:06:47.711+00	2018-09-02 06:06:47.711+00
4779	188	0	1240		2	10	2018-09-02 06:06:47.712+00	2018-09-02 06:06:47.712+00
4783	228	4	1240	Leave springs on blue.	2	10	2018-09-02 06:06:47.713+00	2018-09-02 06:06:47.713+00
4787	126	2	1244	<span style="font-family: Roboto, Helvetica, Arial, sans-serif;">BLUE in chest lift</span>	1	10	2018-09-02 06:06:47.746+00	2018-09-02 06:06:47.746+00
4791	147	6	1244	<span style="font-family: Roboto, Helvetica, Arial, sans-serif;">BLUE in chest lift Move through above combo 1 in each position&nbsp;</span>	1	10	2018-09-02 06:06:47.747+00	2018-09-02 06:06:47.747+00
4795	439	0	1242		1	10	2018-09-02 06:06:47.747+00	2018-09-02 06:06:47.747+00
4800	437	0	1243	repeat cycle twice each side.&nbsp;	3	2	2018-09-02 06:06:47.748+00	2018-09-02 06:06:47.748+00
4802	399	1	1246		1	10	2018-09-02 06:06:59.259+00	2018-09-02 06:06:59.259+00
4806	9	5	1246		1	10	2018-09-02 06:06:59.259+00	2018-09-02 06:06:59.259+00
4810	17	2	1247		1	8	2018-09-02 06:06:59.26+00	2018-09-02 06:06:59.26+00
4816	361	8	1247	LEFT SIDE	2	10	2018-09-02 06:06:59.261+00	2018-09-02 06:06:59.261+00
4821	247	1	1248		1	10	2018-09-02 06:06:59.262+00	2018-09-02 06:06:59.262+00
4825	39	5	1248		1	10	2018-09-02 06:06:59.263+00	2018-09-02 06:06:59.263+00
3139	143	1	840		1	8	2018-07-09 12:30:33.394+00	2018-07-09 12:30:33.394+00
4829	111	2	1249	<span style="font-family: Roboto, Helvetica, Arial, sans-serif;">Optional OR repeat double legs</span>	1	10	2018-09-02 06:06:59.263+00	2018-09-02 06:06:59.263+00
4902	9	0	1278		2	5	2019-04-14 02:15:13.936+00	2019-04-14 02:15:13.936+00
3144	407	4	841	<span style="font-family: Roboto, Helvetica, Arial, sans-serif;">Add 10 Pulses and weights&nbsp;</span>	1	10	2018-07-09 12:30:33.401+00	2018-07-09 12:30:33.401+00
3149	39	3	842		1	10	2018-07-09 12:30:33.421+00	2018-07-09 12:30:33.421+00
3154	52	0	845	Notes...	1	10	2018-07-09 12:30:33.443+00	2018-07-09 12:30:33.443+00
3159	373	5	845	Notes...	2	8	2018-07-09 12:30:33.444+00	2018-07-09 12:30:33.444+00
3164	251	0	846	Go around and put straps on feet for hamstring curl	1	10	2018-07-09 12:30:33.467+00	2018-07-09 12:30:33.467+00
3168	100	4	846	<span style="font-family: Roboto, Helvetica, Arial, sans-serif;">Regress no straps&nbsp;</span>...	1	10	2018-07-09 12:30:33.468+00	2018-07-09 12:30:33.468+00
3173	235	0	848		2	8	2018-07-09 12:30:33.469+00	2018-07-09 12:30:33.469+00
4834	59	4	1250		2	1	2018-09-02 06:06:59.306+00	2018-09-02 06:06:59.306+00
4838	98	1	1251		1	10	2018-09-02 06:06:59.307+00	2018-09-02 06:06:59.307+00
4842	258	1	1252	5 each side	4	5	2018-09-02 06:06:59.328+00	2018-09-02 06:06:59.328+00
4846	289	3	1253		1	10	2018-09-02 06:07:08.436+00	2018-09-02 06:07:08.436+00
4850	20	3	1254	<span style="font-family: Roboto, Helvetica, Arial, sans-serif;">1/2 way pulses&nbsp;</span>	1	10	2018-09-02 06:07:08.437+00	2018-09-02 06:07:08.437+00
4856	20	9	1254		1	10	2018-09-02 06:07:08.438+00	2018-09-02 06:07:08.438+00
4861	411	14	1254		1	10	2018-09-02 06:07:08.439+00	2018-09-02 06:07:08.439+00
4869	27	0	1256		1	10	2018-09-02 06:07:08.443+00	2018-09-02 06:07:08.443+00
4877	53	1	1258		1	1	2018-09-02 06:07:08.486+00	2018-09-02 06:07:08.486+00
4885	62	9	1258		1	10	2018-09-02 06:07:08.488+00	2018-09-02 06:07:08.488+00
4889	432	3	1259		1	1	2018-09-02 06:07:08.488+00	2018-09-02 06:07:08.488+00
\.


--
-- Data for Name: classMovementCategories; Type: TABLE DATA; Schema: public; Owner: phoenix_lib
--

COPY public."classMovementCategories" (id, index, "classId", "labelId", "createdAt", "updatedAt") FROM stdin;
1261	0	16	6	2018-10-09 23:54:25.044+00	2018-10-09 23:54:25.044+00
1262	1	16	7	2018-10-09 23:54:25.044+00	2018-10-09 23:54:25.044+00
1263	2	16	8	2018-10-09 23:54:25.044+00	2018-10-09 23:54:25.044+00
1264	3	16	9	2018-10-09 23:54:25.045+00	2018-10-09 23:54:25.045+00
1265	4	16	10	2018-10-09 23:54:25.045+00	2018-10-09 23:54:25.045+00
1266	5	16	11	2018-10-09 23:54:25.045+00	2018-10-09 23:54:25.045+00
1267	6	16	12	2018-10-09 23:54:25.045+00	2018-10-09 23:54:25.045+00
1268	0	17	6	2019-03-08 02:19:00.715+00	2019-03-08 02:19:00.715+00
1269	1	17	13	2019-03-08 02:19:00.716+00	2019-03-08 02:19:00.716+00
1270	2	17	14	2019-03-08 02:19:00.716+00	2019-03-08 02:19:00.716+00
1271	3	17	15	2019-03-08 02:19:00.716+00	2019-03-08 02:19:00.716+00
1272	4	17	13	2019-03-08 02:19:00.716+00	2019-03-08 02:19:00.716+00
1273	5	17	10	2019-03-08 02:19:00.716+00	2019-03-08 02:19:00.716+00
1274	6	17	9	2019-03-08 02:19:00.716+00	2019-03-08 02:19:00.716+00
1275	7	17	14	2019-03-08 02:19:00.716+00	2019-03-08 02:19:00.716+00
1276	8	17	13	2019-03-08 02:19:00.716+00	2019-03-08 02:19:00.716+00
1277	9	17	14	2019-03-08 02:19:00.717+00	2019-03-08 02:19:00.717+00
1278	0	18	6	2019-04-14 02:15:13.904+00	2019-04-14 02:15:13.904+00
1279	1	18	7	2019-04-14 02:15:13.904+00	2019-04-14 02:15:13.904+00
1280	2	18	8	2019-04-14 02:15:13.904+00	2019-04-14 02:15:13.904+00
1281	3	18	9	2019-04-14 02:15:13.905+00	2019-04-14 02:15:13.905+00
1282	4	18	10	2019-04-14 02:15:13.905+00	2019-04-14 02:15:13.905+00
1283	5	18	11	2019-04-14 02:15:13.905+00	2019-04-14 02:15:13.905+00
1284	6	18	12	2019-04-14 02:15:13.905+00	2019-04-14 02:15:13.905+00
1285	0	19	6	2022-04-26 01:34:59.533+00	2022-04-26 01:34:59.533+00
1286	1	19	7	2022-04-26 01:34:59.533+00	2022-04-26 01:34:59.533+00
1287	2	19	8	2022-04-26 01:34:59.533+00	2022-04-26 01:34:59.533+00
1288	3	19	9	2022-04-26 01:34:59.534+00	2022-04-26 01:34:59.534+00
1289	4	19	10	2022-04-26 01:34:59.534+00	2022-04-26 01:34:59.534+00
1290	5	19	11	2022-04-26 01:34:59.534+00	2022-04-26 01:34:59.534+00
1291	6	19	12	2022-04-26 01:34:59.534+00	2022-04-26 01:34:59.534+00
810	0	4	6	2018-07-09 02:56:52.973+00	2018-07-09 02:56:52.973+00
811	1	4	8	2018-07-09 02:56:52.973+00	2018-07-09 02:56:52.973+00
812	2	4	7	2018-07-09 02:56:52.973+00	2018-07-09 02:56:52.973+00
813	3	4	6	2018-07-09 02:56:52.973+00	2018-07-09 02:56:52.973+00
814	4	4	7	2018-07-09 02:56:52.973+00	2018-07-09 02:56:52.973+00
815	5	4	6	2018-07-09 02:56:52.973+00	2018-07-09 02:56:52.973+00
816	6	4	10	2018-07-09 02:56:52.973+00	2018-07-09 02:56:52.973+00
817	7	4	9	2018-07-09 02:56:52.975+00	2018-07-09 02:56:52.975+00
818	8	4	10	2018-07-09 02:56:52.975+00	2018-07-09 02:56:52.975+00
829	0	6	6	2018-07-09 03:09:32.221+00	2018-07-09 03:09:32.221+00
830	1	6	13	2018-07-09 03:09:32.221+00	2018-07-09 03:09:32.221+00
831	2	6	14	2018-07-09 03:09:32.221+00	2018-07-09 03:09:32.221+00
832	3	6	15	2018-07-09 03:09:32.221+00	2018-07-09 03:09:32.221+00
833	4	6	13	2018-07-09 03:09:32.222+00	2018-07-09 03:09:32.222+00
834	5	6	10	2018-07-09 03:09:32.222+00	2018-07-09 03:09:32.222+00
835	6	6	9	2018-07-09 03:09:32.222+00	2018-07-09 03:09:32.222+00
836	7	6	9	2018-07-09 03:09:32.222+00	2018-07-09 03:09:32.222+00
837	8	6	10	2018-07-09 03:09:32.222+00	2018-07-09 03:09:32.222+00
838	9	6	14	2018-07-09 03:09:32.222+00	2018-07-09 03:09:32.222+00
1237	0	15	6	2018-09-02 06:06:47.598+00	2018-09-02 06:06:47.598+00
839	10	6	14	2018-07-09 03:09:32.222+00	2018-07-09 03:09:32.222+00
840	0	2	6	2018-07-09 12:30:33.359+00	2018-07-09 12:30:33.359+00
841	1	2	7	2018-07-09 12:30:33.36+00	2018-07-09 12:30:33.36+00
842	2	2	8	2018-07-09 12:30:33.36+00	2018-07-09 12:30:33.36+00
843	3	2	7	2018-07-09 12:30:33.36+00	2018-07-09 12:30:33.36+00
844	4	2	9	2018-07-09 12:30:33.36+00	2018-07-09 12:30:33.36+00
845	5	2	10	2018-07-09 12:30:33.36+00	2018-07-09 12:30:33.36+00
846	6	2	11	2018-07-09 12:30:33.36+00	2018-07-09 12:30:33.36+00
847	7	2	12	2018-07-09 12:30:33.36+00	2018-07-09 12:30:33.36+00
848	8	2	9	2018-07-09 12:30:33.361+00	2018-07-09 12:30:33.361+00
849	9	2	12	2018-07-09 12:30:33.361+00	2018-07-09 12:30:33.361+00
1238	1	15	13	2018-09-02 06:06:47.598+00	2018-09-02 06:06:47.598+00
1239	2	15	14	2018-09-02 06:06:47.598+00	2018-09-02 06:06:47.598+00
1240	3	15	15	2018-09-02 06:06:47.598+00	2018-09-02 06:06:47.598+00
1241	4	15	13	2018-09-02 06:06:47.598+00	2018-09-02 06:06:47.598+00
1242	5	15	10	2018-09-02 06:06:47.599+00	2018-09-02 06:06:47.599+00
1243	6	15	9	2018-09-02 06:06:47.599+00	2018-09-02 06:06:47.599+00
1244	7	15	13	2018-09-02 06:06:47.599+00	2018-09-02 06:06:47.599+00
1245	8	15	14	2018-09-02 06:06:47.599+00	2018-09-02 06:06:47.599+00
1246	0	13	6	2018-09-02 06:06:59.229+00	2018-09-02 06:06:59.229+00
1247	1	13	7	2018-09-02 06:06:59.229+00	2018-09-02 06:06:59.229+00
1248	2	13	8	2018-09-02 06:06:59.229+00	2018-09-02 06:06:59.229+00
1249	3	13	9	2018-09-02 06:06:59.229+00	2018-09-02 06:06:59.229+00
1250	4	13	10	2018-09-02 06:06:59.229+00	2018-09-02 06:06:59.229+00
1251	5	13	11	2018-09-02 06:06:59.229+00	2018-09-02 06:06:59.229+00
1252	6	13	12	2018-09-02 06:06:59.23+00	2018-09-02 06:06:59.23+00
1253	0	12	6	2018-09-02 06:07:08.397+00	2018-09-02 06:07:08.397+00
1254	1	12	7	2018-09-02 06:07:08.397+00	2018-09-02 06:07:08.397+00
1255	2	12	8	2018-09-02 06:07:08.397+00	2018-09-02 06:07:08.397+00
1256	3	12	7	2018-09-02 06:07:08.397+00	2018-09-02 06:07:08.397+00
1257	4	12	9	2018-09-02 06:07:08.398+00	2018-09-02 06:07:08.398+00
1258	5	12	10	2018-09-02 06:07:08.398+00	2018-09-02 06:07:08.398+00
1259	6	12	11	2018-09-02 06:07:08.398+00	2018-09-02 06:07:08.398+00
1260	7	12	12	2018-09-02 06:07:08.398+00	2018-09-02 06:07:08.398+00
\.


--
-- Data for Name: classTemplates; Type: TABLE DATA; Schema: public; Owner: phoenix_lib
--

COPY public."classTemplates" (id, "genreId", "templateId", "createdAt", "updatedAt") FROM stdin;
1	1	2	2018-04-18 13:18:47.703+00	2018-04-18 13:18:47.703+00
2	2	1	2018-04-18 13:18:47.703+00	2018-04-18 13:18:47.703+00
3	3	2	2018-04-18 13:18:47.703+00	2018-04-18 13:18:47.703+00
4	4	2	2018-04-18 13:18:47.703+00	2018-04-18 13:18:47.703+00
5	5	2	2018-04-18 13:18:47.703+00	2018-04-18 13:18:47.703+00
\.


--
-- Data for Name: classes; Type: TABLE DATA; Schema: public; Owner: phoenix_lib
--

COPY public.classes (id, name, status, "genreId", "createdBy", notes, "categorySummary", "durationSummary", "createdAt", "updatedAt", revision) FROM stdin;
12	Pump Class 2	1	1	1	<p><br></p>	Warm Up,Supine Legs,Supine Arms & Abs,Weight Bearing Arms,Seated / Knealing,Prone,Full Body / Standing	56	2018-08-16 07:21:13.213+00	2018-09-02 06:07:08.383+00	18
16	New Connect Class	0	3	1	<p><br></p>	Warm Up,Supine Legs,Supine Arms & Abs,Weight Bearing Arms,Seated / Knealing,Prone,Full Body / Standing	8	2018-10-09 23:54:25.036+00	2018-10-09 23:54:25.036+00	1
17	New Jump Class	0	2	1	<p><br></p>	Warm Up,Jump,Core and HIIT,Jump Side Lying,Seated / Knealing,Weight Bearing Arms	3	2019-03-08 02:19:00.7+00	2019-03-08 02:19:00.7+00	1
18	New Pump Class	0	1	1	<p><br></p>	Warm Up,Supine Legs,Supine Arms & Abs,Weight Bearing Arms,Seated / Knealing,Prone,Full Body / Standing	4	2019-04-14 02:15:13.894+00	2019-04-14 02:15:13.894+00	1
19	New Technique Class eg. 	0	5	1	<p><br></p>	Warm Up,Supine Legs,Supine Arms & Abs,Weight Bearing Arms,Seated / Knealing,Prone,Full Body / Standing	17	2022-04-26 01:34:59.512+00	2022-04-26 01:34:59.512+00	1
4	Connect Class Liz 1	1	3	1	<p><br></p>	Warm Up,Supine Arms & Abs,Supine Legs,Seated / Knealing,Weight Bearing Arms	54	2018-06-11 07:48:13.899+00	2018-07-09 02:56:52.951+00	23
6	Jump Class Liz 1	1	2	1	<p>Total duration says 66 mn but in reality should &nbsp;be 50 min&nbsp;</p>	Warm Up,Jump,Core and HIIT,Jump Side Lying,Seated / Knealing,Weight Bearing Arms	68	2018-06-15 03:06:14.616+00	2018-07-09 03:09:32.198+00	26
2	Pump Class Liz 1	1	1	1	<p><br></p>	Warm Up,Supine Legs,Supine Arms & Abs,Weight Bearing Arms,Seated / Knealing,Prone,Full Body / Standing	48	2018-04-18 22:35:01.127+00	2018-07-09 12:30:33.341+00	27
15	Jump Class 2	1	2	1	<p><br></p>	Warm Up,Jump,Core and HIIT,Jump Side Lying,Seated / Knealing,Weight Bearing Arms	61	2018-08-24 02:26:47.619+00	2018-09-02 06:06:47.583+00	15
13	 Connect Class 2	1	3	1	<p><br></p>	Warm Up,Supine Legs,Supine Arms & Abs,Weight Bearing Arms,Seated / Knealing,Prone,Full Body / Standing	58	2018-08-21 11:08:50.03+00	2018-09-02 06:06:59.215+00	16
\.


--
-- Data for Name: exercise_labels; Type: TABLE DATA; Schema: public; Owner: phoenix_lib
--

COPY public.exercise_labels (id, "exerciseId", "genreId", "movementId", "createdAt", "updatedAt") FROM stdin;
1425	151	2	13	2018-04-04 11:50:43.516+00	2018-04-04 11:50:43.516+00
1165	18	1	7	2018-04-01 05:02:09.779+00	2018-04-01 05:02:09.779+00
1167	18	4	7	2018-04-01 05:02:09.779+00	2018-04-01 05:02:09.779+00
2874	358	1	8	2018-04-17 22:59:58.523+00	2018-04-17 22:59:58.523+00
2890	416	1	7	2018-04-18 01:08:44.476+00	2018-04-18 01:08:44.476+00
1616	188	2	15	2018-04-05 11:27:29.902+00	2018-04-05 11:27:29.902+00
2471	341	1	10	2018-04-10 12:59:06.267+00	2018-04-10 12:59:06.267+00
2909	79	1	10	2018-04-18 10:56:35.582+00	2018-04-18 10:56:35.582+00
1893	253	3	11	2018-04-08 13:09:11.586+00	2018-04-08 13:09:11.586+00
1894	253	5	11	2018-04-08 13:09:11.587+00	2018-04-08 13:09:11.587+00
1649	193	2	6	2018-04-05 12:05:00.363+00	2018-04-05 12:05:00.363+00
2911	79	3	10	2018-04-18 10:56:35.582+00	2018-04-18 10:56:35.582+00
2913	79	5	10	2018-04-18 10:56:35.582+00	2018-04-18 10:56:35.582+00
2927	348	1	6	2018-04-18 11:33:30.758+00	2018-04-18 11:33:30.758+00
1650	193	4	12	2018-04-05 12:05:00.364+00	2018-04-05 12:05:00.364+00
1651	193	5	12	2018-04-05 12:05:00.364+00	2018-04-05 12:05:00.364+00
2928	348	4	8	2018-04-18 11:33:30.758+00	2018-04-18 11:33:30.758+00
1926	108	1	9	2018-04-08 13:22:18.716+00	2018-04-08 13:22:18.716+00
1668	197	2	6	2018-04-05 13:00:57.096+00	2018-04-05 13:00:57.096+00
1669	197	2	14	2018-04-05 13:00:57.097+00	2018-04-05 13:00:57.097+00
846	69	3	10	2018-03-29 01:20:14+00	2018-03-29 01:20:14+00
2944	252	3	11	2018-04-18 11:43:54.604+00	2018-04-18 11:43:54.604+00
2968	372	5	10	2018-04-18 11:57:06.923+00	2018-04-18 11:57:06.923+00
2984	10	4	6	2018-04-19 01:10:59.632+00	2018-04-19 01:10:59.632+00
1929	108	5	9	2018-04-08 13:22:18.718+00	2018-04-08 13:22:18.718+00
1445	125	2	6	2018-04-04 11:58:31.994+00	2018-04-04 11:58:31.994+00
716	6	3	6	2018-03-27 16:54:17+00	2018-03-27 16:54:17+00
717	6	5	6	2018-03-27 16:54:17+00	2018-03-27 16:54:17+00
847	69	4	10	2018-03-29 01:20:14+00	2018-03-29 01:20:14+00
848	69	5	10	2018-03-29 01:20:14+00	2018-03-29 01:20:14+00
722	4	3	6	2018-03-27 16:55:38+00	2018-03-27 16:55:38+00
849	68	1	10	2018-03-29 01:21:04+00	2018-03-29 01:21:04+00
850	68	3	10	2018-03-29 01:21:04+00	2018-03-29 01:21:04+00
851	68	4	10	2018-03-29 01:21:04+00	2018-03-29 01:21:04+00
852	68	5	10	2018-03-29 01:21:04+00	2018-03-29 01:21:04+00
2594	361	3	7	2018-04-13 04:02:18.178+00	2018-04-13 04:02:18.178+00
744	55	1	10	2018-03-27 17:11:10+00	2018-03-27 17:11:10+00
745	55	2	10	2018-03-27 17:11:10+00	2018-03-27 17:11:10+00
746	55	3	10	2018-03-27 17:11:10+00	2018-03-27 17:11:10+00
747	55	4	10	2018-03-27 17:11:10+00	2018-03-27 17:11:10+00
1462	50	5	8	2018-04-04 12:06:03.332+00	2018-04-04 12:06:03.332+00
1465	49	2	14	2018-04-04 12:06:13.557+00	2018-04-04 12:06:13.557+00
2613	364	1	9	2018-04-13 05:47:46.486+00	2018-04-13 05:47:46.486+00
2614	364	4	9	2018-04-13 05:47:46.486+00	2018-04-13 05:47:46.486+00
2623	367	1	9	2018-04-13 06:01:55.41+00	2018-04-13 06:01:55.41+00
1470	48	2	14	2018-04-04 12:06:30.405+00	2018-04-04 12:06:30.405+00
1475	47	2	14	2018-04-04 12:06:43.8+00	2018-04-04 12:06:43.8+00
1954	259	1	9	2018-04-08 13:44:12.206+00	2018-04-08 13:44:12.206+00
1178	15	3	7	2018-04-01 05:02:38.643+00	2018-04-01 05:02:38.643+00
759	58	3	10	2018-03-27 17:38:33+00	2018-03-27 17:38:33+00
760	58	5	10	2018-03-27 17:38:33+00	2018-03-27 17:38:33+00
1181	14	1	7	2018-04-01 05:02:48.468+00	2018-04-01 05:02:48.468+00
1183	14	4	7	2018-04-01 05:02:48.468+00	2018-04-01 05:02:48.468+00
1184	14	5	7	2018-04-01 05:02:48.468+00	2018-04-01 05:02:48.468+00
2625	368	1	10	2018-04-13 06:10:05.388+00	2018-04-13 06:10:05.388+00
890	70	3	10	2018-03-29 01:37:38+00	2018-03-29 01:37:38+00
817	66	3	10	2018-03-27 18:30:16+00	2018-03-27 18:30:16+00
818	66	4	10	2018-03-27 18:30:16+00	2018-03-27 18:30:16+00
819	66	5	10	2018-03-27 18:30:16+00	2018-03-27 18:30:16+00
891	70	5	9	2018-03-29 01:37:38+00	2018-03-29 01:37:38+00
892	70	5	10	2018-03-29 01:37:38+00	2018-03-29 01:37:38+00
896	72	3	10	2018-03-29 01:37:51+00	2018-03-29 01:37:51+00
897	72	5	9	2018-03-29 01:37:51+00	2018-03-29 01:37:51+00
898	72	5	10	2018-03-29 01:37:51+00	2018-03-29 01:37:51+00
899	71	3	10	2018-03-29 01:37:57+00	2018-03-29 01:37:57+00
900	71	5	9	2018-03-29 01:37:57+00	2018-03-29 01:37:57+00
901	71	5	10	2018-03-29 01:37:57+00	2018-03-29 01:37:57+00
902	73	3	10	2018-03-29 01:38:04+00	2018-03-29 01:38:04+00
903	73	5	9	2018-03-29 01:38:04+00	2018-03-29 01:38:04+00
1955	259	3	9	2018-04-08 13:44:12.206+00	2018-04-08 13:44:12.206+00
904	73	5	10	2018-03-29 01:38:04+00	2018-03-29 01:38:04+00
1956	259	4	9	2018-04-08 13:44:12.206+00	2018-04-08 13:44:12.206+00
2626	368	4	10	2018-04-13 06:10:05.388+00	2018-04-13 06:10:05.388+00
2629	370	1	9	2018-04-13 06:17:22.164+00	2018-04-13 06:17:22.164+00
2630	370	4	9	2018-04-13 06:17:22.165+00	2018-04-13 06:17:22.165+00
557	44	4	7	2018-03-27 16:39:12+00	2018-03-27 16:39:12+00
558	43	4	7	2018-03-27 16:39:30+00	2018-03-27 16:39:30+00
561	41	1	8	2018-03-27 16:40:26+00	2018-03-27 16:40:26+00
562	41	4	8	2018-03-27 16:40:26+00	2018-03-27 16:40:26+00
565	39	1	8	2018-03-27 16:41:18+00	2018-03-27 16:41:18+00
566	39	3	8	2018-03-27 16:41:18+00	2018-03-27 16:41:18+00
567	39	4	8	2018-03-27 16:41:18+00	2018-03-27 16:41:18+00
568	38	1	8	2018-03-27 16:41:45+00	2018-03-27 16:41:45+00
569	38	3	8	2018-03-27 16:41:45+00	2018-03-27 16:41:45+00
570	38	4	8	2018-03-27 16:41:45+00	2018-03-27 16:41:45+00
2637	371	1	10	2018-04-13 12:08:35.464+00	2018-04-13 12:08:35.464+00
2007	272	3	10	2018-04-09 00:55:54.386+00	2018-04-09 00:55:54.386+00
2638	371	5	10	2018-04-13 12:08:35.464+00	2018-04-13 12:08:35.464+00
2641	366	1	9	2018-04-13 12:18:35.66+00	2018-04-13 12:18:35.66+00
2030	29	1	7	2018-04-09 01:06:20.668+00	2018-04-09 01:06:20.668+00
2032	29	4	7	2018-04-09 01:06:20.668+00	2018-04-09 01:06:20.668+00
2035	28	4	7	2018-04-09 01:06:34.391+00	2018-04-09 01:06:34.391+00
2642	366	4	9	2018-04-13 12:18:35.66+00	2018-04-13 12:18:35.66+00
2038	27	3	7	2018-04-09 01:06:49.98+00	2018-04-09 01:06:49.98+00
1715	131	2	13	2018-04-06 13:55:23.978+00	2018-04-06 13:55:23.978+00
1721	209	2	14	2018-04-07 01:38:06.438+00	2018-04-07 01:38:06.438+00
1727	176	2	13	2018-04-07 02:07:20.642+00	2018-04-07 02:07:20.642+00
1736	215	2	14	2018-04-07 08:44:47.53+00	2018-04-07 08:44:47.53+00
2040	27	5	7	2018-04-09 01:06:49.98+00	2018-04-09 01:06:49.98+00
2657	373	5	10	2018-04-13 13:34:05.584+00	2018-04-13 13:34:05.584+00
2659	374	1	9	2018-04-13 13:35:25.399+00	2018-04-13 13:35:25.399+00
2660	374	1	10	2018-04-13 13:35:25.4+00	2018-04-13 13:35:25.4+00
1750	158	2	13	2018-04-07 12:18:52.538+00	2018-04-07 12:18:52.538+00
1552	167	2	14	2018-04-04 12:53:45.395+00	2018-04-04 12:53:45.395+00
1572	173	2	13	2018-04-04 13:42:47.463+00	2018-04-04 13:42:47.463+00
1578	146	2	13	2018-04-05 05:58:52.393+00	2018-04-05 05:58:52.393+00
1763	228	2	15	2018-04-07 13:30:16.865+00	2018-04-07 13:30:16.865+00
1769	232	2	14	2018-04-07 13:53:16.666+00	2018-04-07 13:53:16.666+00
1595	181	2	14	2018-04-05 10:49:13.49+00	2018-04-05 10:49:13.49+00
1794	237	2	13	2018-04-07 14:15:06.415+00	2018-04-07 14:15:06.415+00
2073	280	3	12	2018-04-09 01:47:02.727+00	2018-04-09 01:47:02.727+00
2074	280	4	12	2018-04-09 01:47:02.727+00	2018-04-09 01:47:02.727+00
2084	285	3	6	2018-04-09 02:27:10.02+00	2018-04-09 02:27:10.02+00
2085	285	5	6	2018-04-09 02:27:10.02+00	2018-04-09 02:27:10.02+00
2118	35	5	8	2018-04-09 02:40:04.262+00	2018-04-09 02:40:04.262+00
2127	291	1	8	2018-04-09 02:49:14.91+00	2018-04-09 02:49:14.91+00
2128	291	3	8	2018-04-09 02:49:14.91+00	2018-04-09 02:49:14.91+00
2875	358	4	8	2018-04-17 22:59:58.523+00	2018-04-17 22:59:58.523+00
2143	296	3	10	2018-04-09 03:22:30.464+00	2018-04-09 03:22:30.464+00
2144	296	4	10	2018-04-09 03:22:30.464+00	2018-04-09 03:22:30.464+00
1446	115	2	14	2018-04-04 11:59:02.169+00	2018-04-04 11:59:02.169+00
2473	341	5	10	2018-04-10 12:59:06.268+00	2018-04-10 12:59:06.268+00
1447	115	3	12	2018-04-04 11:59:02.17+00	2018-04-04 11:59:02.17+00
1448	115	5	12	2018-04-04 11:59:02.17+00	2018-04-04 11:59:02.17+00
1463	49	1	6	2018-04-04 12:06:13.557+00	2018-04-04 12:06:13.557+00
1467	49	5	8	2018-04-04 12:06:13.557+00	2018-04-04 12:06:13.557+00
1468	48	1	6	2018-04-04 12:06:30.404+00	2018-04-04 12:06:30.404+00
1472	48	5	8	2018-04-04 12:06:30.406+00	2018-04-04 12:06:30.406+00
2891	417	1	7	2018-04-18 01:14:15.97+00	2018-04-18 01:14:15.97+00
2910	79	2	10	2018-04-18 10:56:35.582+00	2018-04-18 10:56:35.582+00
1617	150	2	15	2018-04-05 11:28:04.449+00	2018-04-05 11:28:04.449+00
2154	80	5	10	2018-04-09 03:27:15.866+00	2018-04-09 03:27:15.866+00
1494	33	2	14	2018-04-04 12:08:17.909+00	2018-04-04 12:08:17.909+00
1497	33	5	8	2018-04-04 12:08:17.909+00	2018-04-04 12:08:17.909+00
2160	299	3	10	2018-04-09 03:33:32.73+00	2018-04-09 03:33:32.73+00
2169	74	3	10	2018-04-09 03:41:43.908+00	2018-04-09 03:41:43.908+00
2912	79	4	10	2018-04-18 10:56:35.582+00	2018-04-18 10:56:35.582+00
718	5	3	6	2018-03-27 16:54:51+00	2018-03-27 16:54:51+00
719	5	5	6	2018-03-27 16:54:52+00	2018-03-27 16:54:52+00
723	4	5	6	2018-03-27 16:55:38+00	2018-03-27 16:55:38+00
2929	40	1	8	2018-04-18 11:35:23.994+00	2018-04-18 11:35:23.994+00
2930	40	4	8	2018-04-18 11:35:23.994+00	2018-04-18 11:35:23.994+00
2946	342	1	11	2018-04-18 11:44:41.196+00	2018-04-18 11:44:41.196+00
2947	342	3	11	2018-04-18 11:44:41.196+00	2018-04-18 11:44:41.196+00
748	55	5	10	2018-03-27 17:11:10+00	2018-03-27 17:11:10+00
1166	18	3	7	2018-04-01 05:02:09.779+00	2018-04-01 05:02:09.779+00
1168	18	5	7	2018-04-01 05:02:09.779+00	2018-04-01 05:02:09.779+00
1500	32	3	8	2018-04-04 12:08:37.583+00	2018-04-04 12:08:37.583+00
2192	303	5	12	2018-04-09 03:59:21.142+00	2018-04-09 03:59:21.142+00
1910	105	1	9	2018-04-08 13:15:26.456+00	2018-04-08 13:15:26.456+00
1911	105	3	9	2018-04-08 13:15:26.456+00	2018-04-08 13:15:26.456+00
1912	105	4	9	2018-04-08 13:15:26.456+00	2018-04-08 13:15:26.456+00
2948	342	5	11	2018-04-18 11:44:41.196+00	2018-04-18 11:44:41.196+00
2969	62	1	10	2018-04-18 12:01:01.923+00	2018-04-18 12:01:01.923+00
1913	105	5	6	2018-04-08 13:15:26.456+00	2018-04-08 13:15:26.456+00
1914	105	5	9	2018-04-08 13:15:26.456+00	2018-04-08 13:15:26.456+00
1546	163	2	14	2018-04-04 12:26:23.623+00	2018-04-04 12:26:23.623+00
1927	108	3	9	2018-04-08 13:22:18.716+00	2018-04-08 13:22:18.716+00
2970	62	2	10	2018-04-18 12:01:01.923+00	2018-04-18 12:01:01.923+00
1563	170	2	6	2018-04-04 13:21:55.275+00	2018-04-04 13:21:55.275+00
1626	149	2	15	2018-04-05 11:30:58.071+00	2018-04-05 11:30:58.071+00
1957	260	1	9	2018-04-08 13:46:07.293+00	2018-04-08 13:46:07.293+00
1958	260	3	9	2018-04-08 13:46:07.293+00	2018-04-08 13:46:07.293+00
1652	194	2	6	2018-04-05 12:07:49.388+00	2018-04-05 12:07:49.388+00
1653	194	4	12	2018-04-05 12:07:49.388+00	2018-04-05 12:07:49.388+00
1564	170	3	6	2018-04-04 13:21:55.275+00	2018-04-04 13:21:55.275+00
1573	174	2	6	2018-04-04 13:44:12.167+00	2018-04-04 13:44:12.167+00
556	45	4	7	2018-03-27 16:38:50+00	2018-03-27 16:38:50+00
559	42	1	8	2018-03-27 16:40:03+00	2018-03-27 16:40:03+00
560	42	4	8	2018-03-27 16:40:03+00	2018-03-27 16:40:03+00
2971	62	3	10	2018-04-18 12:01:01.923+00	2018-04-18 12:01:01.923+00
2972	62	4	10	2018-04-18 12:01:01.923+00	2018-04-18 12:01:01.923+00
1654	194	5	12	2018-04-05 12:07:49.389+00	2018-04-05 12:07:49.389+00
1959	260	4	9	2018-04-08 13:46:07.293+00	2018-04-08 13:46:07.293+00
1670	198	2	6	2018-04-05 13:05:07.061+00	2018-04-05 13:05:07.061+00
1671	198	2	14	2018-04-05 13:05:07.061+00	2018-04-05 13:05:07.061+00
1574	174	2	13	2018-04-04 13:44:12.167+00	2018-04-04 13:44:12.167+00
2201	306	3	12	2018-04-09 11:30:13.359+00	2018-04-09 11:30:13.359+00
2537	36	1	6	2018-04-13 02:03:11.105+00	2018-04-13 02:03:11.105+00
2210	309	3	6	2018-04-09 13:58:49.897+00	2018-04-09 13:58:49.897+00
2538	36	4	8	2018-04-13 02:03:11.105+00	2018-04-13 02:03:11.105+00
1579	147	2	13	2018-04-05 05:59:09.101+00	2018-04-05 05:59:09.101+00
1710	204	2	13	2018-04-06 13:42:00.88+00	2018-04-06 13:42:00.88+00
1716	206	2	13	2018-04-06 13:58:30.497+00	2018-04-06 13:58:30.497+00
1722	210	2	14	2018-04-07 01:43:11.869+00	2018-04-07 01:43:11.869+00
2551	353	1	7	2018-04-13 02:16:06.724+00	2018-04-13 02:16:06.724+00
1737	216	2	6	2018-04-07 09:02:18.31+00	2018-04-07 09:02:18.31+00
1999	52	1	10	2018-04-09 00:28:43.161+00	2018-04-09 00:28:43.161+00
2000	52	2	10	2018-04-09 00:28:43.161+00	2018-04-09 00:28:43.161+00
656	23	1	7	2018-03-27 16:47:37+00	2018-03-27 16:47:37+00
657	23	3	7	2018-03-27 16:47:37+00	2018-03-27 16:47:37+00
658	23	4	7	2018-03-27 16:47:37+00	2018-03-27 16:47:37+00
659	23	5	7	2018-03-27 16:47:37+00	2018-03-27 16:47:37+00
1222	113	1	9	2018-04-01 10:58:08.019+00	2018-04-01 10:58:08.019+00
1223	113	3	9	2018-04-01 10:58:08.019+00	2018-04-01 10:58:08.019+00
1224	113	4	9	2018-04-01 10:58:08.019+00	2018-04-01 10:58:08.019+00
2001	52	3	10	2018-04-09 00:28:43.161+00	2018-04-09 00:28:43.161+00
2002	52	4	10	2018-04-09 00:28:43.161+00	2018-04-09 00:28:43.161+00
2553	353	4	7	2018-04-13 02:16:06.724+00	2018-04-13 02:16:06.724+00
1738	216	2	14	2018-04-07 09:02:18.31+00	2018-04-07 09:02:18.31+00
1757	223	2	14	2018-04-07 13:11:04.983+00	2018-04-07 13:11:04.983+00
1770	233	2	14	2018-04-07 13:58:09.732+00	2018-04-07 13:58:09.732+00
2587	360	1	7	2018-04-13 03:59:22.976+00	2018-04-13 03:59:22.976+00
3016	51	5	10	2018-04-19 09:00:38.442+00	2018-04-19 09:00:38.442+00
3025	76	3	10	2018-04-19 09:36:18.285+00	2018-04-19 09:36:18.285+00
1827	244	3	6	2018-04-08 11:49:14.101+00	2018-04-08 11:49:14.101+00
1828	244	5	6	2018-04-08 11:49:14.102+00	2018-04-08 11:49:14.102+00
1233	116	1	12	2018-04-01 11:13:20.884+00	2018-04-01 11:13:20.884+00
808	65	3	10	2018-03-27 18:27:32+00	2018-03-27 18:27:32+00
809	65	4	10	2018-03-27 18:27:32+00	2018-03-27 18:27:32+00
810	65	5	10	2018-03-27 18:27:32+00	2018-03-27 18:27:32+00
3042	266	3	8	2018-06-15 00:35:20.772+00	2018-06-15 00:35:20.772+00
920	75	1	10	2018-03-29 01:48:01+00	2018-03-29 01:48:01+00
921	75	3	10	2018-03-29 01:48:01+00	2018-03-29 01:48:01+00
922	75	4	10	2018-03-29 01:48:01+00	2018-03-29 01:48:01+00
1234	116	3	12	2018-04-01 11:13:20.884+00	2018-04-01 11:13:20.884+00
1235	116	4	12	2018-04-01 11:13:20.885+00	2018-04-01 11:13:20.885+00
1236	116	5	12	2018-04-01 11:13:20.885+00	2018-04-01 11:13:20.885+00
3043	266	4	8	2018-06-15 00:35:20.772+00	2018-06-15 00:35:20.772+00
3049	409	1	7	2018-06-15 00:45:24.387+00	2018-06-15 00:45:24.387+00
1856	54	5	10	2018-04-08 12:13:09.679+00	2018-04-08 12:13:09.679+00
1251	119	3	12	2018-04-01 11:45:04.918+00	2018-04-01 11:45:04.918+00
1257	121	3	12	2018-04-01 11:49:28.74+00	2018-04-01 11:49:28.74+00
3050	409	3	7	2018-06-15 00:45:24.388+00	2018-06-15 00:45:24.388+00
3051	409	4	7	2018-06-15 00:45:24.388+00	2018-06-15 00:45:24.388+00
1258	121	4	12	2018-04-01 11:49:28.74+00	2018-04-01 11:49:28.74+00
1259	121	5	12	2018-04-01 11:49:28.74+00	2018-04-01 11:49:28.74+00
1267	124	3	12	2018-04-01 11:55:35.563+00	2018-04-01 11:55:35.563+00
1268	124	4	12	2018-04-01 11:55:35.563+00	2018-04-01 11:55:35.563+00
3071	31	2	14	2018-06-29 02:24:36.527+00	2018-06-29 02:24:36.527+00
3080	251	1	11	2018-06-29 04:02:07.753+00	2018-06-29 04:02:07.753+00
3081	251	3	11	2018-06-29 04:02:07.753+00	2018-06-29 04:02:07.753+00
3082	251	4	11	2018-06-29 04:02:07.754+00	2018-06-29 04:02:07.754+00
3083	251	5	11	2018-06-29 04:02:07.754+00	2018-06-29 04:02:07.754+00
3091	428	1	8	2018-06-29 04:23:45.126+00	2018-06-29 04:23:45.126+00
3095	428	5	8	2018-06-29 04:23:45.127+00	2018-06-29 04:23:45.127+00
3097	391	3	9	2018-07-01 11:13:20.755+00	2018-07-01 11:13:20.755+00
1354	77	3	10	2018-04-03 06:18:49.098+00	2018-04-03 06:18:49.098+00
1355	77	4	10	2018-04-03 06:18:49.098+00	2018-04-03 06:18:49.098+00
1356	77	5	10	2018-04-03 06:18:49.098+00	2018-04-03 06:18:49.098+00
1375	57	1	10	2018-04-03 10:47:01.374+00	2018-04-03 10:47:01.374+00
1376	57	2	10	2018-04-03 10:47:01.374+00	2018-04-03 10:47:01.374+00
1377	57	3	10	2018-04-03 10:47:01.374+00	2018-04-03 10:47:01.374+00
1378	57	4	10	2018-04-03 10:47:01.374+00	2018-04-03 10:47:01.374+00
1387	56	1	10	2018-04-03 10:58:48.858+00	2018-04-03 10:58:48.858+00
1412	162	1	12	2018-04-04 11:47:58.189+00	2018-04-04 11:47:58.189+00
1413	162	2	14	2018-04-04 11:47:58.19+00	2018-04-04 11:47:58.19+00
1428	142	1	6	2018-04-04 11:51:31.606+00	2018-04-04 11:51:31.606+00
1429	142	2	6	2018-04-04 11:51:31.606+00	2018-04-04 11:51:31.606+00
940	78	3	10	2018-03-30 11:25:53.355+00	2018-03-30 11:25:53.355+00
941	78	4	10	2018-03-30 11:25:53.355+00	2018-03-30 11:25:53.355+00
942	78	5	10	2018-03-30 11:25:53.355+00	2018-03-30 11:25:53.355+00
1430	142	2	14	2018-04-04 11:51:31.607+00	2018-04-04 11:51:31.607+00
1612	187	2	10	2018-04-05 11:05:54.83+00	2018-04-05 11:05:54.83+00
2145	200	2	10	2018-04-09 03:24:09.26+00	2018-04-09 03:24:09.26+00
2892	418	1	9	2018-04-18 01:21:03.934+00	2018-04-18 01:21:03.934+00
2893	418	4	9	2018-04-18 01:21:03.934+00	2018-04-18 01:21:03.934+00
2505	347	1	6	2018-04-13 01:43:12.247+00	2018-04-13 01:43:12.247+00
2506	347	5	12	2018-04-13 01:43:12.247+00	2018-04-13 01:43:12.247+00
2508	346	5	12	2018-04-13 01:43:21.07+00	2018-04-13 01:43:21.07+00
1627	19	2	15	2018-04-05 11:34:38.258+00	2018-04-05 11:34:38.258+00
1928	108	4	9	2018-04-08 13:22:18.717+00	2018-04-08 13:22:18.717+00
1655	155	2	9	2018-04-05 12:23:53.604+00	2018-04-05 12:23:53.604+00
1661	138	2	9	2018-04-05 12:51:28.794+00	2018-04-05 12:51:28.794+00
2509	345	1	6	2018-04-13 01:43:27.704+00	2018-04-13 01:43:27.704+00
1960	261	1	9	2018-04-08 13:47:55.789+00	2018-04-08 13:47:55.789+00
1961	261	3	9	2018-04-08 13:47:55.789+00	2018-04-08 13:47:55.789+00
2511	344	1	6	2018-04-13 01:43:36.826+00	2018-04-13 01:43:36.826+00
2512	344	5	12	2018-04-13 01:43:36.826+00	2018-04-13 01:43:36.826+00
2914	420	1	10	2018-04-18 11:03:28.241+00	2018-04-18 11:03:28.241+00
1962	261	4	9	2018-04-08 13:47:55.789+00	2018-04-08 13:47:55.789+00
1717	207	2	15	2018-04-06 14:03:43.041+00	2018-04-06 14:03:43.041+00
1723	195	2	9	2018-04-07 01:44:27.172+00	2018-04-07 01:44:27.172+00
2915	420	4	10	2018-04-18 11:03:28.241+00	2018-04-18 11:03:28.241+00
2931	61	1	10	2018-04-18 11:36:30.04+00	2018-04-18 11:36:30.04+00
1752	22	2	13	2018-04-07 12:19:37.144+00	2018-04-07 12:19:37.144+00
1758	224	2	14	2018-04-07 13:15:15.5+00	2018-04-07 13:15:15.5+00
1765	229	2	15	2018-04-07 13:33:14.648+00	2018-04-07 13:33:14.648+00
1989	268	3	8	2018-04-09 00:22:12.631+00	2018-04-09 00:22:12.631+00
1990	268	4	8	2018-04-09 00:22:12.631+00	2018-04-09 00:22:12.631+00
2003	52	5	10	2018-04-09 00:28:43.161+00	2018-04-09 00:28:43.161+00
2932	61	2	10	2018-04-18 11:36:30.04+00	2018-04-18 11:36:30.04+00
2933	61	3	10	2018-04-18 11:36:30.04+00	2018-04-18 11:36:30.04+00
2552	353	3	7	2018-04-13 02:16:06.724+00	2018-04-13 02:16:06.724+00
1788	235	1	9	2018-04-07 14:09:13.043+00	2018-04-07 14:09:13.043+00
1789	235	2	9	2018-04-07 14:09:13.043+00	2018-04-07 14:09:13.043+00
1790	235	4	12	2018-04-07 14:09:13.043+00	2018-04-07 14:09:13.043+00
2565	355	1	9	2018-04-13 03:41:34.958+00	2018-04-13 03:41:34.958+00
2566	355	4	9	2018-04-13 03:41:34.958+00	2018-04-13 03:41:34.958+00
1800	238	2	13	2018-04-07 14:16:28.671+00	2018-04-07 14:16:28.671+00
2588	360	3	7	2018-04-13 03:59:22.976+00	2018-04-13 03:59:22.976+00
2031	29	3	7	2018-04-09 01:06:20.668+00	2018-04-09 01:06:20.668+00
2033	29	5	7	2018-04-09 01:06:20.668+00	2018-04-09 01:06:20.668+00
2589	360	4	7	2018-04-13 03:59:22.976+00	2018-04-13 03:59:22.976+00
2934	61	4	10	2018-04-18 11:36:30.04+00	2018-04-18 11:36:30.04+00
2949	382	1	8	2018-04-18 11:48:23.032+00	2018-04-18 11:48:23.032+00
2950	382	5	12	2018-04-18 11:48:23.032+00	2018-04-18 11:48:23.032+00
2064	276	3	9	2018-04-09 01:26:32.244+00	2018-04-09 01:26:32.244+00
2075	281	3	12	2018-04-09 02:02:13.955+00	2018-04-09 02:02:13.955+00
2076	281	4	12	2018-04-09 02:02:13.955+00	2018-04-09 02:02:13.955+00
2973	62	5	10	2018-04-18 12:01:01.923+00	2018-04-18 12:01:01.923+00
2990	21	1	7	2018-04-19 08:32:43.982+00	2018-04-19 08:32:43.982+00
2607	363	1	9	2018-04-13 05:46:09.319+00	2018-04-13 05:46:09.319+00
2609	362	1	9	2018-04-13 05:46:16.287+00	2018-04-13 05:46:16.287+00
2610	362	4	9	2018-04-13 05:46:16.287+00	2018-04-13 05:46:16.287+00
2615	365	1	9	2018-04-13 05:52:29.752+00	2018-04-13 05:52:29.752+00
1011	89	1	11	2018-03-31 07:00:05.839+00	2018-03-31 07:00:05.839+00
1012	89	3	11	2018-03-31 07:00:05.839+00	2018-03-31 07:00:05.839+00
1013	89	4	11	2018-03-31 07:00:05.84+00	2018-03-31 07:00:05.84+00
2616	365	4	9	2018-04-13 05:52:29.753+00	2018-04-13 05:52:29.753+00
2991	21	3	7	2018-04-19 08:32:43.983+00	2018-04-19 08:32:43.983+00
2992	21	4	7	2018-04-19 08:32:43.983+00	2018-04-19 08:32:43.983+00
1017	90	1	11	2018-03-31 10:25:07.512+00	2018-03-31 10:25:07.512+00
1018	90	3	11	2018-03-31 10:25:07.512+00	2018-03-31 10:25:07.512+00
1019	90	4	11	2018-03-31 10:25:07.512+00	2018-03-31 10:25:07.512+00
2993	21	5	7	2018-04-19 08:32:43.983+00	2018-04-19 08:32:43.983+00
3017	153	1	10	2018-04-19 09:06:14.825+00	2018-04-19 09:06:14.825+00
3018	153	2	10	2018-04-19 09:06:14.825+00	2018-04-19 09:06:14.825+00
3019	153	4	10	2018-04-19 09:06:14.826+00	2018-04-19 09:06:14.826+00
1034	92	1	9	2018-03-31 10:40:42.145+00	2018-03-31 10:40:42.145+00
1035	92	2	9	2018-03-31 10:40:42.145+00	2018-03-31 10:40:42.145+00
1036	92	3	9	2018-03-31 10:40:42.146+00	2018-03-31 10:40:42.146+00
1037	92	5	9	2018-03-31 10:40:42.146+00	2018-03-31 10:40:42.146+00
1053	94	1	9	2018-03-31 10:43:29.741+00	2018-03-31 10:43:29.741+00
1054	94	3	9	2018-03-31 10:43:29.741+00	2018-03-31 10:43:29.741+00
1055	94	4	9	2018-03-31 10:43:29.741+00	2018-03-31 10:43:29.741+00
1056	95	3	12	2018-03-31 10:46:38.502+00	2018-03-31 10:46:38.502+00
1057	95	4	12	2018-03-31 10:46:38.502+00	2018-03-31 10:46:38.502+00
1058	96	5	11	2018-03-31 10:51:03.748+00	2018-03-31 10:51:03.748+00
1059	97	1	11	2018-03-31 10:55:50.083+00	2018-03-31 10:55:50.083+00
1060	97	3	11	2018-03-31 10:55:50.083+00	2018-03-31 10:55:50.083+00
1061	97	4	11	2018-03-31 10:55:50.083+00	2018-03-31 10:55:50.083+00
1062	97	5	11	2018-03-31 10:55:50.084+00	2018-03-31 10:55:50.084+00
1067	98	1	11	2018-03-31 11:01:17.241+00	2018-03-31 11:01:17.241+00
1068	98	3	11	2018-03-31 11:01:17.241+00	2018-03-31 11:01:17.241+00
1069	98	4	11	2018-03-31 11:01:17.241+00	2018-03-31 11:01:17.241+00
1070	98	5	11	2018-03-31 11:01:17.241+00	2018-03-31 11:01:17.241+00
1071	99	1	11	2018-03-31 11:02:39.043+00	2018-03-31 11:02:39.043+00
1072	99	3	11	2018-03-31 11:02:39.043+00	2018-03-31 11:02:39.043+00
1073	99	4	11	2018-03-31 11:02:39.043+00	2018-03-31 11:02:39.043+00
1074	99	5	11	2018-03-31 11:02:39.043+00	2018-03-31 11:02:39.043+00
1098	107	3	9	2018-03-31 13:12:50.953+00	2018-03-31 13:12:50.953+00
1099	107	4	9	2018-03-31 13:12:50.954+00	2018-03-31 13:12:50.954+00
1100	107	5	9	2018-03-31 13:12:50.954+00	2018-03-31 13:12:50.954+00
1109	88	1	10	2018-04-01 04:56:32.77+00	2018-04-01 04:56:32.77+00
1110	88	3	10	2018-04-01 04:56:32.771+00	2018-04-01 04:56:32.771+00
1111	88	4	10	2018-04-01 04:56:32.771+00	2018-04-01 04:56:32.771+00
1112	88	5	10	2018-04-01 04:56:32.771+00	2018-04-01 04:56:32.771+00
1113	87	1	10	2018-04-01 04:57:00.261+00	2018-04-01 04:57:00.261+00
1114	87	3	10	2018-04-01 04:57:00.261+00	2018-04-01 04:57:00.261+00
1115	87	4	10	2018-04-01 04:57:00.261+00	2018-04-01 04:57:00.261+00
1116	86	1	10	2018-04-01 04:57:09.596+00	2018-04-01 04:57:09.596+00
1117	86	3	10	2018-04-01 04:57:09.596+00	2018-04-01 04:57:09.596+00
1118	86	4	10	2018-04-01 04:57:09.596+00	2018-04-01 04:57:09.596+00
1119	86	5	10	2018-04-01 04:57:09.597+00	2018-04-01 04:57:09.597+00
1120	85	1	10	2018-04-01 04:59:43.876+00	2018-04-01 04:59:43.876+00
1121	85	3	10	2018-04-01 04:59:43.876+00	2018-04-01 04:59:43.876+00
1122	85	4	10	2018-04-01 04:59:43.877+00	2018-04-01 04:59:43.877+00
1123	85	5	10	2018-04-01 04:59:43.877+00	2018-04-01 04:59:43.877+00
1124	84	3	10	2018-04-01 04:59:51.666+00	2018-04-01 04:59:51.666+00
1125	84	4	10	2018-04-01 04:59:51.666+00	2018-04-01 04:59:51.666+00
1126	83	1	10	2018-04-01 04:59:59.779+00	2018-04-01 04:59:59.779+00
1127	83	3	10	2018-04-01 04:59:59.78+00	2018-04-01 04:59:59.78+00
1128	83	4	10	2018-04-01 04:59:59.78+00	2018-04-01 04:59:59.78+00
1129	82	1	10	2018-04-01 05:00:08.824+00	2018-04-01 05:00:08.824+00
1130	82	3	10	2018-04-01 05:00:08.824+00	2018-04-01 05:00:08.824+00
1131	82	4	10	2018-04-01 05:00:08.824+00	2018-04-01 05:00:08.824+00
1132	82	5	10	2018-04-01 05:00:08.824+00	2018-04-01 05:00:08.824+00
1133	81	1	10	2018-04-01 05:00:16.927+00	2018-04-01 05:00:16.927+00
1134	81	3	10	2018-04-01 05:00:16.927+00	2018-04-01 05:00:16.927+00
1135	81	4	10	2018-04-01 05:00:16.927+00	2018-04-01 05:00:16.927+00
1136	81	5	10	2018-04-01 05:00:16.927+00	2018-04-01 05:00:16.927+00
1162	20	1	7	2018-04-01 05:01:48.995+00	2018-04-01 05:01:48.995+00
2878	359	1	8	2018-04-18 00:58:14.596+00	2018-04-18 00:58:14.596+00
2879	359	3	8	2018-04-18 00:58:14.596+00	2018-04-18 00:58:14.596+00
1177	15	1	7	2018-04-01 05:02:38.643+00	2018-04-01 05:02:38.643+00
1180	15	5	7	2018-04-01 05:02:38.644+00	2018-04-01 05:02:38.644+00
1182	14	3	7	2018-04-01 05:02:48.468+00	2018-04-01 05:02:48.468+00
1431	140	1	6	2018-04-04 11:51:57.352+00	2018-04-04 11:51:57.352+00
1432	140	2	6	2018-04-04 11:51:57.352+00	2018-04-04 11:51:57.352+00
2894	419	1	9	2018-04-18 01:42:23.682+00	2018-04-18 01:42:23.682+00
2146	200	3	10	2018-04-09 03:24:09.26+00	2018-04-09 03:24:09.26+00
2147	200	4	10	2018-04-09 03:24:09.26+00	2018-04-09 03:24:09.26+00
1433	140	2	14	2018-04-04 11:51:57.352+00	2018-04-04 11:51:57.352+00
1441	129	2	13	2018-04-04 11:54:09.428+00	2018-04-04 11:54:09.428+00
1442	128	2	13	2018-04-04 11:54:21.096+00	2018-04-04 11:54:21.096+00
2155	298	3	10	2018-04-09 03:30:10.134+00	2018-04-09 03:30:10.134+00
1613	186	2	10	2018-04-05 11:06:14.49+00	2018-04-05 11:06:14.49+00
1619	135	2	15	2018-04-05 11:28:34.454+00	2018-04-05 11:28:34.454+00
1620	134	2	15	2018-04-05 11:28:45.662+00	2018-04-05 11:28:45.662+00
1237	117	1	12	2018-04-01 11:18:30.859+00	2018-04-01 11:18:30.859+00
1238	117	3	12	2018-04-01 11:18:30.859+00	2018-04-01 11:18:30.859+00
1239	117	4	12	2018-04-01 11:18:30.859+00	2018-04-01 11:18:30.859+00
1240	117	5	12	2018-04-01 11:18:30.859+00	2018-04-01 11:18:30.859+00
1250	119	1	12	2018-04-01 11:45:04.918+00	2018-04-01 11:45:04.918+00
1253	119	5	12	2018-04-01 11:45:04.919+00	2018-04-01 11:45:04.919+00
1260	122	3	12	2018-04-01 11:52:19.256+00	2018-04-01 11:52:19.256+00
1261	122	4	12	2018-04-01 11:52:19.256+00	2018-04-01 11:52:19.256+00
1262	122	5	12	2018-04-01 11:52:19.256+00	2018-04-01 11:52:19.256+00
1629	189	2	15	2018-04-05 11:43:18.059+00	2018-04-05 11:43:18.059+00
1466	49	4	6	2018-04-04 12:06:13.557+00	2018-04-04 12:06:13.557+00
2161	300	3	11	2018-04-09 03:41:03.316+00	2018-04-09 03:41:03.316+00
1471	48	4	6	2018-04-04 12:06:30.405+00	2018-04-04 12:06:30.405+00
1900	93	1	9	2018-04-08 13:12:51.47+00	2018-04-08 13:12:51.47+00
1901	93	2	9	2018-04-08 13:12:51.47+00	2018-04-08 13:12:51.47+00
1902	93	3	9	2018-04-08 13:12:51.47+00	2018-04-08 13:12:51.47+00
1645	191	5	12	2018-04-05 12:03:14.714+00	2018-04-05 12:03:14.714+00
1646	192	2	6	2018-04-05 12:03:23.119+00	2018-04-05 12:03:23.119+00
1648	192	5	12	2018-04-05 12:03:23.119+00	2018-04-05 12:03:23.119+00
1903	93	4	9	2018-04-08 13:12:51.47+00	2018-04-08 13:12:51.47+00
1917	256	3	9	2018-04-08 13:20:42.382+00	2018-04-08 13:20:42.382+00
1473	47	1	6	2018-04-04 12:06:43.8+00	2018-04-04 12:06:43.8+00
2895	419	3	9	2018-04-18 01:42:23.683+00	2018-04-18 01:42:23.683+00
2896	419	4	9	2018-04-18 01:42:23.683+00	2018-04-18 01:42:23.683+00
2916	421	1	10	2018-04-18 11:08:26.944+00	2018-04-18 11:08:26.944+00
2917	421	4	10	2018-04-18 11:08:26.944+00	2018-04-18 11:08:26.944+00
1930	110	1	9	2018-04-08 13:23:28.186+00	2018-04-08 13:23:28.186+00
1361	145	2	7	2018-04-03 06:36:32.703+00	2018-04-03 06:36:32.703+00
1931	110	3	9	2018-04-08 13:23:28.186+00	2018-04-08 13:23:28.186+00
1932	110	4	9	2018-04-08 13:23:28.186+00	2018-04-08 13:23:28.186+00
2162	300	5	11	2018-04-09 03:41:03.316+00	2018-04-09 03:41:03.316+00
1379	57	5	10	2018-04-03 10:47:01.374+00	2018-04-03 10:47:01.374+00
1388	56	2	10	2018-04-03 10:58:48.858+00	2018-04-03 10:58:48.858+00
2170	74	4	10	2018-04-09 03:41:43.908+00	2018-04-09 03:41:43.908+00
1476	47	4	6	2018-04-04 12:06:43.8+00	2018-04-04 12:06:43.8+00
2935	61	5	10	2018-04-18 11:36:30.041+00	2018-04-18 11:36:30.041+00
2951	284	1	12	2018-04-18 11:50:01.726+00	2018-04-18 11:50:01.726+00
1414	161	2	6	2018-04-04 11:48:34.098+00	2018-04-04 11:48:34.098+00
1415	161	2	14	2018-04-04 11:48:34.098+00	2018-04-04 11:48:34.098+00
1416	161	3	6	2018-04-04 11:48:34.098+00	2018-04-04 11:48:34.098+00
1417	161	3	8	2018-04-04 11:48:34.098+00	2018-04-04 11:48:34.098+00
1424	152	2	13	2018-04-04 11:50:29.479+00	2018-04-04 11:50:29.479+00
2952	284	3	12	2018-04-18 11:50:01.726+00	2018-04-18 11:50:01.726+00
2193	304	3	10	2018-04-09 04:02:29.166+00	2018-04-09 04:02:29.166+00
2953	284	4	12	2018-04-18 11:50:01.726+00	2018-04-18 11:50:01.726+00
1495	33	3	8	2018-04-04 12:08:17.909+00	2018-04-04 12:08:17.909+00
1498	32	1	8	2018-04-04 12:08:37.582+00	2018-04-04 12:08:37.582+00
1501	32	4	8	2018-04-04 12:08:37.583+00	2018-04-04 12:08:37.583+00
2194	304	4	10	2018-04-09 04:02:29.166+00	2018-04-09 04:02:29.166+00
2198	305	3	12	2018-04-09 10:46:05.201+00	2018-04-09 10:46:05.201+00
2202	307	3	12	2018-04-09 11:32:25.013+00	2018-04-09 11:32:25.013+00
1946	109	1	9	2018-04-08 13:27:12.952+00	2018-04-08 13:27:12.952+00
2206	264	3	6	2018-04-09 11:45:29.715+00	2018-04-09 11:45:29.715+00
2211	309	4	6	2018-04-09 13:58:49.897+00	2018-04-09 13:58:49.897+00
2974	255	3	9	2018-04-18 12:02:27.472+00	2018-04-18 12:02:27.472+00
2220	310	3	10	2018-04-10 04:04:56.593+00	2018-04-10 04:04:56.593+00
2221	311	3	6	2018-04-10 04:05:03.591+00	2018-04-10 04:05:03.591+00
1947	109	3	9	2018-04-08 13:27:12.952+00	2018-04-08 13:27:12.952+00
1948	109	4	9	2018-04-08 13:27:12.952+00	2018-04-08 13:27:12.952+00
1949	109	5	9	2018-04-08 13:27:12.953+00	2018-04-08 13:27:12.953+00
2975	255	5	9	2018-04-18 12:02:27.472+00	2018-04-18 12:02:27.472+00
1544	7	5	6	2018-04-04 12:10:33.333+00	2018-04-04 12:10:33.333+00
1547	164	2	14	2018-04-04 12:27:48.924+00	2018-04-04 12:27:48.924+00
1555	169	2	6	2018-04-04 13:14:26.831+00	2018-04-04 13:14:26.831+00
1556	169	3	6	2018-04-04 13:14:26.831+00	2018-04-04 13:14:26.831+00
1565	171	2	6	2018-04-04 13:25:29.305+00	2018-04-04 13:25:29.305+00
1566	171	3	6	2018-04-04 13:25:29.305+00	2018-04-04 13:25:29.305+00
2994	425	1	7	2018-04-19 08:35:39.881+00	2018-04-19 08:35:39.881+00
2995	425	3	7	2018-04-19 08:35:39.881+00	2018-04-19 08:35:39.881+00
2996	425	4	7	2018-04-19 08:35:39.881+00	2018-04-19 08:35:39.881+00
1586	178	2	13	2018-04-05 06:15:30.227+00	2018-04-05 06:15:30.227+00
2997	425	5	7	2018-04-19 08:35:39.881+00	2018-04-19 08:35:39.881+00
3007	53	1	10	2018-04-19 09:00:29.825+00	2018-04-19 09:00:29.825+00
3008	53	2	10	2018-04-19 09:00:29.825+00	2018-04-19 09:00:29.825+00
1712	203	2	13	2018-04-06 13:50:12.352+00	2018-04-06 13:50:12.352+00
3009	53	3	10	2018-04-19 09:00:29.829+00	2018-04-19 09:00:29.829+00
1991	269	3	8	2018-04-09 00:24:19.385+00	2018-04-09 00:24:19.385+00
3010	53	4	10	2018-04-19 09:00:29.83+00	2018-04-19 09:00:29.83+00
1740	217	2	14	2018-04-07 11:27:10.726+00	2018-04-07 11:27:10.726+00
1992	269	4	8	2018-04-09 00:24:19.386+00	2018-04-09 00:24:19.386+00
1753	220	2	13	2018-04-07 12:21:07.629+00	2018-04-07 12:21:07.629+00
1759	225	2	14	2018-04-07 13:17:20.043+00	2018-04-07 13:17:20.043+00
2222	311	3	10	2018-04-10 04:05:03.591+00	2018-04-10 04:05:03.591+00
2507	346	1	6	2018-04-13 01:43:21.07+00	2018-04-13 01:43:21.07+00
2510	345	5	12	2018-04-13 01:43:27.704+00	2018-04-13 01:43:27.704+00
3012	51	1	10	2018-04-19 09:00:38.442+00	2018-04-19 09:00:38.442+00
1801	168	2	6	2018-04-08 10:42:18.794+00	2018-04-08 10:42:18.794+00
1802	168	3	6	2018-04-08 10:42:18.795+00	2018-04-08 10:42:18.795+00
1820	241	3	6	2018-04-08 11:09:30.504+00	2018-04-08 11:09:30.504+00
1829	17	1	7	2018-04-08 11:51:14.22+00	2018-04-08 11:51:14.22+00
1830	17	3	7	2018-04-08 11:51:14.22+00	2018-04-08 11:51:14.22+00
1831	17	4	7	2018-04-08 11:51:14.22+00	2018-04-08 11:51:14.22+00
1832	17	5	7	2018-04-08 11:51:14.22+00	2018-04-08 11:51:14.22+00
1841	25	3	8	2018-04-08 12:03:00.081+00	2018-04-08 12:03:00.081+00
2022	270	3	7	2018-04-09 01:05:32.749+00	2018-04-09 01:05:32.749+00
1858	250	3	10	2018-04-08 12:16:29.61+00	2018-04-08 12:16:29.61+00
1859	250	4	10	2018-04-08 12:16:29.611+00	2018-04-08 12:16:29.611+00
2023	249	1	7	2018-04-09 01:05:41.939+00	2018-04-09 01:05:41.939+00
2025	249	4	7	2018-04-09 01:05:41.94+00	2018-04-09 01:05:41.94+00
2034	28	3	7	2018-04-09 01:06:34.391+00	2018-04-09 01:06:34.391+00
2036	28	5	7	2018-04-09 01:06:34.391+00	2018-04-09 01:06:34.391+00
2055	26	1	7	2018-04-09 01:21:36.217+00	2018-04-09 01:21:36.217+00
2056	26	3	7	2018-04-09 01:21:36.217+00	2018-04-09 01:21:36.217+00
2057	26	4	7	2018-04-09 01:21:36.217+00	2018-04-09 01:21:36.217+00
2058	26	5	7	2018-04-09 01:21:36.217+00	2018-04-09 01:21:36.217+00
2065	277	3	9	2018-04-09 01:26:45.653+00	2018-04-09 01:26:45.653+00
2066	278	3	9	2018-04-09 01:26:59.214+00	2018-04-09 01:26:59.214+00
2077	282	3	12	2018-04-09 02:04:03.608+00	2018-04-09 02:04:03.608+00
2078	282	4	12	2018-04-09 02:04:03.609+00	2018-04-09 02:04:03.609+00
2109	289	1	6	2018-04-09 02:37:56.847+00	2018-04-09 02:37:56.847+00
2110	289	3	6	2018-04-09 02:37:56.847+00	2018-04-09 02:37:56.847+00
2111	289	4	6	2018-04-09 02:37:56.847+00	2018-04-09 02:37:56.847+00
2119	290	3	8	2018-04-09 02:43:54.539+00	2018-04-09 02:43:54.539+00
2120	290	4	8	2018-04-09 02:43:54.54+00	2018-04-09 02:43:54.54+00
2129	291	4	8	2018-04-09 02:49:14.91+00	2018-04-09 02:49:14.91+00
1163	20	3	7	2018-04-01 05:01:48.995+00	2018-04-01 05:01:48.995+00
2880	414	1	8	2018-04-18 01:01:14.246+00	2018-04-18 01:01:14.246+00
1434	139	2	13	2018-04-04 11:52:19.94+00	2018-04-04 11:52:19.94+00
2140	295	3	10	2018-04-09 03:19:08.283+00	2018-04-09 03:19:08.283+00
1215	111	1	9	2018-04-01 10:48:40.64+00	2018-04-01 10:48:40.64+00
1216	111	3	9	2018-04-01 10:48:40.64+00	2018-04-01 10:48:40.64+00
1217	111	4	9	2018-04-01 10:48:40.64+00	2018-04-01 10:48:40.64+00
1219	112	3	9	2018-04-01 10:48:54.766+00	2018-04-01 10:48:54.766+00
1221	112	5	9	2018-04-01 10:48:54.766+00	2018-04-01 10:48:54.766+00
2148	297	3	10	2018-04-09 03:26:14.442+00	2018-04-09 03:26:14.442+00
1241	118	3	12	2018-04-01 11:21:24.386+00	2018-04-01 11:21:24.386+00
1242	118	4	12	2018-04-01 11:21:24.387+00	2018-04-01 11:21:24.387+00
1252	119	4	12	2018-04-01 11:45:04.919+00	2018-04-01 11:45:04.919+00
1443	127	2	13	2018-04-04 11:54:33.948+00	2018-04-04 11:54:33.948+00
1454	103	1	6	2018-04-04 12:01:50.998+00	2018-04-04 12:01:50.998+00
1265	123	3	12	2018-04-01 11:53:54.025+00	2018-04-01 11:53:54.025+00
1455	103	2	6	2018-04-04 12:01:50.998+00	2018-04-04 12:01:50.998+00
1621	133	2	15	2018-04-05 11:29:03.693+00	2018-04-05 11:29:03.693+00
1456	103	2	14	2018-04-04 12:01:50.998+00	2018-04-04 12:01:50.998+00
1630	190	2	14	2018-04-05 11:49:43.278+00	2018-04-05 11:49:43.278+00
1457	103	4	6	2018-04-04 12:01:50.998+00	2018-04-04 12:01:50.998+00
1469	48	2	6	2018-04-04 12:06:30.405+00	2018-04-04 12:06:30.405+00
1904	93	5	9	2018-04-08 13:12:51.47+00	2018-04-08 13:12:51.47+00
1643	191	2	6	2018-04-05 12:03:14.714+00	2018-04-05 12:03:14.714+00
1647	192	4	12	2018-04-05 12:03:23.119+00	2018-04-05 12:03:23.119+00
1664	137	2	9	2018-04-05 12:54:19.428+00	2018-04-05 12:54:19.428+00
2881	414	3	8	2018-04-18 01:01:14.246+00	2018-04-18 01:01:14.246+00
1493	33	1	8	2018-04-04 12:08:17.909+00	2018-04-04 12:08:17.909+00
1496	33	4	8	2018-04-04 12:08:17.909+00	2018-04-04 12:08:17.909+00
1499	32	2	14	2018-04-04 12:08:37.582+00	2018-04-04 12:08:37.582+00
1502	32	5	8	2018-04-04 12:08:37.583+00	2018-04-04 12:08:37.583+00
1342	141	2	6	2018-04-02 08:08:39.723+00	2018-04-02 08:08:39.723+00
1343	141	3	6	2018-04-02 08:08:39.723+00	2018-04-02 08:08:39.723+00
1344	141	5	6	2018-04-02 08:08:39.723+00	2018-04-02 08:08:39.723+00
2882	414	4	8	2018-04-18 01:01:14.247+00	2018-04-18 01:01:14.247+00
1665	136	2	9	2018-04-05 12:54:24.58+00	2018-04-05 12:54:24.58+00
2883	414	5	8	2018-04-18 01:01:14.247+00	2018-04-18 01:01:14.247+00
2479	343	1	10	2018-04-12 02:07:24.41+00	2018-04-12 02:07:24.41+00
2167	74	1	10	2018-04-09 03:41:43.908+00	2018-04-09 03:41:43.908+00
1389	56	4	10	2018-04-03 10:58:48.859+00	2018-04-03 10:58:48.859+00
1393	156	2	9	2018-04-03 11:28:54.225+00	2018-04-03 11:28:54.225+00
1541	8	3	6	2018-04-04 12:10:20.977+00	2018-04-04 12:10:20.977+00
2480	343	3	10	2018-04-12 02:07:24.41+00	2018-04-12 02:07:24.41+00
1418	161	5	6	2018-04-04 11:48:34.099+00	2018-04-04 11:48:34.099+00
1703	201	2	10	2018-04-05 13:15:30.146+00	2018-04-05 13:15:30.146+00
1421	160	2	13	2018-04-04 11:49:25.638+00	2018-04-04 11:49:25.638+00
1704	201	3	10	2018-04-05 13:15:30.146+00	2018-04-05 13:15:30.146+00
1587	177	2	13	2018-04-05 06:16:49.065+00	2018-04-05 06:16:49.065+00
1593	180	5	12	2018-04-05 10:42:20.549+00	2018-04-05 10:42:20.549+00
1598	182	2	14	2018-04-05 10:55:53.099+00	2018-04-05 10:55:53.099+00
1603	185	2	9	2018-04-05 11:01:27.683+00	2018-04-05 11:01:27.683+00
1604	185	2	10	2018-04-05 11:01:27.684+00	2018-04-05 11:01:27.684+00
1705	201	4	10	2018-04-05 13:15:30.146+00	2018-04-05 13:15:30.146+00
1713	205	2	13	2018-04-06 13:53:29.793+00	2018-04-06 13:53:29.793+00
1719	208	2	9	2018-04-06 14:08:35.217+00	2018-04-06 14:08:35.217+00
1725	211	2	14	2018-04-07 01:49:54.16+00	2018-04-07 01:49:54.16+00
1741	218	2	14	2018-04-07 11:34:41.34+00	2018-04-07 11:34:41.34+00
1748	219	2	13	2018-04-07 12:17:59.26+00	2018-04-07 12:17:59.26+00
1754	221	2	14	2018-04-07 12:28:28.185+00	2018-04-07 12:28:28.185+00
1760	226	2	14	2018-04-07 13:21:36.754+00	2018-04-07 13:21:36.754+00
1767	230	2	14	2018-04-07 13:47:24.926+00	2018-04-07 13:47:24.926+00
2545	352	1	7	2018-04-13 02:12:49.754+00	2018-04-13 02:12:49.754+00
1792	213	2	13	2018-04-07 14:12:04.375+00	2018-04-07 14:12:04.375+00
2554	354	1	7	2018-04-13 03:28:36.883+00	2018-04-13 03:28:36.883+00
1950	257	1	9	2018-04-08 13:29:36.178+00	2018-04-08 13:29:36.178+00
1821	241	5	6	2018-04-08 11:09:30.504+00	2018-04-08 11:09:30.504+00
1833	245	3	7	2018-04-08 11:55:31.324+00	2018-04-08 11:55:31.324+00
1834	245	5	7	2018-04-08 11:55:31.324+00	2018-04-08 11:55:31.324+00
1842	247	3	8	2018-04-08 12:05:15.509+00	2018-04-08 12:05:15.509+00
1951	257	3	9	2018-04-08 13:29:36.178+00	2018-04-08 13:29:36.178+00
1952	257	4	9	2018-04-08 13:29:36.178+00	2018-04-08 13:29:36.178+00
2555	354	3	7	2018-04-13 03:28:36.884+00	2018-04-13 03:28:36.884+00
2174	301	1	12	2018-04-09 03:44:38.525+00	2018-04-09 03:44:38.525+00
2176	301	4	12	2018-04-09 03:44:38.525+00	2018-04-09 03:44:38.525+00
2556	354	4	7	2018-04-13 03:28:36.884+00	2018-04-13 03:28:36.884+00
2567	356	1	9	2018-04-13 03:41:52.047+00	2018-04-13 03:41:52.047+00
2568	356	4	9	2018-04-13 03:41:52.047+00	2018-04-13 03:41:52.047+00
2936	350	1	6	2018-04-18 11:40:41.581+00	2018-04-18 11:40:41.581+00
2937	350	4	6	2018-04-18 11:40:41.581+00	2018-04-18 11:40:41.581+00
2005	271	3	10	2018-04-09 00:33:38.033+00	2018-04-09 00:33:38.033+00
2207	172	2	6	2018-04-09 11:45:38.315+00	2018-04-09 11:45:38.315+00
2024	249	3	7	2018-04-09 01:05:41.939+00	2018-04-09 01:05:41.939+00
2037	27	1	7	2018-04-09 01:06:49.98+00	2018-04-09 01:06:49.98+00
2039	27	4	7	2018-04-09 01:06:49.98+00	2018-04-09 01:06:49.98+00
2208	172	3	6	2018-04-09 11:45:38.315+00	2018-04-09 11:45:38.315+00
2212	308	3	6	2018-04-09 14:03:14.568+00	2018-04-09 14:03:14.568+00
2050	274	3	7	2018-04-09 01:07:51.767+00	2018-04-09 01:07:51.767+00
2051	274	4	7	2018-04-09 01:07:51.767+00	2018-04-09 01:07:51.767+00
2059	275	3	7	2018-04-09 01:23:06.989+00	2018-04-09 01:23:06.989+00
2060	275	4	7	2018-04-09 01:23:06.989+00	2018-04-09 01:23:06.989+00
2976	242	3	6	2018-04-19 00:47:22.397+00	2018-04-19 00:47:22.397+00
2608	363	4	9	2018-04-13 05:46:09.319+00	2018-04-13 05:46:09.319+00
2977	242	5	6	2018-04-19 00:47:22.398+00	2018-04-19 00:47:22.398+00
2079	283	3	12	2018-04-09 02:06:16.334+00	2018-04-09 02:06:16.334+00
2080	283	4	12	2018-04-09 02:06:16.334+00	2018-04-09 02:06:16.334+00
2998	424	1	6	2018-04-19 08:49:14.671+00	2018-04-19 08:49:14.671+00
3001	424	5	6	2018-04-19 08:49:14.672+00	2018-04-19 08:49:14.672+00
3011	53	5	10	2018-04-19 09:00:29.83+00	2018-04-19 09:00:29.83+00
3013	51	2	10	2018-04-19 09:00:38.442+00	2018-04-19 09:00:38.442+00
2223	312	3	6	2018-04-10 06:25:05.479+00	2018-04-10 06:25:05.479+00
2224	312	3	10	2018-04-10 06:25:05.479+00	2018-04-10 06:25:05.479+00
3020	153	5	10	2018-04-19 09:06:14.826+00	2018-04-19 09:06:14.826+00
3026	76	4	10	2018-04-19 09:36:18.285+00	2018-04-19 09:36:18.285+00
2232	313	3	10	2018-04-10 06:34:46.756+00	2018-04-10 06:34:46.756+00
3052	427	3	9	2018-06-15 00:48:36.993+00	2018-06-15 00:48:36.993+00
3053	427	5	9	2018-06-15 00:48:36.993+00	2018-06-15 00:48:36.993+00
3072	31	3	8	2018-06-29 02:24:36.527+00	2018-06-29 02:24:36.527+00
2249	317	3	6	2018-04-10 06:42:02.878+00	2018-04-10 06:42:02.878+00
2250	317	3	10	2018-04-10 06:42:02.878+00	2018-04-10 06:42:02.878+00
2251	317	5	10	2018-04-10 06:42:02.878+00	2018-04-10 06:42:02.878+00
3084	429	1	12	2018-06-29 04:23:01.773+00	2018-06-29 04:23:01.773+00
3085	429	4	12	2018-06-29 04:23:01.774+00	2018-06-29 04:23:01.774+00
3092	428	2	8	2018-06-29 04:23:45.126+00	2018-06-29 04:23:45.126+00
3098	391	4	9	2018-07-01 11:13:20.755+00	2018-07-01 11:13:20.755+00
2266	319	3	8	2018-04-10 06:54:04.292+00	2018-04-10 06:54:04.292+00
2267	319	4	8	2018-04-10 06:54:04.292+00	2018-04-10 06:54:04.292+00
2271	318	4	8	2018-04-10 07:06:32.366+00	2018-04-10 07:06:32.366+00
2274	322	3	8	2018-04-10 07:15:02.712+00	2018-04-10 07:15:02.712+00
2275	322	4	8	2018-04-10 07:15:02.712+00	2018-04-10 07:15:02.712+00
2282	46	1	6	2018-04-10 08:20:22.235+00	2018-04-10 08:20:22.235+00
2284	46	2	14	2018-04-10 08:20:22.236+00	2018-04-10 08:20:22.236+00
2286	46	5	8	2018-04-10 08:20:22.236+00	2018-04-10 08:20:22.236+00
2287	324	1	10	2018-04-10 08:21:12.064+00	2018-04-10 08:21:12.064+00
2288	324	3	10	2018-04-10 08:21:12.064+00	2018-04-10 08:21:12.064+00
2289	324	4	10	2018-04-10 08:21:12.064+00	2018-04-10 08:21:12.064+00
2293	323	1	10	2018-04-10 08:23:28.922+00	2018-04-10 08:23:28.922+00
2295	323	4	10	2018-04-10 08:23:28.922+00	2018-04-10 08:23:28.922+00
2296	325	1	10	2018-04-10 08:26:06.033+00	2018-04-10 08:26:06.033+00
2297	325	3	10	2018-04-10 08:26:06.033+00	2018-04-10 08:26:06.033+00
2298	325	4	10	2018-04-10 08:26:06.033+00	2018-04-10 08:26:06.033+00
2309	326	3	10	2018-04-10 09:15:00.418+00	2018-04-10 09:15:00.418+00
2310	326	4	10	2018-04-10 09:15:00.418+00	2018-04-10 09:15:00.418+00
1164	20	4	7	2018-04-01 05:01:48.996+00	2018-04-01 05:01:48.996+00
1179	15	4	7	2018-04-01 05:02:38.643+00	2018-04-01 05:02:38.643+00
1891	254	3	11	2018-04-08 13:09:01.636+00	2018-04-08 13:09:01.636+00
2884	24	1	7	2018-04-18 01:01:54.589+00	2018-04-18 01:01:54.589+00
2885	24	3	7	2018-04-18 01:01:54.589+00	2018-04-18 01:01:54.589+00
2886	24	4	7	2018-04-18 01:01:54.589+00	2018-04-18 01:01:54.589+00
1218	112	1	9	2018-04-01 10:48:54.766+00	2018-04-01 10:48:54.766+00
1220	112	4	9	2018-04-01 10:48:54.766+00	2018-04-01 10:48:54.766+00
1892	254	5	11	2018-04-08 13:09:01.637+00	2018-04-08 13:09:01.637+00
1622	132	2	15	2018-04-05 11:29:16.887+00	2018-04-05 11:29:16.887+00
1905	106	3	9	2018-04-08 13:14:03.224+00	2018-04-08 13:14:03.224+00
1444	126	2	13	2018-04-04 11:58:15.745+00	2018-04-04 11:58:15.745+00
1458	50	1	6	2018-04-04 12:06:03.332+00	2018-04-04 12:06:03.332+00
1459	50	2	6	2018-04-04 12:06:03.332+00	2018-04-04 12:06:03.332+00
1460	50	2	14	2018-04-04 12:06:03.332+00	2018-04-04 12:06:03.332+00
1254	120	1	12	2018-04-01 11:46:06.766+00	2018-04-01 11:46:06.766+00
1255	120	3	12	2018-04-01 11:46:06.766+00	2018-04-01 11:46:06.766+00
1256	120	4	12	2018-04-01 11:46:06.766+00	2018-04-01 11:46:06.766+00
1266	123	4	12	2018-04-01 11:53:54.025+00	2018-04-01 11:53:54.025+00
1461	50	4	6	2018-04-04 12:06:03.332+00	2018-04-04 12:06:03.332+00
1464	49	2	6	2018-04-04 12:06:13.557+00	2018-04-04 12:06:13.557+00
1906	106	4	9	2018-04-08 13:14:03.225+00	2018-04-08 13:14:03.225+00
1474	47	2	6	2018-04-04 12:06:43.8+00	2018-04-04 12:06:43.8+00
1907	106	5	9	2018-04-08 13:14:03.225+00	2018-04-08 13:14:03.225+00
2150	80	1	10	2018-04-09 03:27:15.866+00	2018-04-09 03:27:15.866+00
1644	191	4	12	2018-04-05 12:03:14.714+00	2018-04-05 12:03:14.714+00
2151	80	2	10	2018-04-09 03:27:15.866+00	2018-04-09 03:27:15.866+00
1666	196	2	6	2018-04-05 12:57:42.755+00	2018-04-05 12:57:42.755+00
1667	196	2	14	2018-04-05 12:57:42.756+00	2018-04-05 12:57:42.756+00
2152	80	3	10	2018-04-09 03:27:15.866+00	2018-04-09 03:27:15.866+00
2153	80	4	10	2018-04-09 03:27:15.866+00	2018-04-09 03:27:15.866+00
2887	24	5	7	2018-04-18 01:01:54.589+00	2018-04-18 01:01:54.589+00
1953	258	3	12	2018-04-08 13:40:49.068+00	2018-04-08 13:40:49.068+00
1686	199	2	10	2018-04-05 13:09:49.958+00	2018-04-05 13:09:49.958+00
1687	199	3	10	2018-04-05 13:09:49.959+00	2018-04-05 13:09:49.959+00
1688	199	4	10	2018-04-05 13:09:49.959+00	2018-04-05 13:09:49.959+00
1477	47	5	8	2018-04-04 12:06:43.8+00	2018-04-04 12:06:43.8+00
2920	338	3	12	2018-04-18 11:13:52.359+00	2018-04-18 11:13:52.359+00
2921	338	4	12	2018-04-18 11:13:52.359+00	2018-04-18 11:13:52.359+00
2938	422	1	10	2018-04-18 11:41:50.62+00	2018-04-18 11:41:50.62+00
2939	422	4	10	2018-04-18 11:41:50.62+00	2018-04-18 11:41:50.62+00
1706	202	2	10	2018-04-05 13:18:44.915+00	2018-04-05 13:18:44.915+00
1707	202	3	10	2018-04-05 13:18:44.915+00	2018-04-05 13:18:44.915+00
1353	144	2	8	2018-04-03 04:50:39.036+00	2018-04-03 04:50:39.036+00
1708	202	4	10	2018-04-05 13:18:44.915+00	2018-04-05 13:18:44.915+00
1363	148	2	7	2018-04-03 06:40:47.5+00	2018-04-03 06:40:47.5+00
2168	74	2	10	2018-04-09 03:41:43.908+00	2018-04-09 03:41:43.908+00
2175	301	3	12	2018-04-09 03:44:38.525+00	2018-04-09 03:44:38.525+00
2958	143	1	6	2018-04-18 11:52:59.11+00	2018-04-18 11:52:59.11+00
1542	8	5	6	2018-04-04 12:10:20.977+00	2018-04-04 12:10:20.977+00
1390	154	2	9	2018-04-03 11:18:42.757+00	2018-04-03 11:18:42.757+00
1394	157	2	9	2018-04-03 11:29:52.813+00	2018-04-03 11:29:52.813+00
1543	7	3	6	2018-04-04 12:10:33.333+00	2018-04-04 12:10:33.333+00
1549	166	1	6	2018-04-04 12:47:15.854+00	2018-04-04 12:47:15.854+00
1550	166	2	6	2018-04-04 12:47:15.854+00	2018-04-04 12:47:15.854+00
1551	166	2	14	2018-04-04 12:47:15.854+00	2018-04-04 12:47:15.854+00
2960	143	3	6	2018-04-18 11:52:59.111+00	2018-04-18 11:52:59.111+00
2191	303	3	10	2018-04-09 03:59:21.142+00	2018-04-09 03:59:21.142+00
1726	212	2	14	2018-04-07 02:06:38.023+00	2018-04-07 02:06:38.023+00
2962	143	5	6	2018-04-18 11:52:59.111+00	2018-04-18 11:52:59.111+00
1571	173	2	6	2018-04-04 13:42:47.463+00	2018-04-04 13:42:47.463+00
1577	175	2	13	2018-04-04 13:56:33.858+00	2018-04-04 13:56:33.858+00
2026	30	1	7	2018-04-09 01:06:02.551+00	2018-04-09 01:06:02.551+00
1749	159	2	13	2018-04-07 12:18:44.766+00	2018-04-07 12:18:44.766+00
1755	222	2	14	2018-04-07 13:07:54.481+00	2018-04-07 13:07:54.481+00
1599	183	2	14	2018-04-05 10:56:13.245+00	2018-04-05 10:56:13.245+00
2027	30	3	7	2018-04-09 01:06:02.551+00	2018-04-09 01:06:02.551+00
1762	227	2	15	2018-04-07 13:26:00.945+00	2018-04-07 13:26:00.945+00
1768	231	2	14	2018-04-07 13:49:07.345+00	2018-04-07 13:49:07.345+00
2028	30	4	7	2018-04-09 01:06:02.551+00	2018-04-09 01:06:02.551+00
2029	30	5	7	2018-04-09 01:06:02.551+00	2018-04-09 01:06:02.551+00
2052	273	3	7	2018-04-09 01:08:54.283+00	2018-04-09 01:08:54.283+00
1793	236	2	13	2018-04-07 14:13:37.747+00	2018-04-07 14:13:37.747+00
2071	279	3	12	2018-04-09 01:44:03.107+00	2018-04-09 01:44:03.107+00
2219	310	3	6	2018-04-10 04:04:56.593+00	2018-04-10 04:04:56.593+00
2546	352	3	7	2018-04-13 02:12:49.755+00	2018-04-13 02:12:49.755+00
1835	246	3	8	2018-04-08 11:57:24.785+00	2018-04-08 11:57:24.785+00
1843	248	3	8	2018-04-08 12:06:30.383+00	2018-04-08 12:06:30.383+00
1852	54	1	10	2018-04-08 12:13:09.678+00	2018-04-08 12:13:09.678+00
1853	54	2	10	2018-04-08 12:13:09.679+00	2018-04-08 12:13:09.679+00
1854	54	3	10	2018-04-08 12:13:09.679+00	2018-04-08 12:13:09.679+00
1855	54	4	10	2018-04-08 12:13:09.679+00	2018-04-08 12:13:09.679+00
2072	279	4	12	2018-04-09 01:44:03.107+00	2018-04-09 01:44:03.107+00
2231	313	3	6	2018-04-10 06:34:46.756+00	2018-04-10 06:34:46.756+00
2114	35	1	8	2018-04-09 02:40:04.261+00	2018-04-09 02:40:04.261+00
2115	35	2	14	2018-04-09 02:40:04.262+00	2018-04-09 02:40:04.262+00
2116	35	3	8	2018-04-09 02:40:04.262+00	2018-04-09 02:40:04.262+00
2117	35	4	8	2018-04-09 02:40:04.262+00	2018-04-09 02:40:04.262+00
2233	313	5	10	2018-04-10 06:34:46.756+00	2018-04-10 06:34:46.756+00
2234	314	3	6	2018-04-10 06:35:04.136+00	2018-04-10 06:35:04.136+00
2235	314	3	10	2018-04-10 06:35:04.136+00	2018-04-10 06:35:04.136+00
2236	314	5	10	2018-04-10 06:35:04.137+00	2018-04-10 06:35:04.137+00
2240	315	3	6	2018-04-10 06:37:24.907+00	2018-04-10 06:37:24.907+00
2241	315	3	10	2018-04-10 06:37:24.907+00	2018-04-10 06:37:24.907+00
2242	315	5	10	2018-04-10 06:37:24.907+00	2018-04-10 06:37:24.907+00
2246	316	3	6	2018-04-10 06:40:12.625+00	2018-04-10 06:40:12.625+00
2247	316	3	10	2018-04-10 06:40:12.625+00	2018-04-10 06:40:12.625+00
2248	316	5	10	2018-04-10 06:40:12.626+00	2018-04-10 06:40:12.626+00
2264	320	3	8	2018-04-10 06:53:46.167+00	2018-04-10 06:53:46.167+00
2265	320	4	8	2018-04-10 06:53:46.167+00	2018-04-10 06:53:46.167+00
2270	318	3	8	2018-04-10 07:06:32.365+00	2018-04-10 07:06:32.365+00
2272	321	3	8	2018-04-10 07:07:56.191+00	2018-04-10 07:07:56.191+00
2273	321	4	8	2018-04-10 07:07:56.192+00	2018-04-10 07:07:56.192+00
2283	46	2	6	2018-04-10 08:20:22.235+00	2018-04-10 08:20:22.235+00
2285	46	4	6	2018-04-10 08:20:22.236+00	2018-04-10 08:20:22.236+00
2294	323	3	10	2018-04-10 08:23:28.922+00	2018-04-10 08:23:28.922+00
2305	67	1	10	2018-04-10 09:10:20.15+00	2018-04-10 09:10:20.15+00
2306	67	3	10	2018-04-10 09:10:20.15+00	2018-04-10 09:10:20.15+00
2307	67	4	10	2018-04-10 09:10:20.15+00	2018-04-10 09:10:20.15+00
2308	67	5	10	2018-04-10 09:10:20.15+00	2018-04-10 09:10:20.15+00
2311	326	5	10	2018-04-10 09:15:00.418+00	2018-04-10 09:15:00.418+00
2336	328	1	9	2018-04-10 09:36:13.772+00	2018-04-10 09:36:13.772+00
2337	328	3	9	2018-04-10 09:36:13.772+00	2018-04-10 09:36:13.772+00
2338	328	4	9	2018-04-10 09:36:13.772+00	2018-04-10 09:36:13.772+00
2339	327	1	9	2018-04-10 09:38:07.434+00	2018-04-10 09:38:07.434+00
2340	327	3	9	2018-04-10 09:38:07.434+00	2018-04-10 09:38:07.434+00
2341	327	4	9	2018-04-10 09:38:07.434+00	2018-04-10 09:38:07.434+00
2342	329	1	9	2018-04-10 09:39:38.513+00	2018-04-10 09:39:38.513+00
2343	329	3	9	2018-04-10 09:39:38.513+00	2018-04-10 09:39:38.513+00
2344	329	4	9	2018-04-10 09:39:38.514+00	2018-04-10 09:39:38.514+00
2345	330	3	9	2018-04-10 11:37:27.801+00	2018-04-10 11:37:27.801+00
2346	330	4	9	2018-04-10 11:37:27.802+00	2018-04-10 11:37:27.802+00
2347	330	4	12	2018-04-10 11:37:27.802+00	2018-04-10 11:37:27.802+00
2888	415	1	7	2018-04-18 01:05:32.916+00	2018-04-18 01:05:32.916+00
2472	341	3	10	2018-04-10 12:59:06.267+00	2018-04-10 12:59:06.267+00
2922	423	1	12	2018-04-18 11:17:44.918+00	2018-04-18 11:17:44.918+00
2923	423	3	12	2018-04-18 11:17:44.918+00	2018-04-18 11:17:44.918+00
2924	423	4	12	2018-04-18 11:17:44.918+00	2018-04-18 11:17:44.918+00
2357	331	3	9	2018-04-10 11:48:53.182+00	2018-04-10 11:48:53.182+00
2358	331	4	9	2018-04-10 11:48:53.182+00	2018-04-10 11:48:53.182+00
2359	331	4	12	2018-04-10 11:48:53.182+00	2018-04-10 11:48:53.182+00
2361	333	1	10	2018-04-10 11:54:16.645+00	2018-04-10 11:54:16.645+00
2362	333	3	10	2018-04-10 11:54:16.645+00	2018-04-10 11:54:16.645+00
2363	333	4	10	2018-04-10 11:54:16.646+00	2018-04-10 11:54:16.646+00
2940	100	1	11	2018-04-18 11:43:42.619+00	2018-04-18 11:43:42.619+00
2941	100	3	11	2018-04-18 11:43:42.619+00	2018-04-18 11:43:42.619+00
2942	100	4	11	2018-04-18 11:43:42.619+00	2018-04-18 11:43:42.619+00
2533	351	1	6	2018-04-13 02:01:08.377+00	2018-04-13 02:01:08.377+00
2534	351	4	8	2018-04-13 02:01:08.377+00	2018-04-13 02:01:08.377+00
2547	352	4	7	2018-04-13 02:12:49.755+00	2018-04-13 02:12:49.755+00
2959	143	2	6	2018-04-18 11:52:59.11+00	2018-04-18 11:52:59.11+00
2371	336	1	10	2018-04-10 12:03:05.468+00	2018-04-10 12:03:05.468+00
2372	336	3	10	2018-04-10 12:03:05.468+00	2018-04-10 12:03:05.468+00
2373	336	4	10	2018-04-10 12:03:05.468+00	2018-04-10 12:03:05.468+00
2374	336	5	10	2018-04-10 12:03:05.468+00	2018-04-10 12:03:05.468+00
2375	335	3	10	2018-04-10 12:03:10.697+00	2018-04-10 12:03:10.697+00
2376	335	4	10	2018-04-10 12:03:10.697+00	2018-04-10 12:03:10.697+00
2377	334	1	10	2018-04-10 12:03:16.65+00	2018-04-10 12:03:16.65+00
2378	334	3	10	2018-04-10 12:03:16.65+00	2018-04-10 12:03:16.65+00
2379	334	4	10	2018-04-10 12:03:16.65+00	2018-04-10 12:03:16.65+00
2380	34	1	10	2018-04-10 12:03:36.614+00	2018-04-10 12:03:36.614+00
2381	34	3	10	2018-04-10 12:03:36.614+00	2018-04-10 12:03:36.614+00
2382	34	4	10	2018-04-10 12:03:36.614+00	2018-04-10 12:03:36.614+00
2383	34	5	10	2018-04-10 12:03:36.614+00	2018-04-10 12:03:36.614+00
2384	337	1	10	2018-04-10 12:12:58.022+00	2018-04-10 12:12:58.022+00
2385	337	3	10	2018-04-10 12:12:58.022+00	2018-04-10 12:12:58.022+00
2386	337	4	10	2018-04-10 12:12:58.022+00	2018-04-10 12:12:58.022+00
2387	101	1	11	2018-04-10 12:13:40.319+00	2018-04-10 12:13:40.319+00
2388	101	3	11	2018-04-10 12:13:40.319+00	2018-04-10 12:13:40.319+00
2389	101	4	11	2018-04-10 12:13:40.319+00	2018-04-10 12:13:40.319+00
2961	143	4	6	2018-04-18 11:52:59.111+00	2018-04-18 11:52:59.111+00
2392	234	1	12	2018-04-10 12:24:06.438+00	2018-04-10 12:24:06.438+00
2393	234	2	10	2018-04-10 12:24:06.438+00	2018-04-10 12:24:06.438+00
2394	234	3	10	2018-04-10 12:24:06.438+00	2018-04-10 12:24:06.438+00
2395	234	4	10	2018-04-10 12:24:06.438+00	2018-04-10 12:24:06.438+00
2402	339	1	7	2018-04-10 12:42:18.19+00	2018-04-10 12:42:18.19+00
2403	339	3	7	2018-04-10 12:42:18.19+00	2018-04-10 12:42:18.19+00
2404	339	4	7	2018-04-10 12:42:18.19+00	2018-04-10 12:42:18.19+00
2405	339	5	7	2018-04-10 12:42:18.19+00	2018-04-10 12:42:18.19+00
2983	10	3	6	2018-04-19 01:10:59.632+00	2018-04-19 01:10:59.632+00
2413	13	1	6	2018-04-10 12:46:52.646+00	2018-04-10 12:46:52.646+00
2414	13	1	7	2018-04-10 12:46:52.647+00	2018-04-10 12:46:52.647+00
2415	13	4	6	2018-04-10 12:46:52.647+00	2018-04-10 12:46:52.647+00
2416	13	4	7	2018-04-10 12:46:52.647+00	2018-04-10 12:46:52.647+00
2417	13	5	12	2018-04-10 12:46:52.647+00	2018-04-10 12:46:52.647+00
2999	424	3	6	2018-04-19 08:49:14.672+00	2018-04-19 08:49:14.672+00
3014	51	3	10	2018-04-19 09:00:38.442+00	2018-04-19 09:00:38.442+00
3021	63	3	10	2018-04-19 09:13:21.621+00	2018-04-19 09:13:21.621+00
2593	361	1	7	2018-04-13 04:02:18.178+00	2018-04-13 04:02:18.178+00
2595	361	4	7	2018-04-13 04:02:18.178+00	2018-04-13 04:02:18.178+00
3022	63	4	10	2018-04-19 09:13:21.621+00	2018-04-19 09:13:21.621+00
3023	63	5	10	2018-04-19 09:13:21.621+00	2018-04-19 09:13:21.621+00
3027	104	1	12	2018-04-19 09:57:23.08+00	2018-04-19 09:57:23.08+00
3028	104	4	12	2018-04-19 09:57:23.08+00	2018-04-19 09:57:23.08+00
3036	239	3	6	2018-06-14 10:48:36.973+00	2018-06-14 10:48:36.973+00
3037	239	5	6	2018-06-14 10:48:36.973+00	2018-06-14 10:48:36.973+00
3044	265	3	8	2018-06-15 00:35:37.98+00	2018-06-15 00:35:37.98+00
3045	265	4	8	2018-06-15 00:35:37.98+00	2018-06-15 00:35:37.98+00
3054	165	2	14	2018-06-15 00:49:16.068+00	2018-06-15 00:49:16.068+00
2436	179	2	6	2018-04-10 12:49:18.281+00	2018-04-10 12:49:18.281+00
2437	179	2	14	2018-04-10 12:49:18.281+00	2018-04-10 12:49:18.281+00
2438	263	3	6	2018-04-10 12:49:36.267+00	2018-04-10 12:49:36.267+00
3063	267	3	8	2018-06-29 02:21:54.088+00	2018-06-29 02:21:54.088+00
2624	367	4	9	2018-04-13 06:01:55.41+00	2018-04-13 06:01:55.41+00
2627	369	1	9	2018-04-13 06:14:15.49+00	2018-04-13 06:14:15.49+00
2442	286	1	6	2018-04-10 12:50:17.162+00	2018-04-10 12:50:17.162+00
2443	286	3	6	2018-04-10 12:50:17.162+00	2018-04-10 12:50:17.162+00
2444	286	4	6	2018-04-10 12:50:17.167+00	2018-04-10 12:50:17.167+00
2445	288	1	6	2018-04-10 12:50:47.899+00	2018-04-10 12:50:47.899+00
2446	288	3	6	2018-04-10 12:50:47.9+00	2018-04-10 12:50:47.9+00
2447	288	4	6	2018-04-10 12:50:47.9+00	2018-04-10 12:50:47.9+00
3064	267	4	8	2018-06-29 02:21:54.088+00	2018-06-29 02:21:54.088+00
3073	31	4	8	2018-06-29 02:24:36.527+00	2018-06-29 02:24:36.527+00
2628	369	4	9	2018-04-13 06:14:15.49+00	2018-04-13 06:14:15.49+00
3093	428	3	8	2018-06-29 04:23:45.126+00	2018-06-29 04:23:45.126+00
3094	428	4	8	2018-06-29 04:23:45.127+00	2018-06-29 04:23:45.127+00
3099	392	1	9	2018-07-01 11:13:35.048+00	2018-07-01 11:13:35.048+00
3101	392	4	9	2018-07-01 11:13:35.048+00	2018-07-01 11:13:35.048+00
3102	393	1	9	2018-07-01 11:13:49.773+00	2018-07-01 11:13:49.773+00
3103	393	3	9	2018-07-01 11:13:49.773+00	2018-07-01 11:13:49.773+00
3104	393	4	9	2018-07-01 11:13:49.773+00	2018-07-01 11:13:49.773+00
3106	394	3	9	2018-07-01 11:14:00.865+00	2018-07-01 11:14:00.865+00
2652	373	1	9	2018-04-13 13:34:05.583+00	2018-04-13 13:34:05.583+00
2653	373	1	10	2018-04-13 13:34:05.583+00	2018-04-13 13:34:05.583+00
2654	373	3	9	2018-04-13 13:34:05.583+00	2018-04-13 13:34:05.583+00
2655	373	3	10	2018-04-13 13:34:05.584+00	2018-04-13 13:34:05.584+00
2656	373	4	9	2018-04-13 13:34:05.584+00	2018-04-13 13:34:05.584+00
2658	373	4	10	2018-04-13 13:34:05.584+00	2018-04-13 13:34:05.584+00
2661	374	3	9	2018-04-13 13:35:25.4+00	2018-04-13 13:35:25.4+00
2662	374	3	10	2018-04-13 13:35:25.4+00	2018-04-13 13:35:25.4+00
2663	374	4	10	2018-04-13 13:35:25.4+00	2018-04-13 13:35:25.4+00
2664	374	4	9	2018-04-13 13:35:25.4+00	2018-04-13 13:35:25.4+00
2665	375	1	12	2018-04-13 13:49:28.769+00	2018-04-13 13:49:28.769+00
2666	375	3	12	2018-04-13 13:49:28.769+00	2018-04-13 13:49:28.769+00
2667	375	4	12	2018-04-13 13:49:28.769+00	2018-04-13 13:49:28.769+00
2671	376	1	12	2018-04-13 13:51:50.661+00	2018-04-13 13:51:50.661+00
2672	376	3	12	2018-04-13 13:51:50.661+00	2018-04-13 13:51:50.661+00
2673	376	4	12	2018-04-13 13:51:50.661+00	2018-04-13 13:51:50.661+00
2677	377	1	12	2018-04-13 13:53:47.018+00	2018-04-13 13:53:47.018+00
2678	377	3	12	2018-04-13 13:53:47.018+00	2018-04-13 13:53:47.018+00
2679	377	4	12	2018-04-13 13:53:47.018+00	2018-04-13 13:53:47.018+00
2697	380	1	12	2018-04-13 20:27:56.199+00	2018-04-13 20:27:56.199+00
2698	380	4	12	2018-04-13 20:27:56.199+00	2018-04-13 20:27:56.199+00
2699	378	1	6	2018-04-13 20:28:25.285+00	2018-04-13 20:28:25.285+00
2700	378	1	12	2018-04-13 20:28:25.285+00	2018-04-13 20:28:25.285+00
2701	378	4	12	2018-04-13 20:28:25.286+00	2018-04-13 20:28:25.286+00
2702	379	1	6	2018-04-13 20:28:40.517+00	2018-04-13 20:28:40.517+00
2703	379	1	12	2018-04-13 20:28:40.518+00	2018-04-13 20:28:40.518+00
2704	379	4	12	2018-04-13 20:28:40.518+00	2018-04-13 20:28:40.518+00
2705	381	1	12	2018-04-13 20:29:52.861+00	2018-04-13 20:29:52.861+00
2706	381	4	12	2018-04-13 20:29:52.861+00	2018-04-13 20:29:52.861+00
2710	383	1	8	2018-04-13 20:43:48.931+00	2018-04-13 20:43:48.931+00
2711	214	2	14	2018-04-13 20:44:22.434+00	2018-04-13 20:44:22.434+00
2712	293	3	7	2018-04-13 20:45:21.803+00	2018-04-13 20:45:21.803+00
2713	293	4	7	2018-04-13 20:45:21.804+00	2018-04-13 20:45:21.804+00
2714	292	1	7	2018-04-13 20:45:30.301+00	2018-04-13 20:45:30.301+00
2715	292	3	7	2018-04-13 20:45:30.302+00	2018-04-13 20:45:30.302+00
2716	292	4	7	2018-04-13 20:45:30.302+00	2018-04-13 20:45:30.302+00
2717	384	1	7	2018-04-13 20:47:14.169+00	2018-04-13 20:47:14.169+00
2718	384	3	7	2018-04-13 20:47:14.169+00	2018-04-13 20:47:14.169+00
2721	385	1	7	2018-04-15 12:59:42.274+00	2018-04-15 12:59:42.274+00
2722	385	4	7	2018-04-15 12:59:42.274+00	2018-04-15 12:59:42.274+00
2723	386	1	7	2018-04-15 13:01:32.578+00	2018-04-15 13:01:32.578+00
2724	386	4	7	2018-04-15 13:01:32.578+00	2018-04-15 13:01:32.578+00
2943	252	1	11	2018-04-18 11:43:54.603+00	2018-04-18 11:43:54.603+00
2945	252	4	11	2018-04-18 11:43:54.604+00	2018-04-18 11:43:54.604+00
2729	387	1	7	2018-04-15 13:04:53.835+00	2018-04-15 13:04:53.835+00
2730	387	4	7	2018-04-15 13:04:53.836+00	2018-04-15 13:04:53.836+00
2731	388	1	7	2018-04-15 13:05:03.383+00	2018-04-15 13:05:03.383+00
2732	388	4	7	2018-04-15 13:05:03.383+00	2018-04-15 13:05:03.383+00
2963	37	1	8	2018-04-18 11:56:53.876+00	2018-04-18 11:56:53.876+00
2734	91	1	9	2018-04-15 13:06:33.246+00	2018-04-15 13:06:33.246+00
2735	91	2	9	2018-04-15 13:06:33.246+00	2018-04-15 13:06:33.246+00
2736	91	3	9	2018-04-15 13:06:33.246+00	2018-04-15 13:06:33.246+00
2737	91	4	9	2018-04-15 13:06:33.247+00	2018-04-15 13:06:33.247+00
2738	91	5	9	2018-04-15 13:06:33.247+00	2018-04-15 13:06:33.247+00
2964	37	3	8	2018-04-18 11:56:53.876+00	2018-04-18 11:56:53.876+00
2965	37	4	8	2018-04-18 11:56:53.876+00	2018-04-18 11:56:53.876+00
2741	389	1	9	2018-04-15 13:09:31.504+00	2018-04-15 13:09:31.504+00
2742	390	1	7	2018-04-15 13:11:26.313+00	2018-04-15 13:11:26.313+00
2966	37	5	8	2018-04-18 11:56:53.876+00	2018-04-18 11:56:53.876+00
2967	372	1	10	2018-04-18 11:57:06.923+00	2018-04-18 11:57:06.923+00
2982	10	1	6	2018-04-19 01:10:59.632+00	2018-04-19 01:10:59.632+00
2985	10	5	6	2018-04-19 01:10:59.632+00	2018-04-19 01:10:59.632+00
3000	424	4	6	2018-04-19 08:49:14.672+00	2018-04-19 08:49:14.672+00
3015	51	4	10	2018-04-19 09:00:38.442+00	2018-04-19 09:00:38.442+00
3024	76	1	10	2018-04-19 09:36:18.285+00	2018-04-19 09:36:18.285+00
3029	426	1	12	2018-04-19 09:59:03.722+00	2018-04-19 09:59:03.722+00
2759	395	1	9	2018-04-15 13:36:31.869+00	2018-04-15 13:36:31.869+00
2760	395	4	9	2018-04-15 13:36:31.869+00	2018-04-15 13:36:31.869+00
3030	426	4	12	2018-04-19 09:59:03.722+00	2018-04-19 09:59:03.722+00
3038	240	3	6	2018-06-14 10:49:17.804+00	2018-06-14 10:49:17.804+00
2763	114	1	12	2018-04-15 13:38:48.618+00	2018-04-15 13:38:48.618+00
2764	114	2	14	2018-04-15 13:38:48.618+00	2018-04-15 13:38:48.618+00
2765	114	3	12	2018-04-15 13:38:48.618+00	2018-04-15 13:38:48.618+00
2766	114	4	12	2018-04-15 13:38:48.618+00	2018-04-15 13:38:48.618+00
2767	114	5	12	2018-04-15 13:38:48.618+00	2018-04-15 13:38:48.618+00
3039	240	5	6	2018-06-14 10:49:17.804+00	2018-06-14 10:49:17.804+00
3046	340	1	6	2018-06-15 00:42:00.729+00	2018-06-15 00:42:00.729+00
2770	396	1	12	2018-04-15 13:42:42.615+00	2018-04-15 13:42:42.615+00
2771	396	4	12	2018-04-15 13:42:42.615+00	2018-04-15 13:42:42.615+00
2772	302	1	12	2018-04-15 13:42:56.93+00	2018-04-15 13:42:56.93+00
2773	302	3	12	2018-04-15 13:42:56.93+00	2018-04-15 13:42:56.93+00
2774	302	4	12	2018-04-15 13:42:56.931+00	2018-04-15 13:42:56.931+00
3047	340	3	6	2018-06-15 00:42:00.73+00	2018-06-15 00:42:00.73+00
3048	340	5	6	2018-06-15 00:42:00.73+00	2018-06-15 00:42:00.73+00
3055	262	2	14	2018-06-28 01:30:02.83+00	2018-06-28 01:30:02.83+00
3056	262	3	12	2018-06-28 01:30:02.83+00	2018-06-28 01:30:02.83+00
3057	262	4	12	2018-06-28 01:30:02.831+00	2018-06-28 01:30:02.831+00
2786	294	3	10	2018-04-15 13:51:15.627+00	2018-04-15 13:51:15.627+00
2787	294	4	10	2018-04-15 13:51:15.627+00	2018-04-15 13:51:15.627+00
2788	59	1	10	2018-04-15 13:51:48.231+00	2018-04-15 13:51:48.231+00
2789	59	2	10	2018-04-15 13:51:48.232+00	2018-04-15 13:51:48.232+00
2790	59	3	10	2018-04-15 13:51:48.232+00	2018-04-15 13:51:48.232+00
2791	59	4	10	2018-04-15 13:51:48.232+00	2018-04-15 13:51:48.232+00
2792	59	5	10	2018-04-15 13:51:48.232+00	2018-04-15 13:51:48.232+00
2800	399	1	6	2018-04-15 23:51:06.663+00	2018-04-15 23:51:06.663+00
2801	399	2	6	2018-04-15 23:51:06.663+00	2018-04-15 23:51:06.663+00
2802	399	3	6	2018-04-15 23:51:06.663+00	2018-04-15 23:51:06.663+00
2803	399	4	6	2018-04-15 23:51:06.663+00	2018-04-15 23:51:06.663+00
2804	399	5	6	2018-04-15 23:51:06.663+00	2018-04-15 23:51:06.663+00
2805	400	1	6	2018-04-15 23:53:17.765+00	2018-04-15 23:53:17.765+00
2806	400	2	6	2018-04-15 23:53:17.765+00	2018-04-15 23:53:17.765+00
2807	400	3	6	2018-04-15 23:53:17.765+00	2018-04-15 23:53:17.765+00
2808	400	4	6	2018-04-15 23:53:17.765+00	2018-04-15 23:53:17.765+00
2809	400	5	6	2018-04-15 23:53:17.765+00	2018-04-15 23:53:17.765+00
2810	401	1	6	2018-04-15 23:57:04.254+00	2018-04-15 23:57:04.254+00
2811	401	1	9	2018-04-15 23:57:04.254+00	2018-04-15 23:57:04.254+00
2812	401	4	6	2018-04-15 23:57:04.254+00	2018-04-15 23:57:04.254+00
2813	401	4	9	2018-04-15 23:57:04.254+00	2018-04-15 23:57:04.254+00
2814	16	1	7	2018-04-15 23:58:07.731+00	2018-04-15 23:58:07.731+00
2815	16	3	7	2018-04-15 23:58:07.731+00	2018-04-15 23:58:07.731+00
2816	16	4	7	2018-04-15 23:58:07.731+00	2018-04-15 23:58:07.731+00
2817	16	5	7	2018-04-15 23:58:07.731+00	2018-04-15 23:58:07.731+00
2818	402	1	7	2018-04-16 00:00:32.782+00	2018-04-16 00:00:32.782+00
2819	402	4	7	2018-04-16 00:00:32.783+00	2018-04-16 00:00:32.783+00
2822	403	1	7	2018-04-16 00:02:13.199+00	2018-04-16 00:02:13.199+00
2823	403	4	7	2018-04-16 00:02:13.199+00	2018-04-16 00:02:13.199+00
2824	404	1	7	2018-04-16 00:03:13.472+00	2018-04-16 00:03:13.472+00
2825	404	4	7	2018-04-16 00:03:13.472+00	2018-04-16 00:03:13.472+00
2826	405	1	7	2018-04-16 00:04:40.293+00	2018-04-16 00:04:40.293+00
2827	405	4	7	2018-04-16 00:04:40.293+00	2018-04-16 00:04:40.293+00
3070	31	1	8	2018-06-29 02:24:36.527+00	2018-06-29 02:24:36.527+00
3074	31	5	8	2018-06-29 02:24:36.527+00	2018-06-29 02:24:36.527+00
2832	408	1	7	2018-04-16 00:10:31.547+00	2018-04-16 00:10:31.547+00
2833	408	4	7	2018-04-16 00:10:31.547+00	2018-04-16 00:10:31.547+00
2834	407	1	7	2018-04-16 00:10:41.249+00	2018-04-16 00:10:41.249+00
2835	407	4	7	2018-04-16 00:10:41.249+00	2018-04-16 00:10:41.249+00
2836	406	1	7	2018-04-16 00:11:07.788+00	2018-04-16 00:11:07.788+00
2837	406	4	7	2018-04-16 00:11:07.788+00	2018-04-16 00:11:07.788+00
2838	9	1	6	2018-04-17 22:10:13.979+00	2018-04-17 22:10:13.979+00
2839	9	2	6	2018-04-17 22:10:13.98+00	2018-04-17 22:10:13.98+00
2840	9	3	6	2018-04-17 22:10:13.98+00	2018-04-17 22:10:13.98+00
2841	9	4	6	2018-04-17 22:10:13.98+00	2018-04-17 22:10:13.98+00
2842	9	5	6	2018-04-17 22:10:13.98+00	2018-04-17 22:10:13.98+00
2846	12	1	6	2018-04-17 22:36:08.862+00	2018-04-17 22:36:08.862+00
2847	12	3	6	2018-04-17 22:36:08.863+00	2018-04-17 22:36:08.863+00
2848	12	4	6	2018-04-17 22:36:08.863+00	2018-04-17 22:36:08.863+00
2849	12	5	12	2018-04-17 22:36:08.863+00	2018-04-17 22:36:08.863+00
2850	410	1	7	2018-04-17 22:37:50.172+00	2018-04-17 22:37:50.172+00
2851	410	3	7	2018-04-17 22:37:50.172+00	2018-04-17 22:37:50.172+00
2852	410	4	7	2018-04-17 22:37:50.172+00	2018-04-17 22:37:50.172+00
2856	411	1	7	2018-04-17 22:47:30.512+00	2018-04-17 22:47:30.512+00
2857	411	3	7	2018-04-17 22:47:30.512+00	2018-04-17 22:47:30.512+00
2858	411	4	7	2018-04-17 22:47:30.512+00	2018-04-17 22:47:30.512+00
2859	412	1	7	2018-04-17 22:51:46.224+00	2018-04-17 22:51:46.224+00
2860	412	3	7	2018-04-17 22:51:46.224+00	2018-04-17 22:51:46.224+00
2861	412	4	7	2018-04-17 22:51:46.224+00	2018-04-17 22:51:46.224+00
3096	391	1	9	2018-07-01 11:13:20.755+00	2018-07-01 11:13:20.755+00
3100	392	3	9	2018-07-01 11:13:35.048+00	2018-07-01 11:13:35.048+00
3105	394	1	9	2018-07-01 11:14:00.865+00	2018-07-01 11:14:00.865+00
3107	394	4	9	2018-07-01 11:14:00.865+00	2018-07-01 11:14:00.865+00
2866	413	1	6	2018-04-17 22:58:48.41+00	2018-04-17 22:58:48.41+00
2867	413	1	7	2018-04-17 22:58:48.41+00	2018-04-17 22:58:48.41+00
2868	413	3	6	2018-04-17 22:58:48.41+00	2018-04-17 22:58:48.41+00
2869	413	4	6	2018-04-17 22:58:48.41+00	2018-04-17 22:58:48.41+00
2872	357	1	8	2018-04-17 22:59:48.861+00	2018-04-17 22:59:48.861+00
2873	357	4	8	2018-04-17 22:59:48.862+00	2018-04-17 22:59:48.862+00
3108	332	3	9	2018-07-03 11:06:46.407+00	2018-07-03 11:06:46.407+00
3109	431	1	12	2018-08-17 13:37:23.666+00	2018-08-17 13:37:23.666+00
3110	102	1	11	2018-08-18 11:05:47.158+00	2018-08-18 11:05:47.158+00
3111	102	4	11	2018-08-18 11:05:47.158+00	2018-08-18 11:05:47.158+00
3112	432	1	11	2018-08-18 11:15:03.862+00	2018-08-18 11:15:03.862+00
3113	432	3	11	2018-08-18 11:15:03.862+00	2018-08-18 11:15:03.862+00
3114	433	1	9	2018-08-18 11:51:37.761+00	2018-08-18 11:51:37.761+00
3115	433	1	12	2018-08-18 11:51:37.761+00	2018-08-18 11:51:37.761+00
3116	434	1	11	2018-08-21 11:08:18.04+00	2018-08-21 11:08:18.04+00
3117	434	3	11	2018-08-21 11:08:18.041+00	2018-08-21 11:08:18.041+00
3118	435	1	12	2018-08-21 11:25:34.489+00	2018-08-21 11:25:34.489+00
3119	435	3	12	2018-08-21 11:25:34.49+00	2018-08-21 11:25:34.49+00
3120	436	1	10	2018-08-21 11:38:32.628+00	2018-08-21 11:38:32.628+00
3121	436	2	10	2018-08-21 11:38:32.628+00	2018-08-21 11:38:32.628+00
3122	436	3	10	2018-08-21 11:38:32.628+00	2018-08-21 11:38:32.628+00
3123	397	1	12	2018-08-24 02:25:33.23+00	2018-08-24 02:25:33.23+00
3124	397	2	14	2018-08-24 02:25:33.231+00	2018-08-24 02:25:33.231+00
3125	397	4	12	2018-08-24 02:25:33.231+00	2018-08-24 02:25:33.231+00
3126	398	1	12	2018-08-24 02:25:48.024+00	2018-08-24 02:25:48.024+00
3127	398	2	14	2018-08-24 02:25:48.024+00	2018-08-24 02:25:48.024+00
3128	398	4	12	2018-08-24 02:25:48.024+00	2018-08-24 02:25:48.024+00
3132	437	1	9	2018-08-26 08:10:31.017+00	2018-08-26 08:10:31.017+00
3133	437	2	9	2018-08-26 08:10:31.017+00	2018-08-26 08:10:31.017+00
3134	437	3	9	2018-08-26 08:10:31.017+00	2018-08-26 08:10:31.017+00
3135	64	3	10	2018-08-26 08:47:43.757+00	2018-08-26 08:47:43.757+00
3136	64	4	10	2018-08-26 08:47:43.757+00	2018-08-26 08:47:43.757+00
3137	64	5	10	2018-08-26 08:47:43.757+00	2018-08-26 08:47:43.757+00
3139	438	2	10	2018-08-26 08:50:03.182+00	2018-08-26 08:50:03.182+00
3140	438	2	13	2018-08-26 08:50:03.182+00	2018-08-26 08:50:03.182+00
3141	184	2	9	2018-09-02 03:31:20.521+00	2018-09-02 03:31:20.521+00
3142	184	2	10	2018-09-02 03:31:20.522+00	2018-09-02 03:31:20.522+00
3143	439	2	9	2018-09-02 03:36:51.853+00	2018-09-02 03:36:51.853+00
3144	439	2	10	2018-09-02 03:36:51.853+00	2018-09-02 03:36:51.853+00
\.


--
-- Data for Name: exercises; Type: TABLE DATA; Schema: public; Owner: phoenix_lib
--

COPY public.exercises (id, name, description, springs, photo, video, "createdAt", "updatedAt", revision) FROM stdin;
423	Rotating Lunge 	<p><u><strong>Set Up&nbsp;</strong></u></p>\r\n<p>Come into scooter position.</p>\r\n<p><br></p>\r\n<p><u><strong>The Exercise&nbsp;</strong></u></p>\r\n<p>Press back into lunge if left leg is pressed back rotate right arm resting hand on frame reaching right arm up to ceiling. hold in deep rotation. You can pulse deeper into lunge or simply breath. Alternate sides.&nbsp;</p>\r\n<p><br></p>\r\n<p><u><strong>TEACHING TIP;</strong></u><em><strong> If able bring the hand to the ground.</strong></em>&nbsp;</p>	1 RED 	Triceps.jpg		2018-04-18 11:17:44.912+00	2018-04-18 13:26:52.399+00	1
6	Imprint Single Leg	<p><u><strong>Set up</strong></u></p>\r\n<p>Supine. Heels on foot bar. Spine neutral. Arms by sides. Head rest comfortable. Float one leg up to table top.</p>\r\n<p><br></p>\r\n<p><u><strong>The exercise</strong></u><u>&nbsp;</u></p>\r\n<p>Inhale neutral spine and pelvis. Exhale imprint lumbar spine into the mat with single leg lifted in table top.&nbsp;</p>\r\n<p><br></p>\r\n<p><em><strong>NOTE Can be done on the mat or reformer</strong></em></p>	3 RED or 1 Blue	Imprint Single Leg.jpg		2018-03-21 19:03:34+00	2018-04-19 00:39:33.474+00	1
53	Kneeling Arm Side Series Straight Arm Side Lift 	<p><u><strong>Set up</strong></u></p>\r\n<p>Kneeling towards the side of carriage. Knees pelvis distance apart. Spine and pelvis neutral. Strap in hand closest to foot bar.&nbsp;</p>\r\n<p><br></p>\r\n<p><u><strong>The exercise&nbsp;</strong></u></p>\r\n<p>Arm straight by side. Exhale adduct arm to shoulder hight.&nbsp;</p>\r\n<p><br></p>\r\n<p><em><strong>NOTE Regression sitting on Long Box&nbsp;</strong></em></p>	1 BLUE or 1 RED + 	Kneeling Arms Side Series Straight Arm Side Lift .jpg		2018-03-27 17:01:11+00	2018-04-19 09:00:29.871+00	3
68	Mermaid with Rotation 	<p><u><strong>Set Up&nbsp;</strong></u></p>\r\n<p>Z sit on carriage facing sidewards. Hand on Foot bar forward of the centre of bar. Other arm outstretched.&nbsp;</p>\r\n<p><br></p>\r\n<p><u><strong>The Exercise</strong></u></p>\r\n<p>Inhale to prepare. Exhale press hand into Foot bar as out stretched arm arcs up and over. Spine comes into lateral flexion bring hand to foot bar and spine into rotation. Add arm presses. &nbsp;Inhale into top lung. Exhale return to starting position.&nbsp;</p>	1 RED	Mermaid with Rotation.jpg		2018-03-29 01:12:18+00	2018-04-19 09:21:42.776+00	1
74	Matadore 	<p><u><strong>Set up</strong></u></p>\r\n<p>Kneeling side facing on carriage. Knee closest to foot bar against shoulder rest other foot on frame 90/90 flexion at hip and knee. Arms crossed at shoulder hight.&nbsp;</p>\r\n<p><br></p>\r\n<p><u><strong>The exercise</strong></u></p>\r\n<p>Inhale to prepare. Exhale press foot into frame and knee into shoulder. Adduct knee to centre line.&nbsp;</p>\r\n<p><br></p>\r\n<p><br></p>	1 BLUE 	Matadore.jpg		2018-03-29 01:39:15+00	2018-04-19 09:27:39.378+00	1
200	Green Room Magic Circle Bicep Curls 	<p><u><strong>Set up</strong></u></p>\r\n<p>Sitting at bottom edge of carriage. Knees bent. Feet on Head Rest. Holding straps in bicep curl. Elbows level with shoulders. Magic Circle between knees&nbsp;</p>\r\n<p><br></p>\r\n<p><u><strong>The Excercise&nbsp;</strong></u></p>\r\n<p>Inhale to prepare. Exhale roll back into C curve until Sacrum is in contact with carriage. Inhale extend elbows. Exhale gentle bicep curl x10 and squeeze magic circle at same time.&nbsp;</p>	1 BLUE 	Green Room Magic Cricles Biceps.jpg		2018-04-05 13:10:52.172+00	2018-07-03 11:45:11.368+00	1
48	Series 5 Criss Cross	<p><u><em><strong>Set up</strong></em></u></p>\r\n<p>Supine. Table top legs. Hands interlaced behind head at occipital ridge. Elbows in peripheral vision.&nbsp;</p>\r\n<p><br></p>\r\n<p><u><em><strong>The exercise</strong></em></u></p>\r\n<p>Interlace hands behind bead continue single bent leg stretch. Exhale oblique rotation towards bent leg. Be sure to rotate torso not just elbows.</p>\r\n<p><br></p>\r\n<p><em><strong>NOTE Do this on the Mat or Long Box</strong></em></p>	MAT	Series 5 Criss Cross.jpg		2018-03-25 19:24:43+00	2018-04-18 22:55:10.014+00	1
55	Kneeling Arm Side Series Side Triceps 	<p><u><strong>Set up</strong></u></p>\r\n<p>Kneeling towards the side of carriage. Knees pelvis distance apart. Spine and pelvis neutral. Holing hand strap.Strap in hand closest to foot bar other hand on shoulder rest spine in lateral flexion like kneeling mermaid. Hand with strap at crown palm up.</p>\r\n<p><br></p>\r\n<p><u><strong>The Exercise&nbsp;</strong></u></p>\r\n<p>Exhale extend elbow.&nbsp;</p>\r\n<p><br></p>\r\n<p><em><strong>NOTE Can sit on a Long Box</strong></em></p>	1 BLUE or 1 RED 	Kneeling Arm Side Series Side Triceps.jpg		2018-03-27 17:11:10+00	2018-04-19 09:04:13.075+00	1
62	Kneeling Arm Series Kneeling Triceps 	<p><u><strong>Set up</strong></u></p>\r\n<p>Kneeling facing foot bar. Toes against shoulder rests. Spine and pelvis neutral. Holing hand straps ir foot straps. Palms facing out finger tips at “3rd eye”&nbsp;</p>\r\n<p><br></p>\r\n<p><u><strong>The Exercise&nbsp;</strong></u></p>\r\n<p>Exhale press diagonally up as elbows extend. Inhale connect core on eccentric contraction. Lean body into the tension of the straps.&nbsp;</p>\r\n<p><br></p>\r\n<p><em><strong>NOTE Sit on box for variation.&nbsp;</strong></em></p>	1 BLUE or 1 RED 	Kneeling Arm Series Kneeling Triceps.jpg		2018-03-27 17:59:56+00	2018-04-19 09:11:54.381+00	1
431	Scooter Short Box Combo	<p><u><strong>Set Up</strong></u></p>\r\n<p>&nbsp;Short Box on the Reformer. Side Facing towards Reformer. Foot closest to Short box on Short Box. Hands in prayer position. Suported leg bent.&nbsp;</p>\r\n<p><br></p>\r\n<p><u><strong>The Exercise&nbsp;</strong></u></p>\r\n<p>Side scooter press x 10 Hold on last one 10 pulses with supported leg as arms come up to 5th. Adductor stretch towards working leg.</p>\r\n<p>Rotate for x 10 scooter foot at base of short box. Arms swing forward as leg pushes back. Hold on last one for 10 pulses arms reach above head.</p>\r\n<p>Come to side seated on short box for side abs x 10 and x10 reaches.&nbsp;</p>\r\n<p>Swap sides. &nbsp;</p>	1 RED 1 BLUE or 2 RED 	Scooter Short Box Combo.jpg		2018-08-17 13:37:23.66+00	2018-09-01 01:43:40.767+00	1
50	Series 5 Single Straight Leg Stretch 	<p><u><em><strong>Set up</strong></em></u></p>\r\n<p>Supine. Table top legs. Hands interlaced behind head at occipital ridge. Elbows in peripheral vision.&nbsp;</p>\r\n<p><br></p>\r\n<p><u><em><strong>The excersice&nbsp;</strong></em></u></p>\r\n<p>Legs extended into L shape. Holding behind one knee. Exhale switch pulling leg towards chest.&nbsp;</p>\r\n<p><br></p>\r\n<p><em><strong>NOTE Do this on the mat or the long box</strong></em></p>	MAT	Series 5 Single Straight Leg Stretch.jpg		2018-03-25 19:28:06+00	2018-04-18 22:55:47.996+00	1
65	Stomach Massage Monkey	<p><u><strong>Set up</strong></u></p>\r\n<p>Sitting on the bottom edge of carriage. Toes in V on foot bar. &nbsp;</p>\r\n<p><br></p>\r\n<p><u><strong>The Exercise</strong></u></p>\r\n<p>&nbsp;Holding onto foot bar between V toes. If this is not comfortable take toes wide on Foot bar. Exhale deepen core connection press toes into foot bar to extend the knees. Inhale return to start.&nbsp;</p>	1 RED + 	Stomach Massage Monkey .jpg		2018-03-27 18:27:32+00	2018-04-19 09:18:29.103+00	1
21	Footwork Rises 	<p><u><strong>Set up</strong></u></p>\r\n<p>Supine. Toes parallel on foot bar. Spine neutral. Arms by sides. Head rest comfortable.&nbsp;</p>\r\n<p><br></p>\r\n<p><u><strong>The exercise</strong></u></p>\r\n<p>Rise onto balls of feet then sink heels under the foot bar. Maintain Neutral Spine.&nbsp;</p>\r\n<p><br></p>\r\n<p><strong>NOTE </strong><em><strong>Smooth movement be sure not to bounce.</strong></em></p>	3 RED 	Footwork Rises.jpg		2018-03-22 00:03:35+00	2018-08-29 01:44:53.647+00	2
432	Prone Magic Circle Squeeze	<p><u><strong>Set Up</strong></u></p>\r\n<p>Lying Prone on Long Box magic circles between ankles. Ams Crossed elbows pressed into box.</p>\r\n<p><br></p>\r\n<p><u><strong>The Exercise&nbsp;</strong></u></p>\r\n<p>&nbsp;Squeeze the magic circles between ancles rappidly. Spine thoracic extension.</p>		Prone Magic Circle Squeezes.jpg		2018-08-18 11:15:03.856+00	2018-09-01 01:42:42.732+00	1
9	Pelvic Curl 	<p><u><strong>Set up</strong></u></p>\r\n<p>Supine. Heels on foot bar. Spine neutral. Arms by sides. Head rest down.&nbsp;</p>\r\n<p><br></p>\r\n<p><u><strong>The exercise</strong></u></p>\r\n<p>Inhale to prepare. Exhale move through imprint, curl tail bone to pubic bone, pubic bone to navle roll up 1 vertebra at a time to T6. Inhale at top, exhale roll down articulating each vertebra till set up position is reached.</p>\r\n<p><br></p>\r\n<p><strong>NOTE &nbsp;Be sure not to roll into spine extension. Sink the sternum lift the Pubic Bone.&nbsp;</strong></p>\r\n<p><strong>Use the light spring setting for more hamstring connection, heavy spring for focus on spine articulation.&nbsp;</strong></p>	3 RED or 1 BLUE	Pelvic curl.jpg		2018-03-21 19:40:47+00	2018-04-18 23:04:15.543+00	1
66	Stomach Massage Rotation 	<p><u><strong>Set up</strong></u></p>\r\n<p>Sitting on the bottom edge of carriage. Toes in V on foot bar. &nbsp;</p>\r\n<p><u><strong>The Exercise&nbsp;</strong></u></p>\r\n<p>Lengthen spine into active neutral, or as close as possible. Reach arm diagonally up. Exhale deepen core connection press toes into foot bar to extend the knees. Rotate arm behind body at shoulder hight. Inhale return to both arms reaching diagonally up. Alternate arms.</p>	1 RED +	Stomach Massage Rotation.jpg		2018-03-27 18:28:35+00	2018-04-19 09:19:35.265+00	1
35	Hands in Straps Cheerleader	<p><u><strong>Set up</strong></u></p>\r\n<p>Supine. Hands in straps. Spine neutral. Legs table top. Head rest comfortable. If the core is not strong enough lumbar spine can imprint otherwise neutral pelvis. SIngle arm to celiling single arm to side&nbsp;</p>\r\n<p><br></p>\r\n<p><u><em><strong>The exercise</strong></em></u></p>\r\n<p>Bring both arms to side of body alternate arm that goes to the roof.&nbsp;</p>\r\n<p><br></p>\r\n<p><em><strong>NOTE Come into chest lift if client is able to maintaion good neck stability, shoulder alignment and core control.&nbsp;</strong></em></p>	1 RED, 1 BLUE or 2 RED decrease springs if there is neck tension. 	Hands in Straps Cheerleader.jpg		2018-03-23 00:03:27+00	2018-09-01 01:41:45.873+00	1
433	Mountain Climber on Reformer	<p><u><strong>Set Up</strong></u></p>\r\n<p>Hands on Shoulder rests feet on foot bar. Push out to plank</p>\r\n<p><br></p>\r\n<p><u><strong>The Exercise&nbsp;</strong></u></p>\r\n<p>Slowly with control draw leg into hip and knee flexion. Pull knee towards the center of chest.&nbsp;</p>\r\n<p>To regress. Stay in plank or put feet on foot platform.</p>	2 RED 	Mountain Climbre on eformer.jpg		2018-08-18 11:51:37.755+00	2018-09-01 01:41:59.93+00	1
252	Breaststroke Long Box with Straps	<p><u><strong>Set up</strong></u></p>\r\n<p>Prone on long box legs stretched out long heels together or wide. Holding straps. Head towards foot bar. Foot bar down.</p>\r\n<p><br></p>\r\n<p><u><strong>The exercise</strong></u></p>\r\n<p>Both arms reaching past head. Elbows straight. Wrists shoulder distance apart. Circle arms around like breast stroke. Alternate directions.&nbsp;</p>\r\n<p><br></p>\r\n<p><em><strong>NOTE for advanced clients come into spine extension.</strong></em></p>	1 RED +	Long Box Breast Stroke.jpg		2018-04-08 13:05:38.475+00	2018-04-18 23:34:43.34+00	1
100	Breaststroke on Long Box with Straps 	<p><u><strong>Set up</strong></u></p>\r\n<p>Prone on long box legs stretched out long heels together or wide. Holding straps. Head towards foot bar. Foot bar down.</p>\r\n<p><br></p>\r\n<p><u><strong>The exercise</strong></u></p>\r\n<p>Holding loops. Reach arms above head. Inhale circle arms around. Exhale bend elbows to press back to start. Like breast stroke. Change directions.&nbsp;</p>\r\n<p><br></p>\r\n<p><em><strong>NOTE; For advanced clients come into spine extension.</strong></em></p>	1 RED + 	Long Box Breast Stroke.jpg		2018-03-31 11:06:28.135+00	2018-04-18 23:34:46.5+00	1
434	Short Box Back Extension	<p><u><strong>Set Up</strong></u>&nbsp;</p>\r\n<p>Short box on reformer. Lying prone over box. Feettucked under foot bar. Legs straight. Arms by side.&nbsp;</p>\r\n<p><br></p>\r\n<p><u><strong>The Exercise&nbsp;</strong></u></p>\r\n<p>Exhale pressing back of ankles into footbar legs straight come into back extension. Arms reach above head, Inhale retern to start.&nbsp;</p>\r\n<p><br></p>	ALL Strings 	Short Box Back Extension.jpg		2018-08-21 11:08:18.035+00	2018-09-01 09:43:02.663+00	1
91	Reverse Abdominals Round Back 	<p><u><strong>Set up</strong></u></p>\r\n<p>Kneeling on carriage knees fist distance from shoulder rests. Hands on frames wrists under shoulders. Round Back.&nbsp;</p>\r\n<p><br></p>\r\n<p><u><strong>The exercise</strong></u></p>\r\n<p>Inhale to prepare. Exhale press shins into carriage to pull carriage towards wrists. Inhale return to start position.</p>\r\n<p><br>\r\n<em><strong>NOTE Pull from abdominals and lats not upper traps. Keep shoulders drawing away from ears.&nbsp;</strong></em></p>	1 RED or 1 BLUE	Reverse Abs Round Back.jpg		2018-03-31 10:36:22.836+00	2018-04-18 23:43:05.68+00	1
435	Short Box Pelvic Press	<p><u><strong>Set Up&nbsp;</strong></u></p>\r\n<p>Supine on Short box T6/7 on edge. Feet on Foot Bar. Foot bar on low setting. Arms in second.&nbsp;</p>\r\n<p><br></p>\r\n<p><u><strong>The Exercise</strong></u></p>\r\n<p>Exhale press pelvis up into pelvic press as arms cose to first position. Inhale return pelvis down coming into back extension, return arms to second.&nbsp;</p>\r\n<p>&nbsp;</p>\r\n<p><br></p>	ALL Springs	Short Box Pelvic Press.jpg		2018-08-21 11:25:34.476+00	2018-09-01 09:46:33.502+00	1
89	Hamstring Curl Double Leg	<p><u><strong>Set up</strong></u></p>\r\n<p>Prone on long box arms crossed elbow pushing into box. Slight thoracic and cervical extension. Feet in straps. tension in straps.&nbsp;</p>\r\n<p><br></p>\r\n<p><u><strong>The exercise</strong></u></p>\r\n<p>Exhale pull hells tosits bones. Keep knees lifted off the box to &nbsp;lengthen hamstring.&nbsp;</p>	2 RED	Hamstring Pull Double.jpg		2018-03-31 06:54:20.33+00	2018-04-18 23:37:16.133+00	1
90	Hamstring Curl Single Leg	<p><u><strong>Set up</strong></u></p>\r\n<p>Prone on long box arms crossed elbow pushing into box. Slight thoracic and cervical extension. Feet in straps. tension in straps.&nbsp;</p>\r\n<p>&nbsp;</p>\r\n<p><u><strong>The exercise</strong></u></p>\r\n<p>Exhale pull single hell to sit bone. Keep knee lifted off the box to lengthen hamstring to return to start.</p>\r\n<p><br></p>	2 RED 	Hamstring Pull Single.jpg		2018-03-31 07:04:41.327+00	2018-04-18 23:37:24.09+00	1
93	Reverse Abdominals Obliques 	<p><u><strong>Set up</strong></u></p>\r\n<p>Kneeling on carriage knees fist distance from shoulder rests. Both hands on one side of frame.&nbsp;</p>\r\n<p><br></p>\r\n<p><u><strong>The exercise</strong></u></p>\r\n<p>Inhale to prepare. Exhale press shins into carriage to pull carriage towards wrists. Inhale return to start position.</p>\r\n<p><br></p>\r\n<p><em><strong>NOTE Pull from abdominals and lats not upper traps. Keep shoulders drawing away from ears.&nbsp;</strong></em></p>	1 BLUE 	Reverse Abs Obliques.jpg		2018-03-31 10:40:32.782+00	2018-04-18 23:43:15.005+00	1
436	Mermaid Arms Combo	<p>Set Up&nbsp;</p>\r\n<p>Seated in mermaid position. Hand closest to head rest in strap. Legs in Z sit.</p>\r\n<p><br></p>\r\n<p>The Exercise&nbsp;</p>\r\n<p>Arms move from second to fifth x 5&nbsp;</p>\r\n<p>Arms stay in fifth on exhalation move body into lateral flexion towards foot bar x5&nbsp;</p>\r\n<p>Bent arm press over head into lateral flexion as free arm reaches past pelvis &nbsp;towards opisite hip x 5&nbsp;</p>		Mermaid Arms Combo.jpg		2018-08-21 11:38:32.62+00	2018-09-01 09:41:10.114+00	1
88	Short Box Series Side Release 	<p><u><strong>Set up</strong></u></p>\r\n<p>Side sitting on short box one leg extended and foot under strap the other tucked up on box. Lean away from Foot bar until there is tension in foot strap and one sit bone has lifted off box.&nbsp;</p>\r\n<p><br></p>\r\n<p><u><strong>The Exercise</strong></u></p>\r\n<p>Release into short box mermaid. Breathing into top lateral ribs.</p>	3 RED 1 BLUE 1 YELLOW	Short Box Series Side Release.jpg		2018-03-31 06:51:05.465+00	2018-04-19 09:49:42.147+00	1
374	Tendon Stretch 	<p><u><strong>Set Up&nbsp;</strong></u></p>\r\n<p>Sitting on foot bar balls of feet on carriage edge. Blue Ball in between ankles.Hands holding into foot bar to sides of body. Knuckles facing towards feet.&nbsp;</p>\r\n<p><br></p>\r\n<p><u><strong>The Exercise</strong></u></p>\r\n<p>Inhale prepare. Exhale push into handes in bar and lift hips off foot bar. find a deep C curve with the spine using the exhalatin to find core connection. Keep lifting hips to the ceiling drawing nose to navel and let the carriage come in to stoppter.&nbsp;</p>\r\n<p><br></p>\r\n<p><em><strong>NOTE; Lift with the abdominals as much as the arms.&nbsp;</strong></em></p>	1 RED 1 BLUE 	Tendon Stretch.jpg		2018-04-13 13:35:25.386+00	2018-06-14 12:00:42.246+00	1
242	Spine Twist 	<p><u><strong>Set Up&nbsp;</strong></u></p>\r\n<p>Supine on Reformer or Mat. Legs at table top hands holdinging onto pistons (foot strap rests beside head rest.) &nbsp;Gently imprint lumbar spine.&nbsp;</p>\r\n<p><br></p>\r\n<p><u><strong>The Exercise</strong></u>&nbsp;</p>\r\n<p>Inhale rotate knees to side letting the pelvis lift. Try to keep knees flush. Shoulders remain in contact with the carriage or mat. Exhale deepen core connection bring knees back to center. This is a lumber thoracic rotation.&nbsp;</p>\r\n<p><br></p>\r\n<p><em><strong>NOTE; To progress straighten legs. If on the mat have arms by sides.&nbsp;</strong></em></p>	2 RED or MAT 	Spine Twist.jpg		2018-04-08 10:56:09.269+00	2018-04-19 01:07:44.094+00	2
95	Semi Circle 	<p><u><strong>Set up</strong></u></p>\r\n<p>Hands on shoulder rests. Elbows extended. Scapular on edge of carriage. Balls of feet on foot bar feet in a V . Pelvis pressed up.</p>\r\n<p><br></p>\r\n<p><u>&nbsp;</u><u><strong>The exercise</strong></u></p>\r\n<p>Inhale to prepare. Exhale press toes into foot bar to extend knees keeping pelvis lifted. Roll down into spine extension. Inhale draw carriage in as knees bend “drag” bottom along springs. Exhale pelvic curl to starting position.&nbsp;</p>	2 RED or 1 RED, 1 BLUE 	Semi Circle.jpg		2018-03-31 10:46:38.496+00	2018-09-01 02:00:55.882+00	1
437	Cleopatra 2	<p><u><strong>Set Up&nbsp;</strong></u></p>\r\n<p>Long box on the ground next to Reformer in line with bed.&nbsp;</p>\r\n<p>4 point kneeling hands on box knees on bed.&nbsp;</p>\r\n<p><br></p>\r\n<p><u><strong>The Exercise&nbsp;</strong></u></p>\r\n<p>Press knee away towards pullies using deep core and obliques. x 4&nbsp;</p>\r\n<p>Press knees away développé leg closest to pullies to side, return leg then pull carriage back to start. &nbsp;x 4&nbsp;</p>\r\n<p>Press knees away développé leg closest to pullies to side as bed returns home bring straight leg towards groud toe tap. Repeate in reverse.&nbsp;</p>\r\n<p><br></p>\r\n<p><u><strong>NOTE</strong></u> Maintain shoulder stability don't let scapular wing. &nbsp;</p>	1 Yellow or 1 BLUE	Cleopatra 2.jpg		2018-08-26 08:02:08.2+00	2018-09-02 03:39:25.919+00	2
10	Pelvic Curl Single Leg	<p><u><strong>Set up</strong></u></p>\r\n<p>Supine. Heels on foot bar. Spine neutral. Arms by sides. Head rest down.&nbsp;One leg at table top.&nbsp;</p>\r\n<p><br></p>\r\n<p><u><strong>The exercise</strong></u></p>\r\n<p>Inhale to prepare. Exhale move through imprint, curl tail bone to pubic bone, pubic bone to navle roll up 1 vertebra at a time to T6.Inhale at top, exhale roll down articulating each vertebra till set up position is reached.</p>\r\n<p><br></p>\r\n<p><em><strong>NOTE &nbsp;Kepp table top legs shin parallel to the roof.&nbsp;&nbsp;Be sure not to roll into spine extension. Sink the sternum lift the Pubic Bone.&nbsp;</strong></em></p>\r\n<p><em><strong>Use the light spring setting for more hamstring connection, heavy spring for focus on spine articulation.</strong></em></p>\r\n<p><u><em><strong>In technique class use 3 RED </strong></em></u>&nbsp;</p>	3 RED or 1 BLUE In technique class use 3 RED 	Pelvic Curl Single Leg.JPG		2018-03-21 23:07:56+00	2018-07-09 12:02:16.957+00	3
438	Stomach massage Jump 	<p><u><strong>Set up</strong></u></p>\r\n<p>Sitting on the bottom edge of carriage. Toes in V on Jump board. Center of board. Knees extended.&nbsp;</p>\r\n<p>&nbsp;&nbsp;</p>\r\n<p><u><strong>The Exercise&nbsp;</strong></u></p>\r\n<p>Forward flexion C curve of the spine. Holding bottom of carriage. Inhale prepare. Exhale deepen core connection and jump.&nbsp;</p>\r\n<p><br></p>\r\n<p><br></p>	1 BLUE	Stomach Massage Jump.jpg		2018-08-26 08:48:33.07+00	2018-09-02 03:29:56.294+00	2
33	Hands in Straps Circles 	<p><u><strong>Set up</strong></u></p>\r\n<p>Supine. Hands in straps. Spine neutral. Legs table top. Head rest comfortable. If the core is not strong enough lumbar spine can imprint otherwise neutral pelvis. Hands reaching to ceiling.</p>\r\n<p><br></p>\r\n<p><u><strong>The exercise</strong></u></p>\r\n<p>Inhale to prepare. Exhale press the arms around. Alternate directions.&nbsp;</p>\r\n<p><br></p>\r\n<p><em><strong>NOTE Come into chest lift if client is able to maintaion good neck stability, shoulder alignment and core control.&nbsp;</strong></em></p>	1 RED, 1 BLUE or 2 RED decrease springs if there is neck tension. 	Triceps.jpg		2018-03-22 23:01:28+00	2018-04-18 13:18:47.724+00	1
123	Russian Splits	<p><u><strong>Set Up&nbsp;</strong></u></p>\r\n<p>One foot on foot bar the other in high heel on the shoulder rest</p>\r\n<p><br></p>\r\n<p><u><strong>The Exercise&nbsp;</strong></u></p>\r\n<p>Lifting hands up either crossed at chest or reaching out to sides.Bring body upright.Extend both knees. Inhale press back into splits. Exhale return to start.&nbsp;</p>	1 RED 1 BLUE 	Russian Splits.jpg		2018-04-01 11:53:45.279+00	2018-04-19 10:51:55.195+00	1
122	Front Splits	<p><u><strong>Set Up&nbsp;</strong></u></p>\r\n<p>One foot on foot bar the other in high heel on the shoulder rest</p>\r\n<p><br></p>\r\n<p><u><strong>The Exercise&nbsp;</strong></u></p>\r\n<p>Lifting hands up either crossed at chest or reaching out to sides.Bring body upright. Inhale extend front knee. Exhale return.&nbsp;</p>	1 RED 1 Blue	Russian Splits Back Knee.jpg		2018-04-01 11:52:19.249+00	2018-04-19 10:54:03.83+00	1
121	Front Splits Preparation 	<p><u><strong>Set Up&nbsp;</strong></u></p>\r\n<p>One foot on foot bar the other in high heel on the shoulder rest</p>\r\n<p><br></p>\r\n<p><u><strong>The exercise</strong></u></p>\r\n<p>Holding onto the foot bar either side of foot. Exhale extend knee. Inhale return to start.&nbsp;</p>	1 RED and 1 BLUE 	Front Splits Preparation.jpg		2018-04-01 11:49:28.734+00	2018-04-19 11:58:23.244+00	1
424	Pelvic Curl Marches	<p><u><strong>Set up</strong></u></p>\r\n<p>Supine. Heels on foot bar. Spine neutral. Arms by sides. Head rest down.</p>\r\n<p><br></p>\r\n<p><u><strong>The exercise</strong></u></p>\r\n<p>Inhale to prepare. Exhale move through imprint, curl tail bone to pubic bone, pubic bone to navle roll up 1 vertebra at a time to T6.</p>\r\n<p>Hold this position. Single Leg lifts (marches) x 10 Inhale Lower leg back to footbar. Roll down.&nbsp;</p>\r\n<p><br></p>\r\n<p><em><strong>NOTE &nbsp;Kepp table top legs shin parallel to the roof.&nbsp;&nbsp;Be sure not to roll into spine extension. Sink the sternum lift the Pubic Bone.&nbsp;</strong></em></p>\r\n<p><em><strong>Use the light spring setting for more hamstring connection, heavy spring for focus on spine articulation.</strong></em></p>\r\n<p><u><em><strong>In technique class use 3 RED </strong></em></u>&nbsp;</p>	1 RED 1 BLUE	Pelvic Curl Single Leg.JPG		2018-04-19 01:12:38.309+00	2018-07-09 12:01:48.561+00	2
228	Side Plank Twist 	<p><u><strong>Set Up&nbsp;</strong></u></p>\r\n<p>Side elbow plank on reformer. Be sure shoulder is over elbow. Feet on foot plate crossed at ankles top leg in front. Hand reaching towards ceiling.&nbsp;</p>\r\n<p><br></p>\r\n<p><u><strong>The Exercise</strong></u></p>\r\n<p>Squeezing adductors together keeping legs straight. Inhale prepare. Exhale lift hips up. &nbsp;Top arm reaches under hips "threading the needle" Inhale return to set up.&nbsp;</p>\r\n<p><br></p>\r\n<p><em><strong>NOTE; Initiate the movement with abdominal activation.</strong></em>&nbsp;</p>	1 BLUE or 1 RED 	Side Plank Twist.jpg		2018-04-07 13:30:16.843+00	2018-08-28 13:54:29.208+00	1
119	Standing Side Splits Plié	<p><u><strong>Set up</strong></u></p>\r\n<p>Standing on foot plate FIRST. Other foot at bottom of carriage. Feet aligned.&nbsp;</p>\r\n<p><br></p>\r\n<p><u><strong>The exercise</strong></u></p>\r\n<p>Exhale plié press carriage out. Inhale extend knees and plié keeping carriage still. Exhale bring carriage back to start maintain plié&nbsp;</p>	1 RED + or 1 BLUE 	\N		2018-04-01 11:39:19.424+00	2018-04-18 13:18:47.724+00	1
120	Standing Side Splits Dancer Squats	<p><u><strong>Set up</strong></u></p>\r\n<p>Standing on foot plate FIRST. Other foot at bottom of carriage. Feet aligned externally rotated at hips. 1st possition.</p>\r\n<p><br></p>\r\n<p><u><strong>The exercise</strong></u></p>\r\n<p>Exhale plié press carriage out. Hold carriage out and still. squat x 10. &nbsp;Exhale bring carriage back to start maintain plié&nbsp;</p>	1 RED + or 1 BLUE 	\N		2018-04-01 11:44:54.504+00	2018-04-18 13:18:47.724+00	1
38	Abdominal Series Co-ordination 	<p><u><strong>Set up</strong></u></p>\r\n<p>Supine. Hands in straps. Spine neutral. Legs table top. Head rest comfortable. If the core is not strong enough lumbar spine can imprint otherwise neutral pelvis. Reach arms to roof.&nbsp;</p>\r\n<p><br></p>\r\n<p><u><strong>The exercise&nbsp;</strong></u></p>\r\n<p>Exhale chest lift arms go into tricep press as legs extended. Hold breath beat heels in, out. Inhale return legs to table top and arms to tricep press.</p>	1 RED, 1 BLUE	Abdominal Series Coordination5.jpg		2018-03-25 18:15:22+00	2018-04-19 08:20:44.339+00	1
131	Jump Single Straight Leg 	<p><u><strong>Set up</strong></u></p>\r\n<p>Supine. Feet parallel on jump board. Arms by sides. Head rest comfortable.&nbsp;</p>\r\n<p><br></p>\r\n<p><u><strong>The exercise</strong></u></p>\r\n<p>Legs parallel. One leg at extended to ceiling to create L shape. Inhale bend knee. Exhale extend knee to jump. Switch legs or continue with single leg, or batterie &nbsp;<em>(beat legs).</em></p>\r\n<p><br></p>\r\n<p><em><strong>NOTE You may choose Jump with chest lift&nbsp;</strong></em></p>\r\n<p><em><strong>Curl head neck shoulders into chest lift. Inhale bend knees. Exhale jump. Place soft ball under upper thoracic if jumping in chest lift for extended&nbsp;</strong></em></p>	1 RED + or 1 BLUE 	Jump Single Straight Leg.jpg		2018-04-02 00:43:34.797+00	2018-07-03 11:34:35.487+00	1
213	Jump Footwork Criss Cross Ankles. 	<p><u><strong>Set Up&nbsp;</strong></u></p>\r\n<p>Supine. Feet in small V. &nbsp;Arms by sides. Head rest comfortable or in a chest lift.&nbsp;</p>\r\n<p><br></p>\r\n<p><u><strong>The Exercise</strong></u></p>\r\n<p>Inhale bend knees. Exhale jump Criss Cross ankles while mid air.&nbsp;</p>\r\n<p><br></p>\r\n<p><em><strong>NOTE You may choose Jump with chest lift&nbsp;</strong></em></p>\r\n<p><em><strong>Curl head neck shoulders into chest lift. Inhale bend knees. Exhale jump. Place soft ball under upper thoracic if jumping in chest lift for extended&nbsp;</strong></em></p>	1 BLUE or 1 RED 	Jump Footwork Criss Cross.jpg		2018-04-07 02:10:18.925+00	2018-08-28 14:00:15.346+00	1
425	Footwork Prances	<p><u><strong>Set up</strong></u></p>\r\n<p>Supine. Toes parallel on foot bar. Spine neutral. Arms by sides. Head rest comfortable.&nbsp;</p>\r\n<p><br></p>\r\n<p><u><strong>The exercise</strong></u></p>\r\n<p>Rise onto balls of feet then sink left heel under the foot bar bending right knee. Alternate sides. Maintain Neutral Spine.&nbsp;</p>\r\n<p><br></p>\r\n<p><u><strong>TEACHING TIP;</strong></u><strong> &nbsp;</strong><em><strong>Smooth movement be sure not to bounce.</strong></em></p>	3 RED	Footwork Prances.jpg		2018-04-19 08:35:39.874+00	2018-04-19 08:35:47.514+00	1
146	Jump Footwork Parallel 	<p><u><strong>Set Up&nbsp;</strong></u></p>\r\n<p>Supine. Feet parallel on jump board. Arms by sides. Head rest comfortable or in a chest lift.&nbsp;</p>\r\n<p><br></p>\r\n<p><u><strong>The Exercise</strong></u></p>\r\n<p>Feet &nbsp;parallel. Inhale bend knees. Exhale jump.</p>\r\n<p><br></p>\r\n<p><em><strong>NOTE You may choose Jump with chest lift&nbsp;</strong></em></p>\r\n<p><em><strong>Curl head neck shoulders into chest lift. Inhale bend knees. Exhale jump. Place soft ball under upper thoracic if jumping in chest lift for extended&nbsp;</strong></em></p>	2 RED + or 1 BLUE 	Jump Footwork Parallel.jpg		2018-04-03 06:35:28.852+00	2018-07-01 22:22:51.466+00	1
286	Pelvic Curl Magic Circle Squeezes 	<p><u><strong>Set up</strong></u></p>\r\n<p>Supine. Heels on foot bar. Spine neutral. Arms by sides. Head rest down.&nbsp;Magic Circle between knees.&nbsp;</p>\r\n<p><br></p>\r\n<p><u><strong>The exercise</strong></u></p>\r\n<p>Inhale to prepare. Exhale move through imprint, curl tail bone to pubic bone, pubic bone to navle roll up 1 vertebra at a time to T6.&nbsp;Once at top Squeeze Magic Circle x 10&nbsp;Inhale at top, exhale roll down articulating each vertebra till set up position is reached.</p>\r\n<p><br></p>\r\n<p><strong>NOTE &nbsp;Be sure not to roll into spine extension. Sink the sternum lift the Pubic Bone.&nbsp;</strong></p>\r\n<p><strong>Use the light spring setting for more hamstring connection, heavy spring for focus on spine articulation.&nbsp;</strong></p>	1 RED 	Pelvic Curl Magic Circle Sqeezes.jpg		2018-04-09 02:30:00.13+00	2018-09-01 01:42:26.058+00	1
145	Jump Heel Beats	<p><u><strong>Set Up&nbsp;</strong></u></p>\r\n<p>Supine. Feet in wide parallel on jump board. Arms by sides. Head rest comfortable or in a chest lift.&nbsp;</p>\r\n<p><br></p>\r\n<p><u><strong>The Exercise</strong></u></p>\r\n<p>Feet in wide parallel. Inhale bend knees. Exhale jump beat heels together toes pointed, land wide V&nbsp;</p>\r\n<p><br></p>\r\n<p><em><strong>NOTE You may choose Jump with chest lift&nbsp;</strong></em></p>\r\n<p><em><strong>Curl head neck shoulders into chest lift. Inhale bend knees. Exhale jump. Place soft ball under upper thoracic if jumping in chest lift for extended&nbsp;</strong></em></p>	2 RED + or 1 BLUE 	\N		2018-04-03 06:33:07.119+00	2018-04-18 13:18:47.724+00	1
359	Hands in Straps Single Arm Triceps 	<p><u><strong>Set up</strong></u></p>\r\n<p>Supine. Single hand in strap. Spine neutral. Legs table top. Head rest comfortable. If the core is not strong enough lumbar spine can imprint otherwise neutral pelvis. Hands reachingdown along body.&nbsp;</p>\r\n<p><br></p>\r\n<p><u><strong>The Exercise</strong></u></p>\r\n<p>Inhale bend elbows to 90/90. Exhale press back to set up.&nbsp;Feel as though both hands are in staps.&nbsp;</p>\r\n<p><br></p>\r\n<p><em><strong>NOTE Come into chest lift if client is able to maintaion good neck stability, shoulder alignment and core control.&nbsp;</strong></em></p>	1 RED 1 BLUE 	Hands in Straps Triceps.jpg		2018-04-13 03:47:57.676+00	2018-04-19 08:49:58.28+00	1
439	Kneeling Arm Press with Blue Ball	<p><u><strong>Set Up&nbsp;</strong></u></p>\r\n<p>Knneing on carriage. Hands on top of jump board on Blue Ball . Hips at 90/90.</p>\r\n<p><br></p>\r\n<p><u><strong>The Exercise&nbsp;</strong></u></p>\r\n<p>Inhale flex elbows into arm press. Exhale extend elbows.&nbsp;</p>\r\n<p><br></p>\r\n<p><em><strong>NOTE; Keep chest low and hips at 90/90</strong></em></p>	1 RED	Kneeling Arm Press with Blue Ball.jpg		2018-09-02 03:33:41.372+00	2018-09-02 03:36:51.878+00	2
155	Short Box 4 Point Kneeing External Rotation	<p><u><strong>Set Up</strong></u></p>\r\n<p>Short Box on carriage. Elbows on box single knee bent on carriage, single leg on jump board. Leg externally rotated from hip.&nbsp;</p>\r\n<p><br></p>\r\n<p><u><strong>The Exercise&nbsp;</strong></u></p>\r\n<p>Exhale press the foot into jump board to extend the knee inhave flex the knee. Keep elbow plank 90/90.&nbsp;</p>\r\n<p><br></p>\r\n<p><em><strong>NOTE; Be mindful that the torso and elbos remain in place the action comes from the glutes and the knee</strong></em>.&nbsp;</p>	1 RED 1 BLUE or 1 BLUE 	\N		2018-04-03 11:20:08.347+00	2018-04-18 13:18:47.724+00	1
163	Booty Ball Squeeze	<p><u><strong>Set Up</strong></u></p>\r\n<p>Standing holding on to edge of jump board or wall. Hold ball between calf and hamstring. Gently squeezing.&nbsp;</p>\r\n<p><br></p>\r\n<p><u><strong>The Exercise</strong></u></p>\r\n<p>Press heel towards sitbone squeezing ball.&nbsp;</p>	MAT	\N		2018-04-04 12:25:59.153+00	2018-04-18 13:18:47.724+00	1
153	Kneeling Arm Series Bicep Curl 	<p><u><strong>Set up</strong></u></p>\r\n<p>Kneeling facing shoulder rests.Wrap toes around bottom of carriage. Spine and pelvis neutral. Holing hand straps&nbsp;or knots. elbows straight hands in line with shoulders. &nbsp;</p>\r\n<p><br></p>\r\n<p><u><strong>The Exercise&nbsp;</strong></u></p>\r\n<p>Exhale draw hands closer to shoulders flexing elbows into a bicep curl. Inhale return arms to start.&nbsp;Lower elbows if there is neck tension otherwise be mindful to keep elbows in line with shoulders.&nbsp;</p>\r\n<p><br></p>\r\n<p><em><strong>NOTE Bet mindful of losing balance with heavier springs. To regress sit on a Long Box.&nbsp;</strong></em></p>	1 BLUE 1 RED or 1 RED 	Kneeling Arm Series Bicep Curl .jpg		2018-04-03 10:57:39.977+00	2018-04-19 09:07:20.189+00	2
168	Roll Back with Strap 	<p><u><strong>Set Up</strong></u>&nbsp;</p>\r\n<p>Seated on mat diagonally next to Reformer knees bent feet flat on the ground. Holding onto strap closest to you &nbsp;at knot.&nbsp;</p>\r\n<p><br></p>\r\n<p><u><strong>The Exercise</strong></u></p>\r\n<p>Inhale prepare feel sitbones on the floor. Exhale intitate roll back with a lumbur imprint roll back one vertebra at a time until sacrum is in contact with the mat. Stop just before T6/T7&nbsp;</p>\r\n<p><br></p>\r\n<p><em><strong>NOTE; Use the strap to help deepen articulation of the spine as rolling down.&nbsp;</strong></em></p>	1 BLUE	\N		2018-04-04 13:10:17.458+00	2018-04-18 13:18:47.724+00	1
169	Half Curl with Strap 	<p><u><strong>Set Up</strong></u>&nbsp;</p>\r\n<p>Seated on mat diagonally next to Reformer knees bent feet flat on the ground. Holding onto strap closest to you &nbsp;at knot.Inhale prepare feel sitbones on the floor. Exhale intitate roll back with a lumbur imprint roll back one vertebra at a time until sacrum is in contact with the mat. &nbsp;</p>\r\n<p><br></p>\r\n<p><u><strong>The Exercise</strong></u></p>\r\n<p>Inhale prepare exhale deepen core connection and curl up half way. Keep the sacrum anchored and deepen the thoracic curl. Inhale roll back. Repeat.&nbsp;</p>\r\n<p><br></p>\r\n<p><em><strong>NOTE; Use the strap to help deepen articulation of the spine as rolling down.&nbsp;</strong></em></p>	1 BLUE 	\N		2018-04-04 13:14:26.819+00	2018-04-18 13:18:47.724+00	1
180	Scapular Dips 	<p><u><strong>Set Up</strong></u>&nbsp;</p>\r\n<p>Press Back into scooter position. Hand closest to Reformer on high footbar. Other hand holing weight. Lean body forward.&nbsp;</p>\r\n<p><br></p>\r\n<p><u><strong>The Exercise&nbsp;</strong></u></p>\r\n<p>Let the weight of the hand weight drag the arm forward protracting the shoulder. Scapular gluides around. Exhale activate core retract scapular. Repeate.&nbsp;</p>\r\n<p><br></p>\r\n<p><em><strong>NOTE; Use what ever weight it appropriate.&nbsp;</strong></em></p>	1 RED or 2 RED	\N		2018-04-05 10:42:20.543+00	2018-04-18 13:18:47.724+00	1
426	Teaser Release	<p><u><strong>Set up</strong></u></p>\r\n<p>After Teaser</p>\r\n<p><br></p>\r\n<p><u><strong>The exercise</strong></u></p>\r\n<p>Release out of Teaser over the box in extension for a full release.&nbsp;</p>\r\n<p><br></p>\r\n<p><u><strong>TEACHING TIP</strong></u><em><strong>; Release after Teaser.&nbsp;</strong></em></p>		Teaser Release.jpg		2018-04-19 09:59:03.714+00	2018-04-19 10:00:36.391+00	1
181	Squat to Shoulder Press 	<p><u><strong>Set Up</strong></u></p>\r\n<p>Weights optional. Standing with feet wide. Holding weights at shoulders.&nbsp;</p>\r\n<p><br></p>\r\n<p><u><strong>The Exercise</strong></u></p>\r\n<p>Inhale squat, flexing the knees and hips to lower your body. Pause for a brief moment at the bottom exhale returning to a standing position by extending the hips and knees press the weights overhead activate glutes. Return the weights to the shoulder before repeating the entire movement. Do as many as possible in 30 secons for 3 sets or specify number of squats.&nbsp;</p>\r\n<p><br></p>\r\n<p><em><strong>NOTE; If advanced add jump into shoulder press.&nbsp;</strong></em></p>	MAT 	\N		2018-04-05 10:47:33.016+00	2018-04-18 13:18:47.724+00	1
94	Reverse Abdominals Single Leg	<p><u><strong>Set up</strong></u></p>\r\n<p>Kneeling single leg on carriage knee fist distance from shoulder rests. other leg reaching back. Hands on frames wrists under shoulders. Round Back.&nbsp;</p>\r\n<p><br></p>\r\n<p><u><strong>The exercise</strong></u></p>\r\n<p>Inhale to prepare. Exhale press shin into carriage to pull carriage towards wrists. Inhale return to start position.</p>\r\n<p><br></p>\r\n<p><em><strong>NOTE Pull from abdominals and lats not upper traps. Keep shoulders drawing away from ears.&nbsp;</strong></em></p>	1 BLUE 	Reverse Abdominals Single Leg.jpg		2018-03-31 10:43:29.727+00	2018-04-19 10:26:36.892+00	1
191	Thera Band Hamstring Stretch 	<p><u><strong>Set Up&nbsp;</strong></u></p>\r\n<p>Supine on carriage. Head rest comfortable. Single leg pressed into footbar or jump board. Thera Band around heel of other leg.&nbsp;</p>\r\n<p><br></p>\r\n<p><u><strong>The Exercise&nbsp;</strong></u></p>\r\n<p>The legs come into an L shape. Draw the stretching leg towards chest. Keep knees as straight as possible.&nbsp;</p>\r\n<p><br></p>\r\n<p><em><strong>NOTE: Be mindful not to let the pelvis tuck under.&nbsp;</strong></em></p>	1 RED 	\N		2018-04-05 11:54:17.652+00	2018-04-18 13:18:47.724+00	1
194	Standing Quad Stretch 	<p><u><strong>Set Up&nbsp;</strong></u></p>\r\n<p>Standing on single leg, holding other ankle or foot against bottom.&nbsp;</p>\r\n<p><br></p>\r\n<p><u><strong>The Exercise&nbsp;</strong></u></p>\r\n<p>Pull ankle towards sit bone stretching the quads.&nbsp;</p>\r\n<p><br></p>\r\n<p><em><strong>NOTE; Hold onto jump board or wall if needed.&nbsp;</strong></em></p>	MAT 	\N		2018-04-05 12:07:49.382+00	2018-04-18 13:18:47.724+00	1
108	Inverted V 	<p><u><strong>Set up</strong></u></p>\r\n<p>Heels on shoulder rests toes on carriage in “high heel” position. Hands shoulder distance apart on foot bar.</p>\r\n<p><br></p>\r\n<p><u><strong>The exercise</strong></u></p>\r\n<p>Press into extended plank position. Exhale lift hips to inverted V. Inhale return to extended plank. Shoulders maintain position.</p>	1 RED 1 BLUE 	Inverted V.jpg		2018-04-01 05:44:31.203+00	2018-04-19 10:30:49.079+00	1
208	Plank Side Arm Press 	<p><u><strong>Set Up&nbsp;</strong></u></p>\r\n<p>Plank position. Feet on floor one hand on carriage other hand on foot plate. Lean shoulder against jump board if needed.&nbsp;</p>\r\n<p><br></p>\r\n<p><u><strong>The Exercise</strong></u></p>\r\n<p>Exhale abduct (press out) carriage arm. Inhale return.&nbsp;10 each side of Reformer.&nbsp;</p>\r\n<p><br></p>\r\n<p><em><strong>NOTE; Maintain strong plank position.&nbsp;</strong></em></p>	1 BLUE + 	\N		2018-04-06 14:08:08.967+00	2018-04-18 13:18:47.724+00	1
209	Single Leg Squats 	<p><u><strong>Set Up</strong></u>&nbsp;</p>\r\n<p>Standing to the side of Reformer back to Reformer. Single foot on carriage. Both legs parallel.&nbsp;</p>\r\n<p><br></p>\r\n<p><u><strong>The Exercise&nbsp;</strong></u></p>\r\n<p>Inhale prepare. Exhale single leg squat. Knee stays over or behind ankle never in front while squatting. 10 each side.</p>\r\n<p><br></p>\r\n<p><em><strong>NOTE; Make sure carriage is sprung.</strong></em></p>	MAT 	\N		2018-04-06 14:14:31.862+00	2018-04-18 13:18:47.724+00	1
427	Down Stretch 	<p><u><strong>Set Up&nbsp;</strong></u></p>\r\n<p>Kneeling on carriage, hands on foot bar. Lift chest untill in between arms. Pull carriage all the way into stopper.</p>\r\n<p><br></p>\r\n<p><u><strong>The Exercise</strong></u></p>\r\n<p>Inhale press into footbar and push thighs towards springs as the carriage moves back. Maintain spine extension.Exhale return to set up.&nbsp;</p>\r\n<p><br></p>\r\n<p><u><strong>TEACHING TIP;</strong></u><em><strong> Use controlled spine extension. Don't hinge in lumbar spine.&nbsp;</strong></em></p>	1 RED 1 BLUE	Down Stretch.jpg		2018-04-19 10:43:47.143+00	2018-06-15 00:48:37.005+00	2
224	Single Leg Ups 	<p><u><strong>Set Up&nbsp;</strong></u></p>\r\n<p>Lying on Mat. Single leg reaching up to ceiling. Legs in L shape. Holing single weight reaching up to ceiling.&nbsp;</p>\r\n<p><br></p>\r\n<p><u><strong>The Exercise&nbsp;</strong></u></p>\r\n<p>Exhale reach hands up to wards ankle of leg pointing to celing. Pulse x 10. Change sides.&nbsp;</p>	MAT 	\N		2018-04-07 13:15:15.482+00	2018-04-18 13:18:47.724+00	1
129	Jump Chest Lift 	<p><u><strong>Set Up&nbsp;</strong></u></p>\r\n<p>Supine. Feet in any of the foot work positions on jump board. Hands interlaced behind head.&nbsp;</p>\r\n<p><br></p>\r\n<p><u><strong>The Exercise</strong></u></p>\r\n<p>Exhale jump come into a chest lift. Inhale bend knees exhale jump.&nbsp;</p>\r\n<p><br></p>\r\n<p><br></p>	1 BLUE 	Jump Chest Lift.jpg		2018-04-02 00:25:46.88+00	2018-07-01 22:24:08.97+00	1
340	Pelvic Curl Bent Knee Fall Out	<p><u><strong>Set up</strong></u></p>\r\n<p>Supine. Heels on foot bar. Spine neutral. Arms by sides. Head rest down.&nbsp;</p>\r\n<p><br></p>\r\n<p><u><strong>The Exercise</strong></u></p>\r\n<p>Inhale to prepare. Exhale roll up into a pelvic curl moving through imprint, curl tail bone to pubic bone, pubic bone to navle roll up 1 vertebra at a time to T6. Hold at top Inhale right hip externally rotates taking knee to side keeping both heels on the footbar Exhale bring knee back to center. Alternate legs x 10.&nbsp;</p>\r\n<p>Pelvis should stay neutral and stable. &nbsp;</p>\r\n<p>Inhale at top, exhale roll down articulating each vertebra till set up position is reached.</p>\r\n<p><br></p>\r\n<p><strong>NOTE;&nbsp;Be sure not to roll into spine extension. Sink the sternum lift the Pubic Bone.&nbsp;</strong></p>\r\n<p><strong>Use the light spring setting for more hamstring connection, heavy spring for focus on spine articulation.&nbsp;</strong>&nbsp;</p>\r\n<p><br></p>	1 RED 1 BLUE	Pelvic Curl Bent Knee Fall Out.JPG		2018-04-10 12:45:34.577+00	2018-07-09 12:01:54.926+00	3
132	Jump Side Lying Single Top Leg 	<p><u><strong>Set Up&nbsp;</strong></u></p>\r\n<p>Side lying on carriage head resting on underneath arm outstretched or propped up on elbow.&nbsp;</p>\r\n<p><br></p>\r\n<p><u><strong>The Exercise&nbsp;</strong></u></p>\r\n<p>Top leg on jump board bottom leg bent. &nbsp;Neutral pelvis. Inhale bend knee. Exhale extend knee to jump</p>\r\n<p><br></p>	1 BLUE 	Jump Side Lying Single Top Leg.jpg		2018-04-02 01:04:22.019+00	2018-08-28 13:49:04.931+00	1
133	Jump Side Lying Bottom Leg	<p><u><strong>Set Up&nbsp;</strong></u></p>\r\n<p>Side lying on carriage head resting on underneath arm outstretched or propped up on elbow.&nbsp;</p>\r\n<p><br></p>\r\n<p><u><strong>The Exercise&nbsp;</strong></u></p>\r\n<p>Bottom leg on jump board top leg bent. &nbsp;Neutral pelvis. Inhale bend knee. Exhale extend knee to jump</p>	1 BLUE 	Jump Side Lying Single Top Leg.jpg		2018-04-02 01:05:09.919+00	2018-08-28 13:51:12.029+00	1
134	Jump Side Lying Switches 	<p><u><strong>Set Up&nbsp;</strong></u></p>\r\n<p>Side lying on carriage head resting on underneath arm outstretched or propped up on elbow.&nbsp;</p>\r\n<p><br></p>\r\n<p><u><strong>The Exercise&nbsp;</strong></u></p>\r\n<p>Top leg on jump board bottom leg bent. &nbsp;Neutral pelvis. Inhale bend knee. Exhale jump and switch legs.&nbsp;</p>	1 BLUE 	Jump Side Lying Switches.jpg		2018-04-02 01:07:21.099+00	2018-08-28 13:52:11.065+00	1
267	Hands in Straps with Blue Ball Triceps 	<p><u><strong>Set up</strong></u></p>\r\n<p>Supine. Blue Ball under sacrum. Hands in straps by sides of body at 90 degree angle at elbows. Legs table top. Head rest comfortable. Engage abdominals by imprinting lumbar spine.&nbsp;</p>\r\n<p><br></p>\r\n<p><u><strong>The Exercise</strong></u></p>\r\n<p>Inhale to prepare. Exhale press the hands down to sides extending elbows. Inhale return x 2. Reach right leg long keeping left leg at table top continue pressing arms up and down x 4. switch legs x 4.</p>\r\n<p><br></p>\r\n<p><em><strong>NOTE; Advanced both legs reaching straight to point of control.&nbsp;</strong></em></p>	1 RED 1 BLUE or 2 RED 	Hands in Straps with blue ball Triceps.jpg		2018-04-08 14:19:40.229+00	2018-07-03 12:15:05.406+00	3
266	Hands in Straps with Blue Ball Sides 	<p><u><strong>Set up</strong></u></p>\r\n<p>Supine. Blue Ball under sacrum. Hands in straps T shape. Legs table top. Head rest comfortable. Engage abdominals by imprinting lumbar spine.&nbsp;</p>\r\n<p><br></p>\r\n<p><u><strong>The Exercise</strong></u></p>\r\n<p>Inhale to prepare. Exhale press the hands to sides Inhale return x 2. Reach right leg long keeping left leg at table top continue pressing arms up and down x 4. switch legs x 4.</p>\r\n<p><br></p>\r\n<p><em><strong>NOTE; Advanced both legs reaching straight to point of control.&nbsp;</strong></em></p>	1 RED 1 BLUE or 2 RED 	Hands in Straps with blue ball Sides.jpg		2018-04-08 14:17:52.366+00	2018-07-03 12:15:15.429+00	2
248	Elbows in Straps Circles	<p><u><strong>Set up</strong></u></p>\r\n<p>Supine. Elbows in straps (big loops) hands pressing up on knots. Spine neutral. Legs table top. Head rest comfortable. If the core is not strong enough lumbar spine can imprint otherwise neutral pelvis. Elbows pointing towards ceiling.&nbsp;</p>\r\n<p><br></p>\r\n<p><u><strong>The Exercise</strong></u>&nbsp;</p>\r\n<p>Inhale prepare exhale pull elbows down towards ribs and circle out to the side inhale elbows return to ceiling. Alternate directions.&nbsp;</p>	3 RED 	Elbows in Straps.jpg		2018-04-08 12:06:30.379+00	2018-09-01 09:38:59.931+00	1
247	Elbows in Straps Sides	<p><u><strong>Set up</strong></u></p>\r\n<p>Supine. Elbows in straps (big loops) hands pressing up on knots. Spine neutral. Legs table top. Head rest comfortable. If the core is not strong enough lumbar spine can imprint otherwise neutral pelvis. Elbows pointing wide arms in goal post position.&nbsp;</p>\r\n<p><br></p>\r\n<p><u><strong>The Exercise</strong></u>&nbsp;</p>\r\n<p>Inhale prepare exhale pull elbows down towards sides of ribs inhale elbows return to set up.&nbsp;</p>	3 RED	Elbows in Straps.jpg		2018-04-08 12:05:15.498+00	2018-09-01 09:39:14.468+00	1
257	Long Stretch Tricep Dip 	<p><u><strong>Set up</strong></u></p>\r\n<p>Heels on shoulder rests toes on carriage in “high heel” position. Hands shoulder distance apart on foot bar.&nbsp;</p>\r\n<p><br></p>\r\n<p><u><strong>Exercise&nbsp;</strong></u></p>\r\n<p>Press into extended plank. Exhale bring shoulders over wrists. Bend Elbows into Tricep push up. Inhale return to extended plank. Hips maintain position.&nbsp;</p>\r\n<p><br></p>\r\n<p><em><strong>NOTE; Modification bring knees down to carriage.</strong></em>&nbsp;</p>	1 RED 1 BLUE 	Long Stretch Tricep Dip.jpg		2018-04-08 13:29:36.171+00	2018-06-30 12:20:37.298+00	1
259	Reverse Plank Inverted V 	<p><u><strong>Set Up</strong></u>&nbsp;</p>\r\n<p>Standing on footplate. Bring elbos to just infront of shoulder rests interlace hands and rest on head rest. Shoulders over elbows. Press into elbow plank.&nbsp;</p>\r\n<p><br></p>\r\n<p><u><strong>The Exercise</strong></u></p>\r\n<p>Inhale prepare. Exhale lift hips to ceiling into inverted V. Inhale return to set up. Repeat.&nbsp;</p>	1 RED 	Reverse Plank Invereted V.jpg		2018-04-08 13:44:12.193+00	2018-09-01 01:43:05.074+00	1
409	Pelvic Curl Blue 	<p><u><strong>Set up</strong></u></p>\r\n<p>Supine. Heels or toes on foot bar. Spine neutral. Arms by sides. Head rest down.&nbsp;</p>\r\n<p><br></p>\r\n<p><u><strong>The exercise</strong></u></p>\r\n<p>Inhale to prepare. Exhale move through imprint, curl tail bone to pubic bone, pubic bone to navle roll up 1 vertebra at a time to T6. Inhale at top, exhale roll down articulating each vertebra till set up position is reached.</p>\r\n<p><br></p>\r\n<p><strong>TEACHING TIP; Squeeze greator trocantor (clients know these at hip bones, or out side of thighs) together to activat glutes. &nbsp;Be sure not to roll into spine extension. Sink the sternum lift the Pubic Bone.&nbsp;If client has a hamstring cramp stretch it out and try again. It is in the Supine legs category in hope to warm up legs first to prevant cramping.</strong></p>	1 BLUE 	Pelvic Curl Blue.jpg		2018-04-17 22:35:26.286+00	2018-09-01 02:04:27.114+00	2
72	Kneeling Shoulder Press Single Arm 	<p><u><strong>Set up</strong></u></p>\r\n<p>Active child’s pose. SIng hands on Foot bar closer to center. Elbows down or wide.&nbsp;</p>\r\n<p><br></p>\r\n<p><u><strong>The exercise</strong></u></p>\r\n<p>Inhale to prepare. Exhale draw core away from thighs press hand into Foot bar to extend elbow.&nbsp;</p>\r\n<p><br></p>\r\n<p><em><strong>NOTE Press other hand into bed to counter ballance the shoulders.&nbsp;</strong></em></p>	1 BLUE or 1 RED +	Kneeling Shoulder Press Single Arm.jpg		2018-03-29 01:32:45+00	2018-04-19 09:26:27.103+00	1
31	Hands in Straps Up Down 	<p><u><strong>Set up</strong></u></p>\r\n<p>Supine. Hands in straps. Spine neutral. Legs table top. Head rest comfortable. If the core is not strong enough lumbar spine can imprint otherwise neutral pelvis. Hands reaching to ceiling.</p>\r\n<p><br></p>\r\n<p><u><strong>The exercise</strong></u></p>\r\n<p>Inhale to prepare. Exhale press the hands down to sides Inhale return. Maintain set up position while disassociating the shoulders.&nbsp;</p>\r\n<p><br></p>\r\n<p><em><strong>NOTE Come into chest lift if client is able to maintaion good neck stability, shoulder alignment and core control.&nbsp;</strong></em></p>	1 RED, 1 BLUE or 2 RED decrease springs if there is neck tension. 	Hands in StrapsUp Down.jpg		2018-03-22 14:14:57+00	2018-06-30 11:16:43.252+00	3
64	Stomach Massage Flat Back 	<p><u><strong>Set up</strong></u></p>\r\n<p>Sitting on the bottom edge of carriage. Toes in V on foot bar. &nbsp;</p>\r\n<p><br></p>\r\n<p><u><strong>The Exercise&nbsp;</strong></u></p>\r\n<p>Lengthen spine into active neutral, or as close as possible. Reach arm diagonally up. Exhale deepen core connection press toes into foot bar to extend the knees. Inhale return to start.&nbsp;</p>	1 RED + 	Stomach Massage Flat Back.jpg		2018-03-27 18:23:51+00	2018-08-26 08:47:43.766+00	2
428	Hands in Straps Triceps 	<p><u><strong>Set up</strong></u></p>\r\n<p>Supine.Legs table top. Hands in straps by sides of body at 90 degree angle at elbows. Head rest comfortable. Engage abdominals by imprinting lumbar spine if needed, otherwise neutral.</p>\r\n<p><br></p>\r\n<p><u><strong>The Exercise</strong></u></p>\r\n<p>Inhale to prepare. Exhale press the hands down to sides extending elbows. Inhale return to 90 degrees.</p>\r\n<p><br></p>\r\n<p><em><strong>NOTE Come into chest lift if client is able to maintaion good neck stability, shoulder alignment and core control.&nbsp;</strong></em></p>	1 RED 1 BLUE 	Hands in Straps Triceps.jpg		2018-06-29 02:24:24.38+00	2018-06-29 04:40:50.629+00	4
281	Phoenix Lunge 	<p><u><strong>Set Up&nbsp;</strong></u></p>\r\n<p>Standing on<strong> right </strong>side of Reformer holding strap with <strong>left </strong>arm. Diagonally face pulleys. Lunge <strong>right</strong> leg back <strong>left</strong> arm is straight.&nbsp;</p>\r\n<p><br></p>\r\n<p><u><strong>The Exercise&nbsp;</strong></u></p>\r\n<p>Exhale pull strap towards hip elbow pressing back simultaneously lean onto <strong>left</strong> leg and knee drive <strong>right</strong> leg forward. Inhale return to lunge and straight arm.&nbsp;</p>\r\n<p><br></p>\r\n<p><em><strong>NOTE; Repeat other side or continue with Phoenix Lunge Series and then repeat.&nbsp;</strong></em></p>	1 YELLOW or 1 BLUE or 1 RED 	\N		2018-04-09 02:02:13.933+00	2018-04-18 13:18:47.724+00	1
282	Phoenix Lunge Pulses	<p><u><strong>Set Up&nbsp;</strong></u></p>\r\n<p>Standing on<strong> right </strong>side of Reformer holding strap with <strong>left </strong>arm. Diagonally face pulleys. Lunge <strong>right</strong> leg back <strong>left</strong> arm is straight.&nbsp;</p>\r\n<p><br></p>\r\n<p><u><strong>The Exercise&nbsp;</strong></u></p>\r\n<p>Exhale pull strap towards hip elbow pressing back. Stay in lunge and pulse down x 10</p>\r\n<p><br></p>\r\n<p><em><strong>NOTE; Repeat other side or continue with Phoenix Lunge Series and then repeat.&nbsp;</strong></em></p>	1 YELLOW 1 BLUE 1 RED 	\N		2018-04-09 02:04:03.603+00	2018-04-18 13:18:47.724+00	1
429	Step Up's with Straps	<p><strong>Set Up&nbsp;</strong></p>\r\n<p>Short Box at pullie end of carriage. Holding onto straps standing on ground behind box.</p>\r\n<p><br></p>\r\n<p><strong>The Exercise</strong></p>\r\n<p>Exhale step up single leg onto box sitmutaniously pulling straps, elbows bend fists to hips. Inhale lower leg to tap toe on ground letting straps pull arms forward. Repeate 10x switch sides for 10x&nbsp;</p>\r\n<p><br></p>\r\n<p><em><strong>Teaching Tip; Can incorporate knee pulses. &nbsp;</strong></em></p>\r\n<p><br></p>	2 RED 	Step Ups with Straps.JPG		2018-06-29 04:23:01.767+00	2018-07-09 12:15:25.086+00	1
291	Hands in Straps Magic Circle Straight Leg Stretch	<p><u><strong>Set up</strong></u></p>\r\n<p>Supine. Magic Circle in hands and hands in straps. Spine neutral. Legs table top. Head rest comfortable. If the core is not strong enough lumbar spine can imprint otherwise neutral pelvis.&nbsp;</p>\r\n<p><br></p>\r\n<p><u><strong>The Exercise</strong></u></p>\r\n<p>Inhale prepare. Exhale come into chest lift pressing arms towards knees as legs extend straight. Inhale return to set up.&nbsp;</p>\r\n<p><br></p>\r\n<p><em><strong>NOTE; Modify to single leg stretch if core isnt strong enough.&nbsp;</strong></em></p>	 1 RED 1 BLUE or 2 RED	\N		2018-04-09 02:48:34.351+00	2018-04-18 13:18:47.724+00	1
284	Standing Squat Rows	<p><u><strong>Set Up</strong></u></p>\r\n<p>Standing over carriage in wide squar hips in external rotation. Deep squat so sit bones are almost touching carriage. Ropes crossed and holding knots or straps.</p>\r\n<p><br></p>\r\n<p><u><strong>The Exercise</strong></u></p>\r\n<p>Exhale row arms back keeping elbows close to body drawing scapular together. Inhale release. x 10&nbsp;</p>\r\n<p>Pulse squats x 10&nbsp;</p>\r\n<p><br></p>\r\n<p><em><strong>NOTE; To modify change spring tension.&nbsp;</strong></em></p>	1 RED 1 BLUE 	Standing Squat Rows copy.jpg		2018-04-09 02:17:02.142+00	2018-06-30 00:59:58.169+00	1
301	Matadore 2 	<p><u><strong>Set up</strong></u></p>\r\n<p>Standing on ground side facing away from carriage. Knee closest to foot bar against shoulder rest other foot on mat on ball of foot in a calf rise gentle bend in knee. Arms crossed at front at shoulder hight or holding Magic Circle&nbsp;</p>\r\n<p><br></p>\r\n<p><u><strong>The exercise</strong></u></p>\r\n<p>Inhale to prepare. Exhale press foot into ground and knee into shoulder. Adduct knee to centre line.&nbsp;</p>	1 BLUE 	\N		2018-04-09 03:44:15.613+00	2018-04-18 13:18:47.724+00	1
303	Saw	<p><u><strong>Set Up&nbsp;</strong></u></p>\r\n<p>Seated on center of carriage feet against sides of foot bar. Spine long arms reaching to sides.&nbsp;</p>\r\n<p><br></p>\r\n<p><u><strong>The Exercise&nbsp;</strong></u></p>\r\n<p>Exhale rotate shoulders arms and thoracic spine to left. Inhale keeping equal pressure on sit bones pelvis square and equal pressure in feet. Exhale reach right pinky finger to left pinky tie (sawing it off) spine comes into rotation and forward flextion head looks back towards left hand. Inhale de-rotate back to set up.&nbsp;</p>\r\n<p><br></p>\r\n<p><em><strong>NOTE; Scoop belly away from thighs.&nbsp;</strong></em></p>	1 RED 	\N		2018-04-09 03:59:06.777+00	2018-04-18 13:18:47.724+00	1
304	Saw Press Back 	<p><u><strong>Set Up&nbsp;</strong></u></p>\r\n<p>Seated on center of carriage feet against sides of foot bar. Spine long arms reaching back to shoulder rests.&nbsp;</p>\r\n<p><br></p>\r\n<p><u><strong>The Exercise&nbsp;</strong></u></p>\r\n<p>Inhale prepare. Exhale press hands into shoulder rests roll prelvis off carriage lifting hips into air extending shoulders back. Inhale return to set up. Repeat.&nbsp;</p>	1 RED 	\N		2018-04-09 04:02:29.161+00	2018-04-18 13:18:47.724+00	1
302	Scooter Light 	<p><u><strong>Set up</strong></u></p>\r\n<p>Standing next to carriage one foot on ground in a calf rise other heel against shoulder rest. Knees bent. Pelvis aligned. Hands reaching forward.&nbsp;</p>\r\n<p><br></p>\r\n<p><u><strong>The exercise</strong></u></p>\r\n<p>Inhale to prepare. Exhale press heel into shoulder rest taking the hip into extension. Inhale return.&nbsp;Stay stable on supporting leg.&nbsp;</p>	1 YELLOW 	\N		2018-04-09 03:46:41.991+00	2018-04-18 13:18:47.724+00	1
430	test	<p>this is a test...</p>		Standing Squat Rows.jpg		2018-06-30 06:23:47.464+00	2018-06-30 10:53:50.151+00	1
310	Seated Roll Down 	<p><u><strong>Set Up&nbsp;</strong></u></p>\r\n<p>Sitting stradeling reformer sitbones on Foot Plate. Hands on long box.&nbsp;</p>\r\n<p><br></p>\r\n<p><u><strong>The Exercise</strong></u></p>\r\n<p>Inhale prepare exhale initiate roll down by nodding chin to throat. Begin to press away long box as core connection deepens rolling down one vertebra at a time. Inhale at botton flat back. Exhale roll up initiating movement from low abdominals. &nbsp;</p>	1 YELLOW 1 BLUE 	\N		2018-04-09 14:11:04.392+00	2018-04-18 13:18:47.724+00	1
313	Reverse Stomach Massage Toes	<p><u><strong>Set Up&nbsp;</strong></u></p>\r\n<p>Seated in Foot Plate. Hands on Foot Bar. Toes parrallel on carriage, blue ball between ankles. Spine long.&nbsp;</p>\r\n<p><br></p>\r\n<p><u><strong>The Exercise</strong></u></p>\r\n<p>Exhale press knees straight. Inhale bend.&nbsp;</p>	1 RED 1 BLUE 	\N		2018-04-10 06:33:38.734+00	2018-04-18 13:18:47.724+00	1
37	Abdominal Series 100's	<p><u><strong>Set up</strong></u></p>\r\n<p>Supine. Hands in straps. Spine neutral. Legs table top. Head rest comfortable. If the core is not strong enough lumbar spine can imprint otherwise neutral pelvis. Reach arms to roof.&nbsp;</p>\r\n<p><br></p>\r\n<p><u><strong>The exercise</strong></u></p>\r\n<p>Exhale chest lift. Beat arms down, inhale for 5 beats exhale for 5 beats. Reach straight legs to point of control. The goal is the full 100's position.&nbsp;</p>\r\n<p><br></p>\r\n<p><em><strong>NOTE In the technique class do this in multipals of 20 or 50 untill you reach 100.&nbsp;</strong></em></p>	1 RED, 1 BLUE 	Abdominal Series Double Straight Leg Stretch.jpg		2018-03-25 18:12:30+00	2018-06-30 11:24:28.688+00	1
27	Feet in Straps Circles	<p><u><strong>Set up</strong></u></p>\r\n<p>Supine. Spine and Pelvis Neutral. Feet in Straps at bottom of metatarsal arch. Head rest comfortable. Legs straight at 45 degrees.</p>\r\n<p><br></p>\r\n<p><u><strong>The exercise</strong></u></p>\r\n<p>Inhale lift straight legs to as close to 90 degrees as possible circle legs around to starting point. Alternate direction.&nbsp;</p>\r\n<p><br></p>\r\n<p><em><strong>NOTE Be sure to maintain neutral pelvis as legs move. If the pelvis is moving this is an idication that the core is not engaged correctly. Decrease the range or change the spring settings.&nbsp;</strong></em></p>	1 RED, 1 BLUE or 2 RED or 1 BLUE 	Feet in Straps Circles.jpg		2018-03-22 13:48:53+00	2018-06-30 11:44:09.525+00	1
337	Thigh Stretch 	<p><u><strong>Set Up&nbsp;</strong></u></p>\r\n<p>Kneeling on carriage facing head rest knees hip distance apart. Hands in straps Elbows straight.&nbsp;Straps crossed.&nbsp;</p>\r\n<p><br></p>\r\n<p><u><strong>The Exercise</strong></u></p>\r\n<p>Inhale hinge from knees backwards. Exhale hinge back to starting position. Feel the body as a straight line from knees to croun of head. Drawing ribs together and activating glutes.&nbsp;</p>\r\n<p><br></p>\r\n<p><em><strong>NOTE; Core stays strong throughout.</strong></em>&nbsp;</p>\r\n<p><br></p>\r\n<p><br></p>	3 RED	Thigh Stretch.JPG		2018-04-10 12:12:58.008+00	2018-07-03 13:01:45.613+00	1
235	Box Pike	<p><u><strong>Set Up</strong></u>&nbsp;</p>\r\n<p>Long Box next to reformer at foot bar end. Hands on eather side on box feet against shoulder rest closest to long box. Othside leg ontop clesses at ankle. Plank position.&nbsp;</p>\r\n<p><br></p>\r\n<p><u><strong>The Exercise</strong></u></p>\r\n<p>Inhale prepare, Exhle lift hips towards ceiling bringing head inbetween arms. Inhale return to set up.&nbsp;</p>\r\n<p><br></p>\r\n<p><em><strong>NOTE; Initiate movement for abdominals.&nbsp;</strong></em></p>	1 BLUE or 1 RED 	Box Pike.jpg		2018-04-07 14:09:13.03+00	2018-06-30 12:21:03.141+00	1
352	Footwork Side Lying Parallel	<p><u><strong>Set Up</strong></u></p>\r\n<p>Side Lying on Carriage. Head supported by underneath arm. Top foot on foot bar, parallel entire foot in contact with bar. Bring foot the the front of the bar. Maintain a stacked pelvis a neutral spine.&nbsp;</p>\r\n<p><br></p>\r\n<p><u><strong>The Exercise</strong></u></p>\r\n<p>Exhale press foot, initiate from the heel, into the foot bar and extend knee. Inhale bend. Repeat.&nbsp;</p>\r\n<p><br></p>\r\n<p><em><strong>NOTE; Be sure to maintain neutal spine and pelvis. Client should feel this in glutes, if they feel it in the hip fexors or quads angle pelvis forward and slightly drop knee. otherwise knee is in line with the second big toe.&nbsp;</strong></em></p>	1 RED 1 BLUE or 2 RED 	Footwork Sidelying Paralelle .jpg		2018-04-13 02:09:58.87+00	2018-07-03 12:30:33.216+00	1
347	Standing Demi Rises with Thera Band and Blue and Blue Ball 	<p><u><strong>Set Up&nbsp;</strong></u></p>\r\n<p>Standing<em><strong> knees bent.</strong></em> Feet parallel Blue Ball Between ankles. Holding Thera Band arms straight out front in line with shoulders.</p>\r\n<p><br></p>\r\n<p><u><strong>The Exercise</strong></u></p>\r\n<p>Inhale prepare feel spine long. Exhale rise up onto balls of feet, pulling the Thera Band demi squat. Maintain demi squat. Lift and lower heels.&nbsp;</p>\r\n<p><br></p>\r\n<p><em><strong>NOTE; Maintain tension on Thera Band.&nbsp;</strong></em></p>	MAT	\N		2018-04-13 01:36:16.102+00	2018-04-18 13:18:47.724+00	1
346	Standing Pulses with Thera Band and Blue and Blue Ball 	<p>&nbsp;<u><strong>Set Up&nbsp;</strong></u></p>\r\n<p>Standing. Feet parallel Blue Ball Between ankles. Holding Thera Band arms straight out front in line with shoulders.</p>\r\n<p><br></p>\r\n<p><u><strong>The Exercise</strong></u></p>\r\n<p>Inhale prepare feel spine long. Exhale rise up onto balls of feet, pulling the Thera Band. Manintain rise inhale demi (1/2) squat and pulse deeping into the squat 10 times.</p>\r\n<p><br></p>\r\n<p><em><strong>NOTE; Maintain heel rise thoughout squats. &nbsp; &nbsp;</strong></em></p>\r\n<p><br></p>	MAT	\N		2018-04-13 01:31:40.556+00	2018-04-18 13:18:47.724+00	1
351	Chest Lift Single Leg Reach with Blue ball Knee Hooked	<p>&nbsp;</p>\r\n<p><br></p>	3 RED	\N		2018-04-13 02:00:11.412+00	2018-04-18 13:18:47.724+00	1
354	Footwork Side Lying Internal Rotation	<p><u><strong>Set Up</strong></u></p>\r\n<p>Side Lying on Carriage. Head supported by underneath arm. Toe on foot bar. Hip interally rotated knee angle down. Bring foot the the front of the bar. The pelvis may rotate forward slightly.&nbsp;</p>\r\n<p><br></p>\r\n<p><u><strong>The Exercise</strong></u></p>\r\n<p>Exhale press ball of foot into the foot bar and extend knee. Inhale bend. Repeat.&nbsp;</p>\r\n<p><br></p>\r\n<p><em><strong>NOTE; Be sure to maintain neutal spine and pelvis. Client should feel this in glutes, if they feel it in the hip fexors or quads angle pelvis forward.</strong></em></p>	1 RED 1 BLUE or 2 RED 	Footwork Sidelying Internal Rotation.jpg		2018-04-13 02:15:50.251+00	2018-07-03 12:30:40.334+00	1
391	Star 	<p><u><strong>Set Up</strong></u></p>\r\n<p>Kneeling side facing on carriage. Single arm comes to center of foot bar. Reach top leg straight or keep it bent. Arm beside side.</p>\r\n<p><br></p>\r\n<p><u><strong>The Exercise</strong></u></p>\r\n<p>Push into foot bar arm to press out into a side plank to point of control raising top arm. Exhale draw back to starting position. To make it harder use lighter springs.&nbsp;</p>\r\n<p><br></p>\r\n<p><u><strong>NOTE; Maintain good head neck and shoulder alignment.&nbsp;</strong></u></p>	1 RED or 1 BLUE 	Star.jpg		2018-04-15 13:23:26.417+00	2018-07-03 12:36:54.438+00	2
142	Tricep Dips	<p><u><strong>Set Up</strong></u></p>\r\n<p>Hands on the edge of carriage or Box on the mat elbows straight. Legs bent.</p>\r\n<p><br></p>\r\n<p><u><strong>The Exercise</strong></u><u>&nbsp;</u></p>\r\n<p>Inhave bend elbows into tricep dip keep shoulders drawing away from ears.&nbsp;</p>	MAT	Tricep Dips.jpg		2018-04-03 04:28:06.523+00	2018-07-01 12:32:51.195+00	1
361	Feet in Straps Side Lying Push Back	<p><u><strong>Set Up</strong></u>&nbsp;</p>\r\n<p>Side lying on carriage. HEad resting on arm. Top foot in strap. Long neutral spine. Stacked pelvis. &nbsp;Leg parallel.</p>\r\n<p><br></p>\r\n<p><u><strong>The Exercise</strong></u></p>\r\n<p>Inhale bring straight leg to front of body flexing at the hip. Exhale extend hip to press leg back to 10%- 20% hip extension. Repeat. Keep a small bend in knee to ensure the press comes from the glutes and hamstrings and not the back of the knee.</p>\r\n<p><br></p>\r\n<p><em><strong>NOTE; If neutral spine set up is compromised the spring is too heavy &nbsp;</strong></em></p>	1 RED or1 BLUE 	Feet in Straps Side Lying Push Back.jpg		2018-04-13 04:02:07.614+00	2018-08-29 01:47:54.635+00	1
141	Dead Bugs 	<p><u><strong>Set up</strong></u></p>\r\n<p>Supine. Supine on carriage, mat or a long box on the mat. Legs at table top straight arms reaching to ceiling. Head rest comfortable.&nbsp;</p>\r\n<p><br></p>\r\n<p><u><strong>The Exercise</strong></u></p>\r\n<p>Inhale prepare, exhale reach oppisite arm and leg away from eachother. Maintain neutral spine or imprint. Keeping fingertips and toes in the same plane.&nbsp;</p>\r\n<p><br></p>	2 RED or MAT 	Dead Bugs.jpg		2018-04-02 08:00:12.206+00	2018-07-01 12:34:55.776+00	1
372	Sitting Foot Bar Side Reaches 	<p><u><strong>Set Up&nbsp;</strong></u></p>\r\n<p>Sitting on foot bar balls of feet on carriage edge. Blue Ball in between ankles. Hook sit bones just to front of foot bar.&nbsp;Holding Thera Band above head elblows straight.&nbsp;</p>\r\n<p><br></p>\r\n<p><u><strong>The Exercise&nbsp;</strong></u></p>\r\n<p>Inhale pull on Thera Band and move into lateral flexion to left side, keeping both sit bones in contact with bar. Exhale draw torso back to set up position. Inhale lateral flexion to right.Exhale back to set up.&nbsp;</p>\r\n<p><br></p>\r\n<p><em><strong>NOTE; Keep arms active with tension on Thera Band. Head stays inbetween arms.&nbsp;</strong></em></p>	2 RED	\N		2018-04-13 12:18:21.55+00	2018-04-18 13:18:47.724+00	1
127	Jump Footwork Wide V 	<p><u><strong>Set Up&nbsp;</strong></u></p>\r\n<p>Supine. Feet in wide V on jump board. Arms by sides. Head rest comfortable or in a chest lift.&nbsp;</p>\r\n<p><br></p>\r\n<p><u><strong>The Exercise</strong></u></p>\r\n<p>Feet in widel V. Inhale bend knees. Exhale jump.</p>\r\n<p><br></p>\r\n<p><em><strong>NOTE You may choose Jump with chest lift&nbsp;</strong></em></p>\r\n<p><em><strong>Curl head neck shoulders into chest lift. Inhale bend knees. Exhale jump. Place soft ball under upper thoracic if jumping in chest lift for extended&nbsp;</strong></em></p>	2 RED + or 1 BLUE 	Jump Footwork Wide V.jpg		2018-04-02 00:21:34.3+00	2018-07-01 12:39:46.542+00	1
214	100's Straight Legs on Jump Board	<p><u><strong>Set up</strong></u></p>\r\n<p>Supine. Legs straight feet paralle on center Jump Board.&nbsp;</p>\r\n<p>Lumbar spine can imprint reach arms to roof.&nbsp;</p>\r\n<p><br></p>\r\n<p><u><strong>The exercise</strong></u></p>\r\n<p>Exhale chest lift. Bring arms by sides. Beat arms down, inhale for 5 beats exhale for 5 beats. Feel as though legs are "standing" on jump board.&nbsp;</p>\r\n<p><br></p>\r\n<p><em><strong>NOTE; Holding Magic Circle is optional.&nbsp;</strong></em></p>	2 RED	100's Feet on Jump Board.JPG		2018-04-07 02:14:01.85+00	2018-07-09 12:37:24.005+00	1
384	Feet in Straps Magic Circle Up Down 	<p><u><strong>Set up</strong></u></p>\r\n<p>Supine. Spine and Pelvis Neutral. Feet in Straps at bottom of metatarsal arch Magic Circle between ankles. Head rest comfortable. Legs parallel and straight.&nbsp;</p>\r\n<p><br></p>\r\n<p><u><strong>The Exercise</strong></u></p>\r\n<p>Inhale hips come into flexion to create L shape or as close to as possibble. Exhale press straight legs back dowm towards 45 degrees or past if there is enough core control.&nbsp;Gentle squeeze of Magic Circle thoughout.&nbsp;</p>\r\n<p><br></p>\r\n<p><em><strong>NOTE; Modify to 45 degrees if hamstrings are not long enough.&nbsp;</strong></em></p>	1 RED 1 BULE or 2 RED 	Feet in Straps Magic Circle Up Down.jpg		2018-04-13 20:47:14.153+00	2018-08-28 22:52:30.055+00	1
385	Knee in Strap Side Lying Clams  	<p><u><strong>Set Up&nbsp;</strong></u></p>\r\n<p>Side lying on carriage. Top leg in strap, strap just above knee. Both knees bent heels together. Head supported &nbsp;by underneath arm.&nbsp;</p>\r\n<p><br></p>\r\n<p><u><strong>The Exercise&nbsp;</strong></u></p>\r\n<p>Squeezing heels together. Inhale lift top knee, exhale draw knee back down. Repeat.&nbsp;</p>\r\n<p><br></p>\r\n<p><em><strong>NOTE; Maintain stacked pelvis and neutral side lying spine.</strong></em></p>	1 RED 	\N		2018-04-15 12:59:14.188+00	2018-04-18 13:18:47.724+00	1
20	Footwork VMO 	<p><u><strong>Set up</strong></u></p>\r\n<p>Supine.toes wide on foot bar knees together. Spine neutral. Arms by sides. Head rest comfortable.&nbsp;</p>\r\n<p><br></p>\r\n<p><u><strong>The exercise</strong></u></p>\r\n<p>Inhale to prepare. Exhale press toes into foot bar keeoing knees together and pulse.&nbsp;</p>	3 RED	Footwork VMOpng.png		2018-03-22 00:01:00+00	2018-04-19 08:14:50.761+00	1
23	Footwork Single Legs 	<p><u><strong>Set up</strong></u></p>\r\n<p>Supine. Heel or toe on foot bar. Spine neutral. Arms by sides. Head rest comfortable.&nbsp;Single leg in table top&nbsp;</p>\r\n<p><br></p>\r\n<p><u><strong>The exercise</strong></u></p>\r\n<p>Inhale to prepare. Exhale press heel into foot bar to extend knees. Maintain Neutral Spine. Table top leg can reach under or over the bar.&nbsp;</p>\r\n<p><br></p>\r\n<p><em><strong>NOTE Optional add pulses.&nbsp;</strong></em></p>	3 RED or  2 RED 	Footwork Single Leg .jpg		2018-03-22 00:14:32+00	2018-04-19 08:30:55.71+00	1
57	Kneeling Arm Series Chest Expansion 	<p><u><strong>Set up</strong></u></p>\r\n<p>Kneeling facing shoulder rests.Wrap toes around bottom of carriage. Spine and pelvis neutral. Holing hand straps.&nbsp;</p>\r\n<p>Tension on the straps arms are by the mid side.</p>\r\n<p><br></p>\r\n<p><u><strong>The Exercise&nbsp;</strong></u></p>\r\n<p>Exhale press the arms back into shoulder flexion. HOLD breath in look left right. Inhale return arms to start.&nbsp;</p>\r\n<p><br></p>\r\n<p><em><strong>NOTE Bet mindful of losing balance with heavier springs. To regress sit on a Long Box.&nbsp;</strong></em></p>	1 BLUE or 1 RED +	Kneeling Arm Series Chest Expansion.jpg		2018-03-27 17:35:34+00	2018-04-19 09:05:37.906+00	1
58	Kneeling Arm Series  Egyptian Arms 	<p><u><strong>Set up</strong></u></p>\r\n<p>Kneeling facing shoulder rests.Wrap toes around bottom of carriage. Spine and pelvis neutral. Foot or hand straps around elbows.&nbsp;</p>\r\n<p><br></p>\r\n<p><u><strong>The Exercise</strong></u></p>\r\n<p>Straps on elbows arms at shoulder level shoulder distance apart elbows 90 degrees. Exhale press elbows back to goal post position. Inhale return to start position connect core on return.&nbsp;</p>\r\n<p><br></p>	1 RED +	Kneeling Arm Series Egyptian Arms.jpg		2018-03-27 17:38:33+00	2018-04-19 09:08:07.287+00	1
206	Jump Single Leg Combo 	<p><u><strong>Set up</strong></u></p>\r\n<p>Supine. Feet parallel on jump board. Arms by sides. Head rest comfortable.&nbsp; Or hands interlaced behind head in a chest lift.&nbsp;</p>\r\n<p><br></p>\r\n<p><u><strong>The exercise</strong></u></p>\r\n<p>Single leg table top parallel exhale jump switch legs mid air externally rotate single leg switch mid air.</p>\r\n<p><br></p>\r\n<p><em><strong>NOTE; In external rotation bring the toe to the jumping legs knee.&nbsp;</strong></em></p>	1 BLUE 1 RED or 2 RED + 	Jump Footwork Single Leg combo.jpg		2018-04-06 13:54:39.811+00	2018-07-01 12:58:04.572+00	1
34	Kneeling Rowing Combo	<p><u><strong>Set Up&nbsp;</strong></u></p>\r\n<p>Kneeling on carriage facing head rest knees hip distance apart. Hands in straps.&nbsp;Straps crossed.&nbsp;</p>\r\n<p><br></p>\r\n<p><u><strong>The Exercise&nbsp;</strong></u></p>\r\n<p>Pulling straps into row, elbows wide, release back pull elbows into row elbows close to body. Repeat.&nbsp;</p>	2 RED	Kneeling Rowing Combo.JPG		2018-03-22 23:28:11+00	2018-07-03 13:02:20.172+00	1
56	Kneeling Arm Series Rotation Pull 	<p><u><strong>Set up</strong></u></p>\r\n<p>Kneeling facing shoulder rests.Wrap toes around bottom of carriage. Spine and pelvis neutral. Holing hand straps or knots.&nbsp;</p>\r\n<p><br></p>\r\n<p><u><strong>The Exercise&nbsp;</strong></u></p>\r\n<p>Exhale rotate towards left side as the elbow bends to pull strap. Inhale return. Repete on left side&nbsp;</p>\r\n<p><br></p>\r\n<p><em><strong>NOTE Bet mindful of losing balance with heavier springs. To regress sit on a Long Box.&nbsp;</strong></em></p>	1 RED 1 BLUE or 1 RED	Kneeling Arm Sereies Rotation Pull .JPG		2018-03-27 17:18:43+00	2018-09-01 05:04:16.6+00	1
215	Step Up's Knee Drive 	<p><u><strong>Set Up</strong></u></p>\r\n<p>Press Long Box against the frame of reformer on mat.&nbsp;Hand weights optional.</p>\r\n<p><br></p>\r\n<p><u><strong>The Exercise</strong></u></p>\r\n<p>Step up onto box, drive knee forward, step off box. &nbsp;</p>\r\n<p><br></p>\r\n<p><em><strong>NOTE; Make sure box is pressed up against the reformer to ensure the box doesn't slip.&nbsp;</strong></em></p>	MAT 	Step Up's Knee Drive.jpg		2018-04-07 02:14:44.056+00	2018-07-03 10:04:55.367+00	1
399	Chest Lift with Magic Circle 	<p><u><strong>Set Up&nbsp;</strong></u></p>\r\n<p>Lying supine on carriage or mat knees bent on foot bar, mat or top of jump board. Hands interlaced behind head.&nbsp;You can also lye supine on Long Box. Magic Circle between knees.&nbsp;</p>\r\n<p><br></p>\r\n<p><u><strong>The Exercise&nbsp;</strong></u></p>\r\n<p>Inhale prepare. Exhale lift head neck and shoulders into chest lift.&nbsp;Squeeze magic circle with adductors at the same time.&nbsp;</p>\r\n<p><br></p>\r\n<p><em><strong>NOTE Stay in chest lift and add single leg lifts, double leg lowers.&nbsp;</strong></em></p>	1 RED or MAT 	Chest Lift with Magic Circle.jpg		2018-04-15 23:51:06.656+00	2018-09-01 01:40:20.616+00	1
4	Neutral Spine 	<p><u><strong>Set up</strong></u></p>\r\n<p>Supine. Heels on foot bar. &nbsp;Arms by sides. Head rest comfortable.</p>\r\n<p><br></p>\r\n<p><u><strong>The exercise</strong></u><u>&nbsp;</u></p>\r\n<p>Feel spine long, allow the natural curves of the spine to be present. The ASIS and Pubic Bone align. Release low ribs, widen the collar bones. Exhale connect core without changing spine and pelvic alignment.&nbsp;</p>\r\n<p><br></p>\r\n<p><em><strong>NOTE This can be done on the mat or the reformer.&nbsp;</strong></em></p>	3 RED 	Neutral Spine.jpg		2018-03-21 18:57:33+00	2018-04-18 21:52:22.4+00	1
187	Jump Mermaid Arms Flat Back 	<p><u><strong>Set Up&nbsp;</strong></u></p>\r\n<p>Z sit on carriage facing sidewards. Hand on jump board other out stretched in line with shoulder. Flat back.&nbsp;</p>\r\n<p><br></p>\r\n<p><u><strong>The exercise</strong></u></p>\r\n<p>Inhale to prepare. Exhale press hand into jump board and jump. Maintain set up position though out.&nbsp;</p>	1 YELLOW or 1 BLUE 	Jump Mermaid Arms Flat Back.jpg		2018-04-05 11:05:54.824+00	2018-07-03 11:15:58.662+00	1
7	Single Leg Lifts 	<p><u><strong>Set up</strong></u></p>\r\n<p>Supine. Supine. Heels on lowered foot bar, mat or a long box on the mat. Arms by sides. Head rest comfortable.&nbsp;</p>\r\n<p><br></p>\r\n<p><u><strong>The exercise</strong></u></p>\r\n<p>Exhale connect to core lift single leg to table top maintain neutral spine. Inhale lower leg. Alternate legs.&nbsp;</p>	3 RED or 1 BLUE  or MAT 	Single Leg Lifts.jpg		2018-03-21 19:13:13+00	2018-04-18 23:03:52.571+00	1
5	Imprint 	<p><u><strong>Set up</strong></u></p>\r\n<p>Supine. Heels on foot bar. Spine neutral. Arms by sides. Head rest comfortable.&nbsp;</p>\r\n<p><br></p>\r\n<p><u><strong>The exercise</strong></u><u><strong> &nbsp;</strong></u></p>\r\n<p>Inhale neutral spine and pelvis. Exhale imprint lumbar spine into the mat.&nbsp;</p>\r\n<p><br></p>\r\n<p><em><strong>NOTE Can be done on the </strong></em><em><strong>mat</strong></em><em><strong> or </strong></em><em><strong>reformer</strong></em></p>	3 RED or 1 BLUE 	imprint.jpg		2018-03-21 19:02:09+00	2018-04-19 00:40:19.033+00	1
15	Footwork Toes Parallel	<p><u><strong>Set up</strong></u></p>\r\n<p>Supine. Toes on foot bar. Spine neutral. Arms by sides. Head rest comfortable.&nbsp;</p>\r\n<p><br></p>\r\n<p><u><strong>The exercise</strong></u></p>\r\n<p>Inhale to prepare. Exhale press toes into foot bar to extend knees. Maintain Neutral Spine.&nbsp;</p>\r\n<p><br></p>\r\n<p><em><strong>NOTE Optional add pulses.&nbsp;</strong></em></p>	3 RED +	Footwork Toes.jpg		2018-03-21 23:31:42+00	2018-04-19 08:14:11.539+00	1
39	Abdominal Series Scissors 	<p><u><strong>Set up</strong></u></p>\r\n<p>Supine. Hands in straps. Spine neutral. Legs table top. Head rest comfortable. If the core is not strong enough lumbar spine can imprint otherwise neutral pelvis. Reach arms to roof.&nbsp;</p>\r\n<p><br></p>\r\n<p><u><strong>The exercise&nbsp;</strong></u></p>\r\n<p>Exhale chest left extend straight legs to L shape switch legs through scissors. Stay in chest lift.&nbsp;</p>	1 RED, 1 BLUE	Abdominal Series Scissors.jpg		2018-03-25 18:19:44+00	2018-04-19 08:18:18.133+00	1
54	Kneeling Arm Side Series Draw a Sword 	<p><u><strong>Set up</strong></u></p>\r\n<p>Kneeling towards the side of carriage. Knees pelvis distance apart. Spine and pelvis neutral. Strap in hand closest to foot bar.&nbsp;</p>\r\n<p><br></p>\r\n<p><u><strong>The Exercise&nbsp;</strong></u></p>\r\n<p>&nbsp;Strap in hand closest to foot bar. Fist at opposite hip “draw the sword” Diagonally up across chest untill elbow is extended.&nbsp;</p>\r\n<p><br></p>\r\n<p><em><strong>NOTE Variation add rotation. Can sit on Long Box&nbsp;</strong></em></p>	1 BLUE or 1 RED+	Kneeling Arm Side Series Draw a Sword.jpg		2018-03-27 17:07:58+00	2018-04-19 09:02:30.403+00	1
61	Kneeling Arm Series Hug a Tree	<p><u><strong>Set up</strong></u></p>\r\n<p>Kneeling facing foot bar. Toes against shoulder rests. Spine and pelvis neutral. Hands in straps elbows slightly flexed shoulder distance apart (1st position)</p>\r\n<p><br></p>\r\n<p><u><strong>The Excersise</strong></u></p>\r\n<p>Inhale open arms out to side finger tips stay infront of shoulders 2nd position. Exhale return to 1st position.&nbsp;</p>\r\n<p><br></p>\r\n<p><em><strong>NOTE Sit on Long Box for variation.&nbsp;</strong></em></p>	1 BLUE or 1 RED 	Kneeling Arm Series Hug a Tree.jpg		2018-03-27 17:56:25+00	2018-04-19 09:10:47.003+00	1
70	Kneeling Shoulder Press Elbows Down 	<p><u><strong>Set up</strong></u></p>\r\n<p>Active child’s pose. Hands on Foot bar. Elbows down, fingertips to celiling.&nbsp;</p>\r\n<p><br></p>\r\n<p><u><strong>The exercise</strong></u></p>\r\n<p>Inhale to prepare. Exhale draw core away from thighs press hands into Foot bar to extend elbows into tricep press.&nbsp;</p>\r\n<p><br></p>\r\n<p><em><strong>NOTE Regression is to lye on a Long Box&nbsp;</strong></em></p>	1 RED 	Kneeling Shoulder Press Elbows Down.jpg		2018-03-29 01:25:46+00	2018-04-19 09:24:33.985+00	1
63	Stomach Massage Round back 	<p><u><strong>Set up</strong></u></p>\r\n<p>Sitting on the bottom edge of carriage. Toes in V on foot bar. &nbsp;</p>\r\n<p><br></p>\r\n<p><u><strong>The Exercise</strong></u></p>\r\n<p>Forward flexion C curve of the spine. Holding bottom of carriage. Inhale prepare. Exhale deepen core connection press toes into foot bar to extend the knees. Inhale return to start.&nbsp;</p>	1 RED +	Stomach Massage Round back.jpg		2018-03-27 18:11:16+00	2018-04-19 09:15:37.003+00	2
69	Mermaid with Rotation and Extension 	<p><u><strong>Set Up&nbsp;</strong></u></p>\r\n<p>Z sit on carriage facing sidewards. Hand on Foot bar forward of the centre of bar. Other arm outstretched.&nbsp;</p>\r\n<p><br></p>\r\n<p><u><strong>The Exercise</strong></u></p>\r\n<p>Inhale to prepare. Exhale press hand into Foot bar as out stretched arm arcs up and over. Spine comes into lateral flexion bring hand to foot bar and go into spine rotation and extension. Inhale into top lung. Exhale return to starting position.&nbsp;</p>	1 RED 	Mermaid with Rotation and Extension.jpg		2018-03-29 01:20:14+00	2018-04-19 09:22:56.326+00	1
71	Kneeling Shoulder Press Elbows Wide 	<p><u><strong>Set up</strong></u></p>\r\n<p>Active child’s pose. Hands wide on Foot bar. Elbows wide, fingertips to eachother.&nbsp;</p>\r\n<p><br></p>\r\n<p><u><strong>The exercise</strong></u></p>\r\n<p>Inhale to prepare. Exhale draw core away from thighs press hands into Foot bar to extend elbows.</p>\r\n<p><br></p>\r\n<p><em><strong>NOTE Regression is to lye on a Long Box&nbsp;</strong></em></p>	1 RED 	Kneeling Shoulder Press Elbows Wide.jpg		2018-03-29 01:30:14+00	2018-04-19 09:25:29.005+00	1
75	Rowing Back Series Round Back 	<p><u><strong>Set up</strong></u></p>\r\n<p>Sitting tall on carriage legs long through shoulder rests.</p>\r\n<p>&nbsp;</p>\r\n<p><u><strong>The exercise</strong></u></p>\r\n<p>Elbows wide fists together at heart.&nbsp;</p>\r\n<p>Inhale to prepare. Exhale roll back into long C curve. Inhale press arms out to side palms back. Exhale press hands together at back as head comes towards needs. Roll arms around to “dead swan” Stack spine back up to starting position.&nbsp;</p>	1 RED 	Rowing Back Series Round Back.jpg		2018-03-29 01:46:25+00	2018-04-19 09:33:43.829+00	1
186	Jump Mermaid Arms	<p><u><strong>Set Up&nbsp;</strong></u></p>\r\n<p>Z sit on carriage facing sidewards. Hand on jump board other hand over head. Bring torso into lateral flexion.</p>\r\n<p><br></p>\r\n<p><u><strong>The exercise</strong></u></p>\r\n<p>Inhale to prepare. Exhale press hand into jump board and jump. Maintain set up position though out.&nbsp;</p>\r\n<p><br></p>\r\n<p><br></p>	1 YELLOW  or 1 BLUE 	Jump Mermaid Arms.jpg		2018-04-05 11:04:30.575+00	2018-07-03 11:16:07.487+00	1
19	Jump Side Lying Bottom Leg Kick Up 	<p><u><strong>Set Up&nbsp;</strong></u></p>\r\n<p>Side lying on carriage head resting on underneath arm outstretched or propped up on elbow.&nbsp;Top Leg high center on jump board. Bottom leg low or sightly bent and off.&nbsp;</p>\r\n<p><br></p>\r\n<p><u><strong>The Exercise&nbsp;</strong></u></p>\r\n<p>Inhale prepare, exhale jump in mid air adduct bottom leg to "kick up" to top leg. Land repeat.</p>	1 BLUE	\N		2018-03-21 23:38:03+00	2018-04-18 13:18:47.724+00	1
25	Elbows in Straps Up Down 	<p><u><strong>Set up</strong></u></p>\r\n<p>Supine. Elbows in straps (big loops) hands pressing up on knots. Spine neutral. Legs table top. Head rest comfortable. If the core is not strong enough lumbar spine can imprint otherwise neutral pelvis. Elbows pointing towards ceiling.&nbsp;</p>\r\n<p><br></p>\r\n<p><u><strong>The Exercise</strong></u>&nbsp;</p>\r\n<p>Inhale prepare exhale pull elbows down towards ribs inhale elbows return to ceiling.</p>	3 RED 	\N		2018-03-22 00:41:29+00	2018-04-18 13:18:47.724+00	1
13	Pelvic Curl Press Single Leg	<p><u><strong>Set up</strong></u></p>\r\n<p>Supine. Heels on foot bar. Spine neutral. Arms by sides. Head rest down.&nbsp;one leg at table top.&nbsp;</p>\r\n<p><br></p>\r\n<p><u><strong>The exercise</strong></u></p>\r\n<p>Inhale to prepare. Exhale curl up into top of Pelvic Curl with single leg at table top. Press out and draw in.&nbsp;</p>\r\n<p><br></p>\r\n<p><strong>NOTE &nbsp;Be sure not to roll into spine extension. Sink the sternum lift the Pubic Bone.&nbsp;</strong></p>\r\n<p><strong>Use the light spring setting for more hamstring connection, heavy spring for focus on spine articulation.</strong>&nbsp;</p>	1 RED or 2 RED or 1 BLUE 	\N		2018-03-21 23:19:03+00	2018-04-18 13:18:47.724+00	1
36	Chest Lift Single Leg Reach with Blue ball Knee Hooked	<p><u><strong>Set Up&nbsp;</strong></u></p>\r\n<p>Supine on carriage, wriggle body as far down on carriage as possible. Blue Ball under upper thoracic. Hands interlaced behind head in chest lift position. Knees hooked over foot bar pulling heels towards sitbones.&nbsp;Reach single leg to table top&nbsp;</p>\r\n<p><br></p>\r\n<p><u><strong>The Exercise&nbsp;</strong></u></p>\r\n<p>Lift head neck and shoulders into chest lift.&nbsp;Exhale reach single leg away inhale return to table top. Retpeate x10 then swap legs.&nbsp;</p>\r\n<p><br></p>\r\n<p><em><strong>NOTE; Keep elbows in peripheral vision maintain chest lift.</strong></em>&nbsp;</p>\r\n<p><br></p>	3 RED	\N		2018-03-23 14:00:50+00	2018-04-18 13:18:47.724+00	1
12	Pelvic Curl Press 	<p><em><strong>Set up</strong></em></p>\r\n<p>Supine. Heels on foot bar. Spine neutral. Arms by sides. Head rest down.&nbsp;</p>\r\n<p><br></p>\r\n<p><em><strong>The Exercise</strong></em></p>\r\n<p>Inhale to prepare. Exhale curl up into top of Pelvic Curl. Press carriage out and draw in.&nbsp;</p>\r\n<p><br></p>\r\n<p><em><strong>TEACHING TIP; </strong></em><strong>&nbsp;Be sure not to roll into spine extension. Sink the sternum lift the Pubic Bone.&nbsp;</strong></p>\r\n<p><strong>Use the light spring setting for more hamstring connection, heavy spring for focus on spine articulation</strong>.&nbsp;</p>	1 RED or 2 RED or 1 BLUE 	Pelvic Curl Press.jpg		2018-03-21 23:12:52+00	2018-04-19 01:09:38.154+00	1
14	Footwork Heels Parallel 	<p><u><strong>Set up</strong></u></p>\r\n<p>Supine. Heels on foot bar. Spine neutral. Arms by sides. Head rest comfortable.&nbsp;</p>\r\n<p><br></p>\r\n<p><u><strong>The exercise</strong></u></p>\r\n<p>Inhale to prepare. Exhale press heels into foot bar to extend knees. Maintain Neutral Spine.&nbsp;</p>\r\n<p><br></p>\r\n<p><em><strong>NOTE Optional add pulses.&nbsp;</strong></em></p>	3 RED +	Footwork Heels.jpg		2018-03-21 23:26:21+00	2018-04-19 08:14:05.157+00	1
17	Footwork Heels Wide 	<p><u><strong>Set up</strong></u></p>\r\n<p>Supine. Heels wide on foot bar. Spine neutral. Arms by sides. Head rest comfortable.&nbsp;</p>\r\n<p><br></p>\r\n<p><u><strong>The exercise</strong></u></p>\r\n<p>Inhale to prepare. Exhale press heels into foot bar to extend knees. Maintain Neutral Spine.&nbsp;</p>\r\n<p><br></p>\r\n<p><em><strong>NOTE Optional add pulses.&nbsp;</strong></em></p>	3 RED +	Footwork Heels Wide.png		2018-03-21 23:35:07+00	2018-04-19 08:15:56.256+00	1
18	Footwork Toes Wide 	<p><u><strong>Set up</strong></u></p>\r\n<p>Supine. Toes wide on foot bar. Spine neutral. Arms by sides. Head rest comfortable.&nbsp;</p>\r\n<p><br></p>\r\n<p><u><strong>The exercise</strong></u></p>\r\n<p>Inhale to prepare. Exhale press toes into foot bar to extend knees. Maintain Neutral Spine.&nbsp;</p>\r\n<p><br></p>\r\n<p><strong>NOTE </strong><em><strong>Optional add pulses.&nbsp;</strong></em></p>	3 RED +	Footwork Toes Wide.jpg		2018-03-21 23:36:17+00	2018-04-19 08:28:35.303+00	1
32	Hands in Straps Sides 	<p><u><strong>Set up</strong></u></p>\r\n<p>Supine. Hands in straps. Spine neutral. Legs table top. Head rest comfortable. If the core is not strong enough lumbar spine can imprint otherwise neutral pelvis. Hands reaching to the sides.</p>\r\n<p><br></p>\r\n<p><u><strong>The exercise</strong></u></p>\r\n<p>Inhale to prepare. Exhale press the hands towards side of the body.&nbsp;</p>\r\n<p><br></p>\r\n<p><em><strong>NOTE Come into chest lift if client is able to maintaion good neck stability, shoulder alignment and core control.&nbsp;</strong></em></p>	1 RED, 1 BLUE or 2 RED decrease springs if there is neck tension. 	Hands in Straps Sides.jpg		2018-03-22 17:21:48+00	2018-04-19 08:39:40.753+00	1
41	Abdominal Series Double Bent Leg Stretch 	<p><u><strong>Set up</strong></u></p>\r\n<p>Supine. Hands in straps. Spine neutral. Legs table top. If the core is not strong enough lumbar spine can imprint otherwise neutral pelvis. Reach arms to roof.&nbsp;</p>\r\n<p><br></p>\r\n<p><u><strong>The exercise&nbsp;</strong></u></p>\r\n<p>Exhale chest lift reach both legs away from body until straight. Inhale return to table top. Maintain Chest Lift.&nbsp;</p>\r\n<p><br></p>\r\n<p><em><strong>NOTE only go to " point of control "</strong></em></p>	1 RED, 1 BLUE 	Abdominal series Double Bent Leg Stretch.jpg		2018-03-25 18:33:49+00	2018-06-30 11:24:15.207+00	1
51	Kneeling Arm Side Series Side Lift	<p><u><em><strong>Set up</strong></em></u></p>\r\n<p>Kneeling towards the side of carriage. Knees pelvis distance apart. Spine and pelvis neutral. Holing hand strap.</p>\r\n<p><br></p>\r\n<p><u><em><strong>The exercise</strong></em></u></p>\r\n<p>Strap in hand closest to shoulder rest. Shoulder and elbow 90/90. Chest broad. Exhale lift hand up towards roof adducting shoulder. Imagine sliding back of hand up a wall.</p>\r\n<p><br></p>\r\n<p><em><strong>NOTE for beginners let them sit on a long box&nbsp;</strong></em></p>	1 BLUE 	Kneeling Arm Side Series Side Lift.jpg		2018-03-25 20:58:52+00	2018-04-19 09:00:38.457+00	2
30	Feet in Straps Open Close 	<p><u><strong>Set up</strong></u></p>\r\n<p>Supine. Spine and Pelvis Neutral. Feet in Straps at bottom of metatarsal arch. Head rest comfortable. Legs straight at &nbsp;45 degrees.</p>\r\n<p><br></p>\r\n<p><u><strong>The exercise</strong></u></p>\r\n<p>Inhale open both straight legs to the side exhale bring back together. Keep hips externally rotated. Can be samll or big.&nbsp;</p>\r\n<p><br></p>\r\n<p><em><strong>NOTE Be sure to maintain neutral pelvis as legs move. If the pelvis is moving this is an idication that the core is not engaged correctly. Decrease the range or change the spring settings.&nbsp;</strong></em></p>	1 RED, 1 BLUE or 2 RED or 1 BLUE 	\N		2018-03-22 14:07:29+00	2018-04-18 13:18:47.724+00	1
29	Feet in Straps Peter Pan 	<p><u><strong>Set up</strong></u></p>\r\n<p>Supine. Spine and Pelvis Neutral. Feet in Straps at bottom of metatarsal arch. Head rest comfortable. Legs straight 45 degrees small V</p>\r\n<p><br></p>\r\n<p><u><strong>The exercise</strong></u></p>\r\n<p>Take one leg to the side, bend the other knee to the stag possition. Keep equal tension on both straps.&nbsp;</p>\r\n<p><br></p>\r\n<p><em><strong>NOTE Be sure to maintain neutral pelvis as legs move. If the pelvis is moving this is an idication that the core is not engaged correctly. Decrease the range or change the spring settings.&nbsp;</strong></em></p>	1 RED, 1 BLUE or 2 RED, or 1 BLUE 	\N		2018-03-22 14:04:25+00	2018-04-18 13:18:47.724+00	1
28	Feet In Straps Walking On The Ceiling. 	<p><u><strong>Set up</strong></u></p>\r\n<p>Supine. Spine and Pelvis Neutral. Feet in Straps at bottom of metatarsal arch. Head rest comfortable. Legs straight 45 degrees.</p>\r\n<p><br></p>\r\n<p><u><strong>The exercise</strong></u></p>\r\n<p>Send one straight leg to as close to 90 degrees at hip as possible bend the other knee. Maintain tension on both straps.&nbsp;</p>\r\n<p><br></p>\r\n<p><em><strong>NOTE Be sure to maintain neutral pelvis as legs move. If the pelvis is moving this is an idication that the core is not engaged correctly. Decrease the range or change the spring settings.&nbsp;</strong></em></p>	1 RED, 1 BLUE or 2 RED or 1 BLUE 	\N		2018-03-22 14:00:21+00	2018-04-18 13:18:47.724+00	1
44	Long Spine Prep 	<p><u><strong>Set up</strong></u></p>\r\n<p>Supine. Feet in straps. HEAD REST DOWN. Heels together toes apart.&nbsp;</p>\r\n<p><br></p>\r\n<p><u><strong>The exercise</strong></u></p>\r\n<p>Come to L shape with legs. Exhale pelvic tilt bringing feet directly up above pelvis. Keep carriage still. Inhale feet to hip distance apart. Exhale keeping carriage still roll back down to L shape when pelvis reaches neutral circle legs back to start.</p>\r\n<p><br></p>\r\n<p><em><strong>NOTE Only do this if you know the people in your class and their limits.&nbsp;</strong></em></p>	1 RED, 1 BLUE or 2 RED 	\N		2018-03-25 18:48:48+00	2018-04-18 13:18:47.724+00	1
49	Series 5 Double Straight Leg Stretch 	<p><u><em><strong>Set up</strong></em></u></p>\r\n<p>Supine. Table top legs. Hands interlaced behind head at occipital ridge. Elbows in peripheral vision.&nbsp;</p>\r\n<p><br></p>\r\n<p><u><em><strong>The exercise</strong></em></u><u>&nbsp;</u></p>\r\n<p>Hands interlaced behind head. Both legs extended creating L shape. Exhale lower legs to point of control. Inhale return.</p>\r\n<p><br></p>\r\n<p><em><strong>NOTE Do this on the long box or mat</strong></em></p>	MAT	Series 5 Double Straight Leg Stretch .jpg		2018-03-25 19:27:01+00	2018-04-18 22:56:00.149+00	1
47	Series 5 Double Bent Leg Stretch 	<p><u><strong>Set up</strong></u></p>\r\n<p>Supine. Table top legs. Hands interlaced behind head at occipital ridge. Elbows in peripheral vision.&nbsp;</p>\r\n<p><br></p>\r\n<p><u><strong>The exercise</strong></u></p>\r\n<p>Pull both knees towards chest stretch arms and legs out on exhale circles arms around and pull knees back in.</p>\r\n<p><br></p>\r\n<p><em><strong>NOTE Do this on MAT or Long Box</strong></em></p>	MAT	Series 5 Double Bent Leg Stretch.jpg		2018-03-25 19:10:51+00	2018-04-18 22:56:04.475+00	1
46	Series 5 Single Bent Leg Stretch 	<p><u><strong>Set up</strong></u></p>\r\n<p>Supine. Table top legs. Hands interlaced behind head at occipital ridge. Elbows in peripheral vision.&nbsp;</p>\r\n<p><br></p>\r\n<p><u><strong>The Excercise&nbsp;</strong></u></p>\r\n<p>Holding one leg at table top the other reached out straight. Hands on table top knee. Exhale switch. Keep toes in same plane.&nbsp;</p>\r\n<p><br></p>\r\n<p><em><strong>NOTE Do this on Mat or Long Box</strong></em></p>	MAT	Series 5 Single Bent Leg Stretch.jpg		2018-03-25 19:08:36+00	2018-04-18 22:56:16.702+00	1
43	Short Spine	<p><u><strong>Set up</strong></u></p>\r\n<p>Supine. Feet in straps. HEAD REST DOWN. Heels together toes apart.&nbsp;</p>\r\n<p><br></p>\r\n<p><u><strong>The exercise</strong></u></p>\r\n<p>Exhale with straight legs take feet above pubic bone. L shape. Roll up through spine to to scapular, allow the carriage to move, feet over above head. Inhale bend knees. Exhale roll spine back down bringing heel with pubic bone. Inhale lengthen legs away.&nbsp;</p>\r\n<p><br></p>\r\n<p><em><strong>NOTE Only do this if you know the people in your class and their limits.&nbsp;</strong></em></p>	1 RED, 1 BLUE or 2 RED	Short Spine.jpg		2018-03-25 18:46:05+00	2018-04-19 08:25:36.657+00	1
45	Long Spine 	<p><u><strong>Set Up&nbsp;</strong></u></p>\r\n<p>Supine. Feet in straps. HEAD REST DOWN. Legs together parallel.</p>\r\n<p><br></p>\r\n<p><u><strong>The exercise</strong></u></p>\r\n<p>Come to L shape with legs. Exhale Roll through the spine to Scapular bringing feet directly above pelvis. Keep carriage still. Inhale feet to hip distance apart. Exhale keeping carriage still roll back down to L shape when pelvis reaches neutral circle legs back to start.</p>	1 RED, 1 BLUE or 2 RED 	Long Spine.png		2018-03-25 19:04:57+00	2018-04-19 08:26:49.328+00	1
42	Abdominal Series Double Straight Leg Stretch 	<p><u><strong>Set up</strong></u></p>\r\n<p>Supine. Hands in straps. Spine neutral. Legs table top. If the core is not strong enough lumbar spine can imprint otherwise neutral pelvis. Reach arms to roof.&nbsp;</p>\r\n<p><br></p>\r\n<p><u><strong>The exercise&nbsp;</strong></u></p>\r\n<p>Exhale chest lift. Inhale reach both legs towards ceiling as close to L shape as possible. Exhale lower both legs to point of control. Inhale return legs to L shape. Maintain Chest Lift.&nbsp;</p>\r\n<p><br></p>\r\n<p><em><strong>NOTE only go to 'point of control"</strong></em></p>	1 RED, 1 BLUE 	Abdominal Series Double Straight Leg Stretch.jpg		2018-03-25 18:36:44+00	2018-06-30 11:21:18.616+00	1
116	Standing Side Splits Abduction Adduction 	<p><u><strong>Set up</strong></u></p>\r\n<p>Standing on foot plate FIRST. Other foot at centre bottom of carriage. Feet aligned.&nbsp;</p>\r\n<p><br></p>\r\n<p><u><strong>The exercise</strong></u></p>\r\n<p>Standing tall legs straight. Inhale Abduct legs Exhale Adduct Legs.</p>	1 RED + or 1 BLUE 	\N		2018-04-01 11:13:20.866+00	2018-04-18 13:18:47.724+00	1
73	Kneeling Shoulder Press Straight Arm Spine Extension 	<p><u><strong>Set up</strong></u></p>\r\n<p>Active child’s pose. Hands on Foot bar. Elbows down, fingertips to celiling.&nbsp;</p>\r\n<p><u><strong>The exercise</strong></u></p>\r\n<p>Inhale to prepare. Exhale draw core away from thighs press hands into Foot bar to extend elbows. Inhale come into spine extension maintaing straight elbows. Exhale return to starting position.&nbsp;</p>\r\n<p><br></p>\r\n<p><em><strong>NOTE Regression is to lye on a Long Box&nbsp;</strong></em></p>	1 RED 	\N		2018-03-29 01:36:42+00	2018-04-18 13:18:47.724+00	1
40	Abdominal Series Single Bent Leg Stretch 	<p><u><strong>Set up</strong></u></p>\r\n<p>Supine. Hands in straps. Spine neutral. Legs table top. If the core is not strong enough lumbar spine can imprint otherwise neutral pelvis. Reach arms to roof.&nbsp;</p>\r\n<p><br></p>\r\n<p><u><strong>The exercise&nbsp;</strong></u></p>\r\n<p>Exhale chest lift reach single leg away from body. Alternate legs. Keep toes in the same plane.</p>\r\n<p><br></p>\r\n<p><em><strong>NOTE Keep pelvis stable.&nbsp;</strong></em></p>	1 RED, 1 BLUE 	Abdominal Series Single Bent Leg Stretch.png		2018-03-25 18:33:00+00	2018-04-19 08:24:45.197+00	1
59	Kneeling Arm Series Serving 	<p><u><strong>Set up</strong></u></p>\r\n<p>Kneeling facing foot bar. Toes against shoulder rests. Spine and pelvis neutral. Holing hand straps. Elbos bent as though holding a tray.&nbsp;</p>\r\n<p><br></p>\r\n<p><u><strong>The excersise&nbsp;</strong></u></p>\r\n<p>Exhale press hands forward extending elbows keeping the tray level. Inhale return to start.&nbsp;</p>\r\n<p><br></p>\r\n<p><em><strong>NOTE &nbsp;Variation Exhale press hands forward extending elbows and continue into shoulder extension “offering” the tray. Inhale return to start.&nbsp;</strong></em></p>	1 BLUE or 1 RED +	Kneeling Arm Series Serving.jpg		2018-03-27 17:49:05+00	2018-04-19 09:09:57.789+00	1
67	Mermaid	<p><u><strong>Set Up&nbsp;</strong></u></p>\r\n<p>Z sit on carriage facing sidewards. Hand on Foot bar forward of the centre of bar. Other arm outstretched.&nbsp;</p>\r\n<p>&nbsp;</p>\r\n<p><u><strong>The exercise</strong></u></p>\r\n<p>Inhale to prepare. Exhale press hand into Foot bar as out stretched arm arcs up and over. Spine comes into lateral flexion. Inhale into top lung. Exhale return to starting position.&nbsp;</p>	1 RED 	Mermaid.jpg		2018-03-27 18:42:00+00	2018-04-19 09:20:43.76+00	1
77	Rowing Back Series Serving 	<p><u><strong>Set up</strong></u></p>\r\n<p>Seated tall facing foot bar. Knees extended.&nbsp;</p>\r\n<p><br></p>\r\n<p><u><strong>The Exercise</strong></u></p>\r\n<p>Elbows at 90° by waist. Inhale to prepare. Exhale press hands forward extending elbows spine comes into spine stretch forward. Inhale tun palms to face down and lift up to flat back exhale return through sine stretch to start.&nbsp;</p>	1 RED 	Rowing Back Series Serving.jpg		2018-03-30 11:21:39.031+00	2018-04-19 09:37:38.254+00	1
76	Rowing Back Series Flat Back	<p><u><strong>Set up</strong></u></p>\r\n<p>Sitting tall on carriage legs long through shoulder rests.</p>\r\n<p><br></p>\r\n<p><u><strong>The Exercise&nbsp;</strong></u></p>\r\n<p>Arms at 90/90. Hinge at hips maintaining flat back to a point of control. Exhale extend elbows and reach hands above head. Inhale returners to 90/90. Repeat&nbsp;</p>	1 RED 	Rowing Back Series Flat Back.jpg		2018-03-29 01:49:55+00	2018-04-19 09:36:18.832+00	2
78	Rowing Back Series Feed the Birds 	<p><u><strong>Set up</strong></u></p>\r\n<p>Seated tall facing foot bar. Knees extended.&nbsp;</p>\r\n<p><br></p>\r\n<p><u><strong>The Exercise&nbsp;</strong></u></p>\r\n<p>Hands pressing into carriage. Exhale slide hands forward palms down through spine stretch all the way up to L position. Inhale circle arms around back to start position.</p>	1 RED 	Rowing Back Series Feed the Birds.jpg		2018-03-30 11:25:53.348+00	2018-04-19 09:38:33.119+00	1
79	Green Room Arms Rolling Back 	<p><u><strong>Set up</strong></u></p>\r\n<p>Sitting at bottom edge of carriage. Knees bent. Feet on Head Rest. Holding straps in bicep curl. Elbows level with shoulders. Sitting tall. &nbsp;</p>\r\n<p><br></p>\r\n<p><u><strong>The Excercise&nbsp;</strong></u></p>\r\n<p>Inhale to prepare. Exhale roll back into C curve until Sacrum is in contact with carriage. Inhale extend elbows. Exhale gentle bicep curl x10. Exhale roll back up to start position.&nbsp;</p>	1 BLUE 	Green Room Arms Rolling Back.jpg		2018-03-30 11:30:22.085+00	2018-04-19 10:03:50.226+00	1
117	Standing Sides Splits Skiing 	<p><u><strong>Set up</strong></u></p>\r\n<p>Standing on foot plate FIRST. Other foot at centre bottom of carriage. Feet aligned.&nbsp;</p>\r\n<p><br></p>\r\n<p><u><strong>The exercise</strong></u></p>\r\n<p>Bend both knees. As the foot on the platform presses the knee extends as the carriage returns the knee comes back into flexion.</p>	1 RED + or 1 BLUE 	Standing Sides Splits Skiing.jpg		2018-04-01 11:18:30.853+00	2018-04-19 10:48:01.641+00	1
26	Feet in Straps  Up Down 	<p><u><strong>Set up</strong></u></p>\r\n<p>Supine. Spine and Pelvis Neutral. Feet in Straps at bottom of metatarsal arch. Head rest comfortable. &nbsp;Feet Parallel legs straight. Start at 45 degrees.</p>\r\n<p><br></p>\r\n<p><u><strong>The exercise</strong></u></p>\r\n<p>Inhale lift straight legs to as close to 90 degrees at hips while maintaining neutral spine. Exhale press straight legs down.&nbsp;</p>\r\n<p><br></p>\r\n<p><em><strong>NOTE Be sure to maintain neutral pelvis as legs move. If the pelvis is moving this is an idication that the core is not engaged correctly. Decrease the range or change the spring settings.&nbsp;</strong></em></p>	1 RED, 1 BLUE OR 2 RED, OR 1 BLUE 	Feet in Straps Up Down.jpg		2018-03-22 00:43:49+00	2018-06-30 11:36:09.016+00	1
52	Kneeling Arm Side Series RTC  	<p><u><em><strong>Set up</strong></em></u></p>\r\n<p>Kneeling towards the side of carriage. Knees pelvis distance apart. Spine and pelvis neutral. Holing hand strap.</p>\r\n<p><br></p>\r\n<p><u><em><strong>The exercise</strong></em></u></p>\r\n<p>Strap in hand closest to foot bar. Fist at navel. Elbow fist distance from waist. Exhale externally rotate humerus keeping the fist distance space between elbow and waist. Wrist long and neutral.</p>\r\n<p><br></p>\r\n<p><em><strong>NOTE Beginners sit on a Long Box</strong></em></p>	1 YELLOW or 1 BLUE 	Kneeling Arm Side Series RTC.jpg		2018-03-26 17:18:17+00	2018-06-30 12:11:17.834+00	1
81	Short Box Series Round Back 	<p><u><strong>Set up</strong></u></p>\r\n<p>Sitting on short box. Feet under foot strap. Arms folded on chest, behind head or reaching up.</p>\r\n<p>&nbsp;</p>\r\n<p><u><strong>The exercise</strong></u></p>\r\n<p>Inhale sitting on top of sit bones neutral spine and pelvis. Exhale imprint sacrum and lumber spine and roll back into a C curve. Inhale to posterior lateral ribs rolling back up maintain C curve. Find top of sit bones and stack spine and pelvis back to neutral.</p>\r\n<p><br></p>\r\n<p><em><strong>NOTE &nbsp;Cross hands over chest. Progression Hands behind head, reaching up or holding weights.&nbsp;</strong></em></p>	3 RED 1 BLUE 1 YELLOW	Short Box Series Round Back.jpg		2018-03-30 11:51:34.379+00	2018-04-19 09:40:08.384+00	1
82	Short Box Series Obliques 	<p><u><strong>Set up</strong></u></p>\r\n<p>Sitting on short box. Feet under foot strap. Arms folded on chest, behind head or reaching up.</p>\r\n<p><br></p>\r\n<p><u><strong>The exercise</strong></u></p>\r\n<p>Inhale sitting on top of sit bones Rotate ribs and shoulders to the side. Exhale imprint sacrum and lumber spine and roll back connecting ribs to opposite side of pelvis. Inhale to posterior lateral ribs rolling back up maintain rotation and rib pelvis connection. Find top of sit bones and unwind spine back to neutral.</p>\r\n<p><br></p>\r\n<p><em><strong>NOTE &nbsp;Cross hands over chest. Progression Hands behind head, reaching up or holding weights.&nbsp;</strong></em></p>	3 RED 1 BLUE 1 YELLOW	Short Box Series Obliques.jpg		2018-03-30 11:54:10.891+00	2018-04-19 09:43:05.248+00	1
83	Short Box Series Flat Back 	<p>&nbsp;<u><strong>Set up</strong></u></p>\r\n<p>Sitting on short box. Feet under foot strap. Arms folded on chest, behind head or reaching up.</p>\r\n<p><u>&nbsp;</u></p>\r\n<p><u><strong>The exercise</strong></u></p>\r\n<p>Inhale sitting on top of sit bones neutral spine and pelvis. Exhale hinge from hips back. Inhale return.&nbsp;</p>\r\n<p><br>\r\n<em><strong>NOTE &nbsp;Cross hands over chest. Progression Hands behind head, reaching up or holding weights.&nbsp;</strong></em></p>	3 RED 1 BLUE 1 YELLOW	Short Box Series Flat Back.jpg		2018-03-31 06:28:51.637+00	2018-04-19 09:44:04.652+00	1
85	Short Box Series Sides	<p><u><strong>Set up</strong></u></p>\r\n<p>Side sitting on short box one leg extended and foot under strap the other tucked up on box. Lean away from Foot bar until there is tension in foot strap and one sit bone has lifted off box.&nbsp;</p>\r\n<p><br></p>\r\n<p><u><strong>The exercise</strong></u></p>\r\n<p>Inhale lengthen spine and side bend. Exhale connect ribs to pelvis to return to start.&nbsp;</p>\r\n<p><br></p>\r\n<p><em><strong>NOTE &nbsp;Variations &nbsp;Arm position. Across chest, behind head or reaching long.&nbsp;</strong></em></p>	3 RED 1 BLUE 1 YELLOW	Short Box Series Sides.jpg		2018-03-31 06:40:11.268+00	2018-04-19 09:46:15.23+00	1
86	Short Box Series Side Reaches 	<p><u><strong>Set up</strong></u></p>\r\n<p>Side sitting on short box one leg extended and foot under strap the other tucked up on box. Lean away from Foot bar until there is tension in foot strap and one sit bone has lifted off box.&nbsp;</p>\r\n<p><br></p>\r\n<p><u><strong>The exercise</strong></u></p>\r\n<p>Exhale rotate chest towards foot bar deepen core connection and pulse up reaching the arms.</p>	3 RED 1 BLUE 1 YELLOW	Short Box Series Side Reaches.jpg		2018-03-31 06:45:49.596+00	2018-04-19 09:47:24.109+00	1
87	Short Box Series Airplane	<p><u><strong>Set up</strong></u></p>\r\n<p>Side sitting on short box one leg extended and foot under strap the other tucked up on box. Lean away from Foot bar until there is tension in foot strap and one sit bone has lifted off box.&nbsp;</p>\r\n<p><br></p>\r\n<p><u><strong>The Exercise&nbsp;</strong></u></p>\r\n<p>Lean out hands behind head. Exhale rotate chest towards ground and reach arms out sideways. Return to side reach hands behind head. Repeat.&nbsp;</p>	3 RED 1 BLUE 1 YELLOW	Short Box Series Airplane.jpg		2018-03-31 06:48:59.61+00	2018-04-19 09:48:22.985+00	1
96	Long Box Pulling Straps Preparation 	<p><u><strong>Set up</strong></u></p>\r\n<p>Prone on long box legs stretched out long heels together or wide. Spine neutral. Holding the frame.&nbsp;</p>\r\n<p><br></p>\r\n<p><u><strong>The exercise</strong></u></p>\r\n<p>Holding the frame inhale to prepare. Exhale bend the elbows to bull the box towards wrists. Maintain neutral spine.&nbsp;</p>	1 RED + or 1 BLUE 	Long Box Pulling Straps Preparation.jpg		2018-03-31 10:51:03.744+00	2018-04-19 09:51:30.565+00	1
97	Long Box Pulling Straps Up Down 	<p><u><strong>Set up</strong></u></p>\r\n<p>Prone on long box legs stretched out long heels together or wide. Spine neutral. Holding onto the ropes at knots.&nbsp;</p>\r\n<p><br></p>\r\n<p><u><strong>The Exercise&nbsp;</strong></u></p>\r\n<p>Holding straps. Shoulders extended arms on the outside of carriage. Exhale pull the straps to mid thigh.&nbsp;</p>\r\n<p><br></p>\r\n<p><em><strong>NOTE Maintain neutral or move through neutral and &nbsp;into spine extension as hands come to mid thigh.&nbsp;</strong></em></p>\r\n<p><br></p>	1 RED + 	Long Box Pulling Straps Up Down.jpg		2018-03-31 10:55:50.07+00	2018-04-19 09:53:26.724+00	1
80	Green Room Arms Obliques 	<p><u><strong>Set up</strong></u></p>\r\n<p>Sitting at bottom edge of carriage. Knees bent. Feet on Head Rest. Holding straps in bicep curl. Elbows level with shoulders. Sitting tall. &nbsp;</p>\r\n<p><br></p>\r\n<p><u><strong>The Exercise</strong></u></p>\r\n<p>Exhale roll back into C curve until Sacrum is in contact with carriage. Take knees to left rotate thoracic to right. Inhale extend elbows. Exhale gentle bicep curl x10. Alternate sides.</p>	1 BLUE 	Green Room Arms Obliques.jpg		2018-03-30 11:31:27.973+00	2018-04-19 10:04:43.167+00	1
92	Reverse Abdominals Flat Back 	<p><u><strong>Set up</strong></u></p>\r\n<p>Kneeling on carriage knees fist distance from shoulder rests. Hands on frames wrists under shoulders.Flat Back.&nbsp;</p>\r\n<p><br></p>\r\n<p><u><strong>The exercise</strong></u></p>\r\n<p>Inhale to prepare. Exhale press shins into carriage to pull carriage towards wrists. Inhale return to start position.</p>\r\n<p><br>\r\n<em><strong>NOTE Pull from abdominals and lats not upper traps. Keep shoulders drawing away from ears.&nbsp;</strong></em></p>	1 RED or 1 BLUE 	Reverse Abdominals Flat Back.jpg		2018-03-31 10:37:39.938+00	2018-04-19 10:25:37.785+00	1
118	Standing Side Splits with Rotation  	<p><u><strong>Set up</strong></u></p>\r\n<p>Standing on foot plate FIRST. Other foot at centre bottom of carriage. Feet aligned.&nbsp;</p>\r\n<p><br></p>\r\n<p><u><strong>The Excersise&nbsp;</strong></u></p>\r\n<p>Abduction and adduction adding rotation of torso and shoulders knees are soft movement if fluid let arms flow.&nbsp;</p>	1 RED + or 1 BLUE 	Standing Side Splits with Rotation.jpg		2018-04-01 11:21:24.38+00	2018-04-19 10:46:39.456+00	1
106	Kneeling Abdominals Single Arm and Leg	<p><u><strong>Set up</strong></u></p>\r\n<p>Four Point kneeling facing foot bar. Knees at front of carriage toes relaxed. Hands of footplate. Armpits over wrists hips over knees. Tesion in the spring.&nbsp;Single leg extended back opposite arm extended forward&nbsp;</p>\r\n<p>&nbsp;</p>\r\n<p><u><strong>The exercise</strong></u></p>\r\n<p>Inhale to prepare. Exhale press knee backwards shoulder maintains 90 degree angle. Inhale return back to start position.&nbsp;</p>\r\n<p>Exhale press hand into footplate taking shoulder into extension hips maintain 90 degree angle. Inhale return back to start position.&nbsp;</p>\r\n<p>Combine the two.&nbsp;</p>\r\n<p><br></p>\r\n<p><em><strong>NOTE; Maintain set up position.&nbsp;</strong></em></p>	1 YELLOW or 1 BLUE 	\N		2018-03-31 11:35:06.094+00	2018-04-18 13:18:47.724+00	1
101	Swimming on Long Box with Straps 	<p><u><strong>Set up</strong></u></p>\r\n<p>Prone on long box legs stretched out long heels together or wide. Holding straps. Head towards foot bar. Foot bar down.</p>\r\n<p><br></p>\r\n<p><u><strong>The exercise</strong></u></p>\r\n<p>Both arms reaching past head. Elbows straight. Wrists shoulder distance apart. Lift opposite arm and leg. Switch.&nbsp;</p>\r\n<p><br></p>\r\n<p><em><strong>NOTE for advanced clients come into spine extension.</strong></em></p>	1 RED + 	Swimming Long Box With Straps.jpg		2018-03-31 11:07:23.682+00	2018-04-18 23:35:11.857+00	1
84	Short Box Series Climb A Tree 	<p>&nbsp;</p>\r\n<p><em><strong>Set up</strong></em></p>\r\n<p>Seated on short box one out under foot strap other pulled into chest. Hands holding back of thigh. Spine as neutral as possible.&nbsp;</p>\r\n<p>&nbsp;</p>\r\n<p><em><strong>The exercise</strong></em></p>\r\n<p>Exhale extend knee 3 times. Inhale walk hands up back of leg to ankle. Exhale walk hands down back of leg to top of thigh. &nbsp;Walk hands down to top of thigh roll back into spine extension. Letting go of thigh. Circle arms around and roll back up to starting point.&nbsp;</p>	3 RED 1 BLUE 1 YELLOW	Short Box Series Climb A Tree.jpg		2018-03-31 06:34:25.189+00	2018-04-19 09:45:03.375+00	1
98	Long Box Pulling Straps Sides 	<p><u><strong>Set up</strong></u></p>\r\n<p>Prone on long box legs stretched out long heels together or wide. Spine neutral. Holding onto the ropes at knots.&nbsp;</p>\r\n<p><br></p>\r\n<p><u><strong>The Exercise&nbsp;</strong></u></p>\r\n<p>Holding ropes at the knot. Open arms out to T shape wrists in line with shoulders. Elbows straight. Exhale pull the straps to mid thigh.&nbsp;</p>\r\n<p><br></p>\r\n<p><em><strong>NOTE Maintain neutral or move through neutral and &nbsp;into spine extension as hands come to mid thigh.&nbsp;</strong></em></p>	1 RED + 	Long Box Pulling Straps Sides.jpg		2018-03-31 10:57:41.422+00	2018-04-19 09:55:22.791+00	1
99	Long Box Pulling Straps Triceps 	<p><u><strong>Set up</strong></u></p>\r\n<p>Prone on long box legs stretched out long heels together or wide. Spine neutral. Holding onto the ropes at knots.&nbsp;</p>\r\n<p><br></p>\r\n<p><u><strong>The Exercise&nbsp;</strong></u></p>\r\n<p>&nbsp;</p>\r\n<p>Keep arms by sides Inhale bend the elbows. Exhale extend the elbows.&nbsp;</p>\r\n<p><br></p>\r\n<p><em><strong>NOTE Maintain neutral or move through neutral and &nbsp;into spine extension as hands come to mid thigh.&nbsp;</strong></em></p>	1 RED + 	Long Box Pulling Straps Triceps.jpg		2018-03-31 11:02:39.036+00	2018-04-19 09:56:14.305+00	1
104	Teaser	<p><u><strong>Set up</strong></u></p>\r\n<p>Supine on long box. Hands in straps.100’s Position. Or table top.</p>\r\n<p><br></p>\r\n<p><u><strong>The exercise</strong></u></p>\r\n<p>Inhale to prepare. Exhale scoop arms roll through chest lift into balance point simultaneously as hips come into flexion creating a V shape. Inhale at top. Exhale reverse to roll down back to start.&nbsp;</p>	1 RED 	Teaser.jpg		2018-03-31 11:27:46.036+00	2018-04-19 09:57:23.094+00	2
105	Kneeling Abdominals	<p><u><strong>Set up</strong></u></p>\r\n<p>Four Point kneeling facing foot bar.&nbsp;Knees at front of carriage toes relaxed. Hands of footplate. armpits over wrists hips over knees. Tesion in the spring. &nbsp;</p>\r\n<p><br></p>\r\n<p><u><strong>The exercise</strong></u></p>\r\n<p>Inhale to prepare. Exhale press knees backwards shoulders maintain 90 degree angle. Inhale return back to start position.&nbsp;</p>\r\n<p>Exhale press hands into footplate taking shoulders into extension hips maintain 90 degree angle. Inhale return back to start position.&nbsp;</p>\r\n<p>Combine the two.&nbsp;</p>	1 YELLOW or 1 BLUE	Kneeling Abdominals.jpg		2018-03-31 11:31:14.842+00	2018-04-19 10:27:58.901+00	1
107	Elephant 	<p><u><strong>Set up</strong></u></p>\r\n<p>Heels fits distance from shoulder rest toes lifted. Hands on foot bar. Round back.</p>\r\n<p><br></p>\r\n<p><u><strong>The exercise</strong></u></p>\r\n<p>Inhale to prepare. Inhale press heels into carriage pull toes towards navel and press carriage back. Shoulders remain the same. Exhale pull carriage back to stopper</p>\r\n<p><br></p>\r\n<p><em><strong>NOTE If hamstrings alow it bring feet closer to the middle of the carriage.&nbsp;</strong></em></p>	1 RED, 1 BLUE 	Elephant.jpg		2018-03-31 13:10:39.387+00	2018-04-19 10:29:15.487+00	1
103	Teaser Mat 	<p><u><strong>Set up</strong></u></p>\r\n<p>Supine on mat. Arms extended above head. Legs extended long.&nbsp;</p>\r\n<p><br></p>\r\n<p><u><strong>The exercise</strong></u></p>\r\n<p>Inhale Brings arms over shoulders. Exhale begin to roll up collect legs to teaser position. Inhale at top. Exhale roll back down lowering legs.&nbsp;</p>	Mat	Teaser MAT.jpg		2018-03-31 11:24:18.231+00	2018-04-19 12:11:09.378+00	1
102	Swan 	<p><u><strong>Set up</strong></u></p>\r\n<p>Feet in V on Foot plate. Prone on long box knees bent. Arms by side.</p>\r\n<p><br></p>\r\n<p><u><strong>The exercise</strong></u></p>\r\n<p>Exhale extend knees into dart position 3 times. On the third time extend arms above head into full spine extension. Three bends on knees. Return to start.</p>	1 RED 	Swan.jpg		2018-03-31 11:21:59.776+00	2018-08-18 11:05:47.178+00	2
16	Footwork Small V 	<p><u><strong>Set up</strong></u></p>\r\n<p>Supine. Toes in small V on foot bar. Spine neutral. Arms by sides. Head rest comfortable.&nbsp;</p>\r\n<p><br></p>\r\n<p><u><strong>The exercise</strong></u></p>\r\n<p>Inhale to prepare. Exhale press toes into foot bar to extend knees. Maintain Neutral Spine. Squeeze heels together.&nbsp;</p>\r\n<p><br></p>\r\n<p><em><strong>NOTE Optional add pulses.&nbsp;</strong></em></p>	3 RED + 	Footwork Small V.jpg		2018-03-21 23:33:53+00	2018-08-28 23:30:36.199+00	1
110	Inverted V Single Leg 	<p><u><strong>Set up</strong></u></p>\r\n<p>Heels on shoulder rests toes on carriage in “high heel” position. Hands shoulder distance apart on foot bar. Lift one leg to reach back&nbsp;</p>\r\n<p><br></p>\r\n<p><u><strong>The exercise</strong></u></p>\r\n<p>Press into extended plank position. Exhale lift hips to inverted V on single leg. Inhale return to extended plank. Shoulders maintain position. Alternate legs.&nbsp;</p>	1 RED 1 BLUE 	\N		2018-04-01 10:30:35.886+00	2018-04-18 13:18:47.724+00	1
125	Jump Preparation 	<p><u><strong>Set up</strong></u></p>\r\n<p>Supine. Feet on jump board. Arms by sides. Head rest comfortable.&nbsp;</p>\r\n<p><br></p>\r\n<p><u><strong>The Exercise&nbsp;</strong></u></p>\r\n<p>Feet parallel. Inhale bend knees. Exhale extend knees.&nbsp;</p>	2 RED + or 1 BLUE 	Triceps-Portrait.jpg		2018-04-01 12:12:08.966+00	2018-04-18 13:18:47.724+00	1
126	Jump Footwork Small V 	<p><u><strong>Set Up&nbsp;</strong></u></p>\r\n<p>Supine. Feet in small V on jump board. Arms by sides. Head rest comfortable or in a chest lift.&nbsp;</p>\r\n<p><br></p>\r\n<p><u><strong>The Exercise</strong></u></p>\r\n<p>Feet in small V. Inhale bend knees. Exhale jump.</p>\r\n<p><br></p>\r\n<p><em><strong>NOTE You may choose Jump with chest lift&nbsp;</strong></em></p>\r\n<p><em><strong>Curl head neck shoulders into chest lift. Inhale bend knees. Exhale jump. Place soft ball under upper thoracic if jumping in chest lift for extended&nbsp;</strong></em></p>	2 RED + or 1 BLUE 	Triceps.jpg		2018-04-01 12:17:16.167+00	2018-04-18 13:18:47.724+00	1
109	Long Stretch 	<p>&nbsp;<u><strong>Set up</strong></u></p>\r\n<p>Heels on shoulder rests toes on carriage in “high heel” position. Hands shoulder distance apart on foot bar.&nbsp;</p>\r\n<p><br></p>\r\n<p><u><strong>Exercise&nbsp;</strong></u></p>\r\n<p>Press into extended plank. Exhale bring shoulders over wrists. Inhale return to extended plank. Hips maintain position.&nbsp;</p>\r\n<p><br></p>\r\n<p><em><strong>NOTE; Keeping plank strong thoughout.</strong></em></p>	1 RED 1 BLUE	Long Stretch.jpg		2018-04-01 10:25:40.916+00	2018-04-19 10:32:22.903+00	1
112	Jack Rabbit 	<p><u><strong>Set up</strong></u></p>\r\n<p>Heels on shoulder rests toes on carriage in “high heel” position. Hands shoulder distance apart on foot bar.</p>\r\n<p><br></p>\r\n<p><u><strong>The Exercise</strong></u></p>\r\n<p>Press into extended plank. Inhale pull knees in towards foot bar. Maintain shoulder alignment. Exhale return to start.&nbsp;</p>	1 RED 1 BLUE 	Jack Rabbit.jpg		2018-04-01 10:43:17.721+00	2018-04-19 10:33:26.242+00	1
111	Jack Rabbit Single Leg	<p><u><strong>Set up</strong></u></p>\r\n<p>Heels on shoulder rests toes on carriage in “high heel” position. Hands shoulder distance apart on foot bar. &nbsp;Reach straight single leg back&nbsp;</p>\r\n<p><br></p>\r\n<p><u><strong>The exercise</strong></u></p>\r\n<p>Press into extended plank. Exhale pull knee in towards foot bar. Maintain shoulder alignment. Inhale return to extended plank and flex free leg into chest.&nbsp;</p>	1 RED 1 BLUE 	Jack Rabbit Single Leg.jpg		2018-04-01 10:32:54.726+00	2018-04-19 10:34:13.66+00	1
113	Arabesque 	<p><u><strong>Set up</strong></u></p>\r\n<p>One heel on shoulder rests toes on carriage in “high heel” position. Other foot hovering above head rest. Hands shoulder distance apart on foot bar.</p>\r\n<p><br></p>\r\n<p><u><strong>The exercise</strong></u></p>\r\n<p>Press into extended plank position. Hover 1 foot over head rest. Exhale lift hips to inverted V as the carriage comes in lift hovering leg into arabesque. Inhale return to extended plank lowering arabesque leg. Shoulders maintain position.</p>	1 RED 1 BLUE 	Arabesque.jpg		2018-04-01 10:58:08.007+00	2018-04-19 10:35:16.814+00	1
124	Russian Splits Back Knee	<p><u><strong>Set Up&nbsp;</strong></u></p>\r\n<p>One foot on foot bar the other in high heel on the shoulder rest</p>\r\n<p><br></p>\r\n<p><u><strong>The Exercise&nbsp;</strong></u></p>\r\n<p>Lifting hands up either crossed at chest or reaching out to sides.Bring body upright.Extend both knees. Inhale press back into semi split bend back leg and extend x 8-10. Exhale return to start.&nbsp;</p>	1 RED 1 BLUE 	Russian Splits Back Knee.jpg		2018-04-01 11:55:35.544+00	2018-04-19 10:53:11.051+00	1
24	Feet in Straps Small Frogs 	<p><u><strong>Set up</strong></u></p>\r\n<p>Supine. Spine and Pelvis Neutral. Feet in Straps at bottom of metatarsal arch. Head rest comfortable. &nbsp;Feet in V knees in like with second big toe.&nbsp;Legs Straight.</p>\r\n<p><br></p>\r\n<p><u><strong>The exercise</strong></u></p>\r\n<p>Inhale bend knees into small frog. Exhale press feet into straps to extend knees. Spine and Pelvis maintain neutral. Push equal pressure in both feet.&nbsp;</p>	1 RED, 1 BLUE or 2 RED or 1 BLUE 	Feet in Straps Frogs.jpg		2018-03-22 00:31:56+00	2018-06-30 11:34:22.791+00	1
128	Jump Footwork Wide Parallel 	<p><u><strong>Set Up&nbsp;</strong></u></p>\r\n<p>Supine. Feet in wide parallel on jump board. Arms by sides. Head rest comfortable or in a chest lift.&nbsp;</p>\r\n<p><br></p>\r\n<p><u><strong>The Exercise</strong></u></p>\r\n<p>Feet in wide parallel. Inhale bend knees. Exhale jump.</p>\r\n<p><br></p>\r\n<p><em><strong>NOTE You may choose Jump with chest lift&nbsp;</strong></em></p>\r\n<p><em><strong>Curl head neck shoulders into chest lift. Inhale bend knees. Exhale jump. Place soft ball under upper thoracic if jumping in chest lift for extended&nbsp;</strong></em></p>	2 RED + or 1 BLUE 	Jump Footwork Wide Parallel.jpg		2018-04-02 00:23:18.615+00	2018-07-01 12:51:05.11+00	1
167	Mountain Climber 	<p><u><strong>Set Up</strong></u></p>\r\n<p>Plank position.</p>\r\n<p><br></p>\r\n<p><u><strong>The Exercise</strong></u></p>\r\n<p>Inhale prepare, exhale draw single leg in towards chest. Alternate legs.&nbsp;</p>\r\n<p><br></p>\r\n<p><em><strong>NOTE; Maintain plank postion try not to lift but in the air as leg pulls in.&nbsp;</strong></em></p>	MAT 	Mountain Climber.jpg		2018-04-04 12:53:45.388+00	2018-07-03 11:19:42.722+00	1
115	Hip Flexor Stretch 	<p><u><strong>Set up</strong></u></p>\r\n<p>Standing next to carriage one foot on ground other heel against shoulder rest. Knees bent. Pelvis aligned. Hands on Foot bar.&nbsp;</p>\r\n<p><br></p>\r\n<p><u><strong>The Exercise</strong></u>&nbsp;</p>\r\n<p>From Scooter position press back into his flexor stretch. Maintain lowest rib over ASIS.&nbsp;</p>	1 RED 	Hip Flexor Stretch.jpg		2018-04-01 11:09:12.803+00	2018-07-03 11:53:05.655+00	1
114	Scooter	<p><u><strong>Set up</strong></u></p>\r\n<p>Standing next to carriage one foot on ground other heel against shoulder rest. Knees bent. Pelvis aligned. Hands on Foot bar.&nbsp;</p>\r\n<p><br></p>\r\n<p><u><strong>The exercise</strong></u></p>\r\n<p>Inhale to prepare. Exhale press heel into shoulder rest taking the hip into extension. Inhale return.&nbsp;</p>\r\n<p><br></p>	1 RED	Scooter.jpg		2018-04-01 11:00:26.026+00	2018-07-03 11:57:50.455+00	1
139	Jump Obliques	<p><u><strong>Set Up&nbsp;</strong></u></p>\r\n<p>Supine on carriage. Feet parallel on jump board. Arms straight reaching towards celiling. Holing weights optional. &nbsp;</p>\r\n<p><br></p>\r\n<p><u><strong>The Exercise&nbsp;</strong></u></p>\r\n<p>Chest lift with reaching arms diagonally towards ceiling rotate chest and arms to an oblique chest lift. Jump and rainbow arms and chest to otherside. Repeate. Maintain a stable neutral pelvis while jumping.&nbsp;</p>\r\n<p><br></p>\r\n<p><em><strong>NOTE put a ball or prop under upper thoracic to support neck. Can leave head down.&nbsp;</strong></em></p>\r\n<p><br></p>	1 BLUE 	\N		2018-04-02 04:14:38.907+00	2018-04-18 13:18:47.724+00	1
136	Jump Kneeling Legs	<p><u><strong>Set up</strong></u></p>\r\n<p>Quadruped with hands on shoulder rests. Neutral spine. Single leg extended onto jump board. Leg Parallel.&nbsp;</p>\r\n<p><br></p>\r\n<p><u><strong>The exercise</strong></u></p>\r\n<p>Inhale bend knee. Exhale extend knee to jump.&nbsp;</p>	1 BLUE or 1 RED 	\N		2018-04-02 01:15:21.612+00	2018-04-18 13:18:47.724+00	1
140	Star Jumps 	<p><u><strong>Set Up</strong></u></p>\r\n<p>Standing on Mat&nbsp;</p>\r\n<p><br></p>\r\n<p><u><strong>The Exercise</strong></u></p>\r\n<p>Used as a cardio warm up for jump. Can be done as a full jump or a step out.&nbsp;</p>	MAT 	\N		2018-04-02 07:54:44.865+00	2018-04-18 13:18:47.724+00	1
8	Double Leg Lowers 	<p><u><strong>Set up</strong></u></p>\r\n<p>Supine. Heels on lowered foot bar, mat or a long box on the mat. Spine neutral<em> </em><em><strong>or imprint</strong></em>. Arms by sides. Head rest comfortable.&nbsp;Both legs at table top.&nbsp;</p>\r\n<p><br></p>\r\n<p><u><strong>The exercise</strong></u></p>\r\n<p>Exhale connect to the core, anchor low ribs &nbsp;lower legs from table top to point of control. Maintain <strong>Neutral Spnie</strong> or <strong>Imprint</strong>. &nbsp;</p>\r\n<p><br></p>\r\n<p><em><strong>NOTE: People with with low back pain, or decreaced core control may find it helpful to maintain a gentle imprint. Be sure it is an imprint not a pelvic tilt.&nbsp;</strong></em></p>	3 RED or 1 BLUE or MAT	\N		2018-03-21 19:26:06+00	2018-04-18 13:18:47.724+00	1
144	Jump Obliques	<p><u><strong>Set Up&nbsp;</strong></u></p>\r\n<p><br></p>\r\n<p><u><strong>The Exercise&nbsp;</strong></u></p>		\N		2018-04-03 04:50:39.021+00	2018-04-18 13:18:47.724+00	1
137	Jump Kneeling Legs External Rotation 	<p><u><strong>Set up</strong></u></p>\r\n<p>Quadruped with hands on shoulder rests. Neutral spine. Single leg extended onto jump board in external rotation. Rotate entire pelvis. Look towards foot.&nbsp;</p>\r\n<p><br></p>\r\n<p><u><strong>The exercise</strong></u></p>\r\n<p>Inhal prepare exhale jump.&nbsp;</p>\r\n<p>&nbsp;</p>\r\n<p><br></p>	1 BLUE or 1 RED 	\N		2018-04-02 04:05:13.503+00	2018-04-18 13:18:47.724+00	1
148	Jump Marching 	<p><u><strong>Set Up&nbsp;</strong></u></p>\r\n<p>Supine. Feet in parallel on jump board. Arms by sides. Head rest comfortable or in a chest lift.&nbsp;</p>\r\n<p><br></p>\r\n<p><u><strong>The Exercise</strong></u></p>\r\n<p>Run or march on the spot. This is an interval training exercise. Do 10 - 20 slow &nbsp;10- 20 &nbsp;fast.</p>\r\n<p><br></p>\r\n<p><em><strong>NOTE You may choose Jump with chest lift&nbsp;</strong></em></p>\r\n<p><em><strong>Curl head neck shoulders into chest lift. Inhale bend knees. Exhale jump. Place soft ball under upper thoracic if jumping in chest lift for extended&nbsp;</strong></em></p>	2 RED + 	\N		2018-04-03 06:40:47.494+00	2018-04-18 13:18:47.724+00	1
149	Jump Side Lying Kick Up 	<p><u><strong>Set Up&nbsp;</strong></u></p>\r\n<p>Side lying on carriage head resting on underneath arm outstretched or propped up on elbow.&nbsp;</p>\r\n<p><br></p>\r\n<p><u><strong>The Exercise&nbsp;</strong></u></p>\r\n<p>Top leg on jump board bottom leg bent. &nbsp;Neutral pelvis. Inhale bend knee. Exhale jump top leg kicks up towards roof and returns for landing.&nbsp;</p>	1 BLUE 	\N		2018-04-03 06:44:26.712+00	2018-04-18 13:18:47.724+00	1
166	Plank to Row 	<p><u><strong>Set Up&nbsp;</strong></u></p>\r\n<p>Holding weights in plank position.&nbsp;</p>\r\n<p><br></p>\r\n<p><u><strong>The Exercise</strong></u></p>\r\n<p>Pull single arm into shoulder extension flexing elbow. "elbowing the person behine you". Alternate arms.&nbsp;</p>\r\n<p><br></p>\r\n<p><em><strong>Note; Maintain strong plank and neutral pelvis thoughout.&nbsp;</strong></em></p>	MAT 	Plank to Row.jpg		2018-04-04 12:47:15.848+00	2018-07-03 11:19:03.994+00	1
150	Side Lying Jump Bent Knee 	<p><u><strong>Set Up&nbsp;</strong></u></p>\r\n<p>Side lying on carriage head resting on underneath arm outstretched or propped up on elbow.&nbsp;</p>\r\n<p><br></p>\r\n<p><u><strong>The Exercise&nbsp;</strong></u></p>\r\n<p>Top leg on jump board bottom leg bent. &nbsp;Neutral pelvis. Inhale bend knee. Exhale jump top knee bents front and returns for landing.&nbsp;</p>	1 BLUE 	Side Lying Jump.jpg		2018-04-03 06:47:42.651+00	2018-07-03 11:31:29.308+00	1
135	Jump Side Lying Front Kick 	<p><u><strong>Set Up&nbsp;</strong></u></p>\r\n<p>Side lying on carriage head resting on underneath arm outstretched or propped up on elbow.&nbsp;</p>\r\n<p><br></p>\r\n<p><u><strong>The Exercise&nbsp;</strong></u></p>\r\n<p>Top leg on jump board bottom leg bent. &nbsp;Neutral pelvis. Inhale bend knee. Exhale jump top leg kicks front and returns for landing.&nbsp;</p>	1 BLUE 	Side Lying Jump.jpg		2018-04-02 01:08:44.448+00	2018-07-03 11:32:24.856+00	1
138	Jump Kneeling Arms 	<p><u><strong>Set up</strong></u></p>\r\n<p>Quadruped with hands on jump board. Hips 130° or 90°</p>\r\n<p><br></p>\r\n<p><u><strong>The exercise</strong></u></p>\r\n<p>Inhale bend elbows. Exhale extend elbows to jump. Be mindful that the core is engaged.&nbsp;</p>	1 BLUE 	Jump Kneeling Arms.jpg		2018-04-02 04:13:40.446+00	2018-07-03 11:52:10.009+00	1
143	Chest Lift 	<p><u><strong>Set Up&nbsp;</strong></u></p>\r\n<p>Lying supine on carriage or mat knees bent on foot bar, mat or top of jump board. Hands interlaced behind head.&nbsp;</p>\r\n<p><br></p>\r\n<p><u><strong>The Exercise&nbsp;</strong></u></p>\r\n<p>Inhale prepare. Exhale lift head neck and shoulders into chest lift.&nbsp;Inhale rainbow hands to hold backs of knees. Exhale pull a little deeper into chest lift. Inhale rainbow arms back to behind knees. Retern to set up.</p>\r\n<p><br></p>\r\n<p><em><strong>NOTE Stay in chest lift and add single leg lifts, double leg lowers.&nbsp;</strong></em></p>	2 RED or MAT 	Chest Lift.JPG		2018-04-03 04:35:44.442+00	2018-07-09 12:17:33.925+00	1
147	Jump Footwork Combo 	<p><u><strong>Set Up&nbsp;</strong></u></p>\r\n<p>Supine. Feet in parallel on jump board. Arms by sides. Head rest comfortable or in a chest lift.&nbsp;</p>\r\n<p><br></p>\r\n<p><u><strong>The Exercise</strong></u></p>\r\n<p>&nbsp;Inhale bend knees. Exhale jump.move through all the foot work positions. Parallel, small V, wide V, hell beat.&nbsp;</p>\r\n<p><br></p>\r\n<p><em><strong>NOTE You may choose Jump with chest lift&nbsp;</strong></em></p>\r\n<p><em><strong>Curl head neck shoulders into chest lift. Inhale bend knees. Exhale jump. Place soft ball under upper thoracic if jumping in chest lift for extended&nbsp;</strong></em></p>	2 RED + 	Jump Footwork Combo.jpg		2018-04-03 06:38:17.471+00	2018-09-02 04:07:25.66+00	1
152	Jump Around the World	<p><u><strong>Set Up&nbsp;</strong></u></p>\r\n<p>Supine. Feet parallel on jump board at top center. Arms by sides. Head rest comfortable or in a chest lift.&nbsp;</p>\r\n<p><br></p>\r\n<p><u><strong>The Exercise</strong></u></p>\r\n<p>Inhale bend knees. Exhale jump."around the worls" start jump at top land to side to bottom to otherside to top. Continue in same direction or alternate directions.&nbsp;</p>\r\n<p><br></p>\r\n<p><em><strong>NOTE You may choose Jump with chest lift&nbsp;</strong></em></p>\r\n<p><em><strong>Curl head neck shoulders into chest lift. Inhale bend knees. Exhale jump. Place soft ball under upper thoracic if jumping in chest lift for extended&nbsp;</strong></em></p>	2 RED + 	\N		2018-04-03 06:51:37.14+00	2018-04-18 13:18:47.724+00	1
159	Jump Elbows Ski 	<p><u><strong>Set Up</strong></u></p>\r\n<p>Supine on carriage. Elbows propped against shoulder rests. Hands on small of back or by hips. Feet together in center of jump board, toes pointing towars top right coner of jump board</p>\r\n<p><br></p>\r\n<p><u><strong>The Exercise</strong></u></p>\r\n<p>Exhale Jump and land with toes pointing to top left side of jump board. Maintain "poolside" elbow position. gentle imprint of lumber spine.&nbsp;</p>\r\n<p><br></p>\r\n<p><em><strong>NOTE; Regres by putting rolled up mat against shoulder rests and coming into a chest lift.&nbsp;</strong></em></p>	2 RED or 1 RED	\N		2018-04-03 11:40:03.808+00	2018-04-18 13:18:47.724+00	1
158	Jump Elbows Footwork 	<p><u><strong>Set Up</strong></u></p>\r\n<p>Supine on carriage. Elbows propped against shoulder rests. Hands on small of back or by hips.&nbsp;</p>\r\n<p><br></p>\r\n<p><u><strong>The Exercise</strong></u></p>\r\n<p>Exhale Jump. Maintain "poolside" elbow position. gentle imprint of lumber spine. Work though selected footwork.&nbsp;</p>\r\n<p><br></p>\r\n<p><em><strong>NOTE; Regres by putting rolled up mat against shoulder rests and coming into a chest lift.&nbsp;</strong></em></p>	2 RED or 1 RED 	\N		2018-04-03 11:36:06.222+00	2018-04-18 13:18:47.724+00	1
161	Roll Back on Long Box 	<p><u><strong>Set Up&nbsp;</strong></u></p>\r\n<p>Long Box on mat. Sitting on edge of Long Box arms out stretched. Feet flat on the floor.</p>\r\n<p><br></p>\r\n<p><u><strong>The Exercise&nbsp;</strong></u></p>\r\n<p>Inhale prepare exhale roll back one vertebra at a time onto long box. Inhale at bottom exhale roll up. Keep feet on floor.&nbsp;</p>	MAT	\N		2018-04-03 11:53:21.476+00	2018-04-18 13:18:47.724+00	1
164	Booty Ball Squeeze Back 	<p><u><strong>Set Up</strong></u></p>\r\n<p>Standing holding on to edge of jump board or wall. Hold ball between calf and hamstring. Gently squeezing.&nbsp;</p>\r\n<p><br></p>\r\n<p><u><strong>The Exercise</strong></u></p>\r\n<p>Press heel towards sitbone squeezing ball and extend hip. Return to set up repeate&nbsp;</p>	MAT 	\N		2018-04-04 12:27:48.918+00	2018-04-18 13:18:47.724+00	1
165	Booty Ball Fire Hydrant 	<p><u><strong>Set Up</strong></u></p>\r\n<p>Standing holding on to edge of jump board or wall. Hold ball between calf and hamstring. Gently squeezing.&nbsp;</p>\r\n<p><br></p>\r\n<p><u><strong>The Exercise</strong></u></p>\r\n<p>Press heel towards sitbone squeezing ball and Abduct the hip. Return to set up repeat.&nbsp;</p>	MAT 	\N		2018-04-04 12:43:05.431+00	2018-06-15 00:49:16.072+00	2
156	Short Box Side Plank Parallel	<p><u><strong>Set Up</strong></u></p>\r\n<p>Short Box on carriage. Side elbows plank single leg on jump board. Leg parallel. Hips square.&nbsp;</p>\r\n<p><br></p>\r\n<p><u><strong>The Exercise&nbsp;</strong></u></p>\r\n<p>Exhale press the foot into jump board to extend the knee inhave flex the knee. Keep elbow plank 90/90.</p>\r\n<p>&nbsp;</p>\r\n<p><em><strong>NOTE; Be mindful that the torso and elbos remain in place the action comes from the glutes and the knee</strong></em>.&nbsp;</p>	1 RED 1 BLUE or ! BLUE	short box side plank  Parallel.JPG		2018-04-03 11:28:54.22+00	2018-07-09 12:58:56.293+00	1
160	Jump Ski 	<p><u><strong>Set Up</strong></u></p>\r\n<p>Supine on carriage.Head rest comfortable or in chest lift. Feet together in center of jump board, toes pointing towars top right coner of jump board</p>\r\n<p><br></p>\r\n<p><u><strong>The Exercise</strong></u></p>\r\n<p>Exhale Jump and land with toes pointing to top left side of jump board.&nbsp;</p>\r\n<p><br></p>\r\n<p><em><strong>NOTE; Come into cest lift and lighten the springs to make it more about abdominals.&nbsp;</strong></em></p>	2 RED or 1 RED or 1 BLUE	Jump Ski.jpg		2018-04-03 11:41:14.99+00	2018-07-03 10:11:09.366+00	1
162	Step Ups	<p><u><strong>Set Up</strong></u></p>\r\n<p>Press Long Box against the frame of reformer on mat.&nbsp;</p>\r\n<p><br></p>\r\n<p><u><strong>The Exercise</strong></u></p>\r\n<p>Step up onto box 15 seconds slow 20 seconds fast.&nbsp;</p>\r\n<p><br></p>\r\n<p><em><strong>NOTE; Make sure box is pressed up against the reformer to ensure the box doesn't slip.&nbsp;</strong></em></p>	MAT 	Step Ups .jpg		2018-04-03 11:59:17.251+00	2018-07-03 11:59:31.246+00	1
151	Jump Side to Side 	<p><u><strong>Set Up&nbsp;</strong></u></p>\r\n<p>Supine. Feet parallel to side of jump board. Arms by sides. Head rest comfortable or in a chest lift.&nbsp;</p>\r\n<p><br></p>\r\n<p><u><strong>The Exercise</strong></u></p>\r\n<p>Inhale bend knees. Exhale jump.to other side of jup board. Keep feet parallel.&nbsp;</p>\r\n<p><br></p>\r\n<p><em><strong>NOTE You may choose Jump with chest lift&nbsp;</strong></em></p>\r\n<p><em><strong>Curl head neck shoulders into chest lift. Inhale bend knees. Exhale jump. Place soft ball under upper thoracic if jumping in chest lift for extended&nbsp;</strong></em></p>	2 RED + or 1 BLUE 	Jump side to side.JPG		2018-04-03 06:48:31.724+00	2018-07-09 12:32:41.686+00	1
157	Short Box Side Plank External Rotation 	<p><u><strong>Set Up</strong></u></p>\r\n<p>Short Box on carriage. Side elbows plank single leg on jump board. Leg externally rotated.&nbsp;</p>\r\n<p><br></p>\r\n<p><u><strong>The Exercise&nbsp;</strong></u></p>\r\n<p>Exhale press the foot into jump board to extend the knee inhave flex the knee. Keep elbow plank 90/90.</p>\r\n<p><br></p>\r\n<p><em><strong>NOTE; Be mindful that the torso and elbos remain in place the action comes from the glutes and the knee</strong></em>.&nbsp;</p>	1 RED 1 BLUE or 1 BLUE	short box side plank External Rotation.JPG.JPG		2018-04-03 11:29:52.808+00	2018-07-09 12:59:00.406+00	1
154	Short Box 4 Point Kneeling Parallel	<p><u><strong>Set Up</strong></u></p>\r\n<p>Short Box on carriage. Elbows on box single knee bent on carriage, single leg on jump board. Leg parallel knee pointing towards the springs.&nbsp;</p>\r\n<p><br></p>\r\n<p><u><strong>The Exercise&nbsp;</strong></u></p>\r\n<p>Exhale press the foot into jump board to extend the knee inhave flex the knee. Keep elbow plank 90/90.&nbsp;</p>\r\n<p><br></p>\r\n<p><em><strong>NOTE; Be mindful that the torso and elbos remain in place the action comes from the glutes and the knee</strong></em>.&nbsp;</p>	1 RED or 1 RED 1 BLUE 	Short Box4 point kneeling parallel.JPG		2018-04-03 11:18:42.741+00	2018-07-09 13:03:01.711+00	1
178	Bent Leg Press Jump T.B	<p><u><strong>Set up</strong></u></p>\r\n<p>Supine. THERA BAND over heel leg in table top. Other leg parelle on jump board.&nbsp;</p>\r\n<p><br></p>\r\n<p><u><strong>The exercise</strong></u></p>\r\n<p>Exhale jump. In mid air press THERA BAND leg straight. Inhale land on jump leg return THERA BAND leg to table top. After 10 alternate sides.&nbsp;</p>	1 YELLOW 1 BLUE 	\N		2018-04-05 06:14:49.057+00	2018-04-18 13:18:47.724+00	1
170	Single Bent Leg Stretch with Strap 	<p><u><strong>Set Up</strong></u>&nbsp;</p>\r\n<p>Seated on mat diagonally next to Reformer knees bent feet flat on the ground. Holding onto strap closest to you &nbsp;at knot.Inhale prepare feel sitbones on the floor. Exhale intitate roll back with a lumbur imprint roll back one vertebra at a time until sacrum is in contact with the mat. &nbsp;</p>\r\n<p><br></p>\r\n<p><u><strong>The Excercise&nbsp;</strong></u></p>\r\n<p>Holding one leg at table top the other reached out straight. Exhale switch. Keep toes in same plane.&nbsp;</p>\r\n<p><br></p>\r\n<p><em><strong>NOTE; Keep pelvis stable.&nbsp;</strong></em></p>	1 BLUE 	\N		2018-04-04 13:18:19.528+00	2018-04-18 13:18:47.724+00	1
171	Oblique Rotation with Strap 	<p><u><strong>Set Up</strong></u>&nbsp;</p>\r\n<p>Seated on mat diagonally next to Reformer knees bent feet flat on the ground. Holding onto strap closest to you &nbsp;at knot.Inhale prepare feel sitbones on the floor. Exhale intitate roll back with a lumbur imprint roll back one vertebra at a time until sacrum is in contact with the mat. &nbsp;</p>\r\n<p><br></p>\r\n<p><u><strong>The Exercise&nbsp;</strong></u></p>\r\n<p>Exhale bend elbows and rotate thoracic spine into oblique twist. Alternate sides. &nbsp;Keep fists infront of heart at all times.&nbsp;</p>	1 BLUE 	\N		2018-04-04 13:25:29.293+00	2018-04-18 13:18:47.724+00	1
172	Roll Up with Strap 	<p><u><strong>Set Up&nbsp;</strong></u></p>\r\n<p>Lying diagonally supine on mat next to Reformer holding onto strap. Legs straight.&nbsp;</p>\r\n<p><br></p>\r\n<p><u><strong>The Exercise</strong></u></p>\r\n<p>Inhale prepare, exhale nod chin to throat roll up one vertebra at a time. Inhale at top, Exhale roll back.&nbsp;</p>\r\n<p><br></p>\r\n<p><u><strong>NOTE; Use the stap to deepen core connection and spine articulation.</strong></u></p>	1 BLUE 	\N		2018-04-04 13:31:38.422+00	2018-04-18 13:18:47.724+00	1
177	Hamstring Stretch Jump T.B	<p><u><strong>Set up</strong></u></p>\r\n<p>Supine. Feet parallel on jump board. Head rest comfortable.&nbsp;Single straight leg reaching up THERA BAND over heel in a hamstring stretch. Holding THERA BAND with hands.&nbsp;</p>\r\n<p><br></p>\r\n<p><u><strong>The exercise</strong></u></p>\r\n<p>Maintain Hamstring stretch. Exhale extend knee to jump.&nbsp;After 10 alternate legs.&nbsp;</p>	1 BLUE 1 YELLOW 	\N		2018-04-05 06:08:45.11+00	2018-04-18 13:18:47.724+00	1
182	Lunge to Knee Drive 	<p><u><strong>Set Up&nbsp;</strong></u></p>\r\n<p>Standing on mat prepare to lunge. Hand weights optional.&nbsp;</p>\r\n<p><br></p>\r\n<p><u><strong>The Exercise&nbsp;</strong></u></p>\r\n<p>Inhale lunge sigle leg back. Exhale drive knee forward. Oppisite elbow comes to knee. Repeat on same leg or alternate.&nbsp;</p>\r\n<p><br></p>\r\n<p><em><strong>NOTE: Do this as a HIIT set or delegate number of repetitions&nbsp;</strong></em></p>	MAT 	\N		2018-04-05 10:53:18.296+00	2018-04-18 13:18:47.724+00	1
183	Squat to Oblique Knee	<p><u><strong>Set Up&nbsp;</strong></u></p>\r\n<p>Wide stance. Hand weights optional.&nbsp;</p>\r\n<p><br></p>\r\n<p><u><strong>The Exercise&nbsp;</strong></u></p>\r\n<p>Inhale wide squat as knees extend shift weight to one side. Lift other leg knee bent rotate torso and punch oppisite fist to knee.&nbsp;Repeat on same leg or alternate.&nbsp;</p>\r\n<p><br></p>\r\n<p><em><strong>NOTE: Do this as a HIIT set or delegate number of repetitions&nbsp;</strong></em></p>	MAT	\N		2018-04-05 10:55:38.918+00	2018-04-18 13:18:47.724+00	1
185	Kneeling Hip Extension 	<p><u><strong>Set Up&nbsp;</strong></u></p>\r\n<p>Knneing on carriage. Hands on top of jump board. Hips at 90/90.</p>\r\n<p><br></p>\r\n<p><u><strong>The Exercise&nbsp;</strong></u></p>\r\n<p>Exhale extend hips back. Inhale retern to 90/90.&nbsp;</p>\r\n<p><br></p>\r\n<p><em><strong>NOTE; Keep chest low. Only go to point of control.&nbsp;</strong></em></p>	1 YELLOW 1 BLUE 	\N		2018-04-05 11:00:51.282+00	2018-04-18 13:18:47.724+00	1
173	Ball Footwork 	<p><u><strong>Set Up</strong></u></p>\r\n<p>Supine on carriage, head rest comfortable, arms by sides. Feet on blue ball in center or jump board.&nbsp;</p>\r\n<p><br></p>\r\n<p><u><strong>The Exercise</strong></u></p>\r\n<p>Exhale press feet into ball, extend knees squeezing legs together. Inhale return.&nbsp;</p>\r\n<p><br></p>\r\n<p><em><strong>NOTE; Core must be active to keep ball still.&nbsp;</strong></em></p>	2 RED 1 BLUE 	Ball Footwork.jpg		2018-04-04 13:42:36.071+00	2018-08-28 13:39:43.489+00	1
174	Ball Footwork Single Leg	<p><u><strong>Set Up</strong></u></p>\r\n<p>Supine on carriage, head rest comfortable, arms by sides Single foot on blue ball in center or jump board, other leg at table top.&nbsp;</p>\r\n<p><br></p>\r\n<p><u><strong>The Exercise</strong></u></p>\r\n<p>Exhale press foot into ball, extend knee maintian other leg at table top.&nbsp;</p>\r\n<p><br></p>\r\n<p><em><strong>NOTE; Core must be active to keep ball still.&nbsp;</strong></em></p>	2 RED 1 BLUE 	Ball footwork single leg.jpg		2018-04-04 13:44:12.161+00	2018-08-28 13:41:18.875+00	1
176	Jump Footwork Internal Rotation 	<p><u><strong>Set Up&nbsp;</strong></u></p>\r\n<p>Supine. Feet wide internally rotated at hip on jump board. Arms by sides. Head rest comfortable or in a chest lift.&nbsp;</p>\r\n<p><br></p>\r\n<p><u><strong>The Exercise</strong></u></p>\r\n<p>Inhale bend knees. Exhale jump.</p>\r\n<p><br></p>\r\n<p><em><strong>NOTE You may choose Jump with chest lift&nbsp;</strong></em></p>\r\n<p><em><strong>Curl head neck shoulders into chest lift. Inhale bend knees. Exhale jump. Place soft ball under upper thoracic if jumping in chest lift for extended&nbsp;</strong></em></p>	2 RED 1 BLUE 	Jump Footwork Internal Rotation.jpg		2018-04-05 06:00:38.361+00	2018-08-28 22:39:12.809+00	1
175	Jump Ball Between Ankles Parallel 	<p><u><strong>Set Up</strong></u></p>\r\n<p>Supine on carriage, head rest comfortable, arms by sides or in a chest lift. Ball between ankles. Feet in center of jump board paralle.&nbsp;</p>\r\n<p><br></p>\r\n<p><u><strong>The Exercise</strong></u>&nbsp;</p>\r\n<p>Feet &nbsp;parallel. Inhale bend knees. Exhale jump. squeezing ball between ankles.&nbsp;</p>\r\n<p><br></p>\r\n<p><u><strong>NOTE; You can move through different positions from here. Jump Skiing, Jump side to side, Jump Around The World.</strong></u></p>	2 RED 1 BLUE or 1 BLUE 	Jump Ball Between Ankles Parallel.jpg		2018-04-04 13:47:18.851+00	2018-09-02 03:27:59.485+00	1
184	Kneeling Arm Press 	<p><u><strong>Set Up&nbsp;</strong></u></p>\r\n<p>Knneing on carriage. Hands on top of jump board. Hips at 90/90.</p>\r\n<p><br></p>\r\n<p><u><strong>The Exercise&nbsp;</strong></u></p>\r\n<p>Inhale flex elbows into arm press. Exhale extend elbows.&nbsp;</p>\r\n<p><br></p>\r\n<p><em><strong>NOTE; Keep chest low and hips at 90/90</strong></em></p>	1 YELLOW 1 BLUE 	Kneeling Arm Press.jpg		2018-04-05 10:58:53.68+00	2018-09-02 03:31:20.548+00	2
189	Jump Side Lying Bottom Leg Kick Up 	<p><u><strong>Set Up&nbsp;</strong></u></p>\r\n<p>Side lying on carriage head resting on underneath arm outstretched or propped up on elbow.&nbsp;Top leg at top center of jumpboard. Bottom leg at bottom center.&nbsp;</p>\r\n<p><br></p>\r\n<p><u><strong>The Exercise&nbsp;</strong></u></p>\r\n<p>Exhale jump. Adduct bottom leg to top leg to "kick up" &nbsp;Return to set up. Reteat.&nbsp;</p>	1 BLUE	\N		2018-04-05 11:30:19.258+00	2018-04-18 13:18:47.724+00	1
190	Burpee	<p><u><strong>Set up&nbsp;</strong></u></p>\r\n<p>Stand with your feet shoulder-width apart, weight in your heels, and your arms at your sides.</p>\r\n<p><br></p>\r\n<p><u><strong>The Exercise&nbsp;</strong></u></p>\r\n<p>Push hips back, flex knees, and lower your body into a squat. Place hands on the floor directly in front of, and just inside, feet. Shift weight onto them. Jump feet back to softly land on the balls of your feet in a plank position. Your body should form a straight line from your head to heels. Jump feet back so that they land just outside of hands. Reach your arms over head and explosively jump up into the air. Land and immediately lower back into a squat for next rep.</p>\r\n<p><br></p>\r\n<p><em><strong>Note; Variation can be done on side Reformer frame not the ground for plank.&nbsp;</strong></em></p>	Mat	\N		2018-04-05 11:49:43.272+00	2018-04-18 13:18:47.724+00	1
192	Thera Band I.T.B Stretch 	<p><u><strong>Set Up&nbsp;</strong></u></p>\r\n<p>Supine on carriage. Head rest comfortable. Single leg pressed into footbar or jump board. Thera Band around heel of other leg.&nbsp;</p>\r\n<p><br></p>\r\n<p><u><strong>The Exercise&nbsp;</strong></u></p>\r\n<p>The leg come into an L shape. Draw the stretching leg across body to stretch ITB. Keep knees as straight as possible.&nbsp;Let the pelvis roll towards leg.&nbsp;</p>\r\n<p><br></p>	1 RED 	\N		2018-04-05 12:03:01.271+00	2018-04-18 13:18:47.724+00	1
193	Thera Band Adductor Stretch 	<p><u><strong>Set Up&nbsp;</strong></u></p>\r\n<p>Supine on carriage. Head rest comfortable. Single leg pressed into footbar or jump board. Thera Band around heel of other leg.&nbsp;</p>\r\n<p><br></p>\r\n<p><u><strong>The Exercise&nbsp;</strong></u></p>\r\n<p>The leg come into an L shape. Draw the stretching leg away from body to stretch adductors. Keep knees as straight as possible.Keep the pelvis as stable as possible. &nbsp;</p>	1 RED 	\N		2018-04-05 12:05:00.347+00	2018-04-18 13:18:47.724+00	1
196	Running on the Spot 	<p><u><strong>Set Up</strong></u></p>\r\n<p>Standing on mat weights optional.&nbsp;</p>\r\n<p><br></p>\r\n<p><u><strong>The exercise</strong></u></p>\r\n<p>Running on the spot for 20 seconds then change directions untill all 4 corners of room have been faced.&nbsp;</p>\r\n<p><br></p>\r\n<p><em><strong>NOTE; Think flashdance!&nbsp;</strong></em></p>	MAT 	\N		2018-04-05 12:57:42.743+00	2018-04-18 13:18:47.724+00	1
204	Jumping Light Magic Circle 	<p>Set Up&nbsp;</p>\r\n<p>Supine&nbsp;</p>	1 BLUE 	\N		2018-04-06 13:42:00.868+00	2018-04-18 13:18:47.724+00	1
202	Green Room Arms High Breast Stroke 	<p><u><strong>Set up</strong></u></p>\r\n<p>Sitting at bottom edge of carriage. Knees bent. Feet on Head Rest. Holding straps.Magic Circle between knees&nbsp;</p>\r\n<p><br></p>\r\n<p><u><strong>The Excercise&nbsp;</strong></u></p>\r\n<p>Inhale to prepare. Exhale roll back into C curve until Sacrum is in contact with carriage. Reach arms above head in breast stroke motion. Reteat or alternate directions.&nbsp;</p>\r\n<p><br></p>\r\n<p><em><strong>NOTE; Maintain C curve and deep core connection throughout.</strong></em></p>	1 BLUE 	\N		2018-04-05 13:18:44.903+00	2018-04-18 13:18:47.724+00	1
203	Jumping Light Magic Circle 	<p><u><strong>Set Up&nbsp;</strong></u></p>\r\n<p>Supine. Feet parallel on jump board with Magic Circle between ankles. Hands interlaced behind head in a chest lift.&nbsp;</p>\r\n<p><br></p>\r\n<p><u><strong>The Exercise</strong></u></p>\r\n<p>Feet &nbsp;parallel Magic Circle between ankles. &nbsp;Inhale bend knees. Exhale jump.&nbsp;</p>\r\n<p><br></p>\r\n<p><em><strong>NOTE; Keep legs and feet parallel thoughout jumping.&nbsp;</strong></em></p>	1 BLUE 	\N		2018-04-06 13:40:43.253+00	2018-04-18 13:18:47.724+00	1
205	Jump Magic Circle Driving 	<p><u><strong>Set Up&nbsp;</strong></u></p>\r\n<p>Supine. Feet parallel on jump board with Magic Circle between ankles. Hands interlaced behind head in a chest lift.&nbsp;</p>\r\n<p><br></p>\r\n<p><u><strong>The Exercise</strong></u></p>\r\n<p>Feet &nbsp;parallel Magic Circle between ankles. &nbsp;Inhale bend knees. Exhale jump rotate legs to the right and left before landing. Alternate directions.&nbsp;</p>\r\n<p><br></p>\r\n<p><em><strong>NOTE; Stay stable in chest lift.&nbsp;</strong></em></p>	1 BLUE 	\N		2018-04-06 13:53:29.781+00	2018-04-18 13:18:47.724+00	1
197	Rainbow Squats 	<p><u><strong>Set Up&nbsp;</strong></u></p>\r\n<p>On mat.&nbsp;</p>\r\n<p><br></p>\r\n<p><u><strong>The Exercise&nbsp;</strong></u></p>\r\n<p>Single leg squat back wide then "rainbow squat" untill back leg crosses squatting leg.</p>	MAT 	Rainbow Squats.jpg		2018-04-05 13:00:57.066+00	2018-07-03 11:00:55.504+00	1
188	Side Lying Glutes with Jump Board 	<p><u><strong>Set Up</strong></u></p>\r\n<p>Side Lying on carriage. Head resting on underneth arm or propped up on elbow. Both legs straight and pressing into center of jump board as though standing.&nbsp;</p>\r\n<p><br></p>\r\n<p><u><strong>The Exercise</strong></u></p>\r\n<p>Lift top leg up and down for 10. Circles in each direction for 10. Forward back for 10. Maintain string sidelying position. keeping body stablle and pelvis stacked.</p>\r\n<p><br></p>\r\n<p><em><strong>NOTE; This is not a jumping exercise but is coupled nicely with Side Lying Jumping.&nbsp;</strong></em></p>	1 BLUE 	Side Lying Glutes with Jump Board.jpg		2018-04-05 11:13:43.118+00	2018-07-03 11:12:44.756+00	1
199	Green Room Magic Circle Squeeze 	<p><u><strong>Set up</strong></u></p>\r\n<p>Sitting at bottom edge of carriage. Knees bent. Feet on Head Rest. Holding straps arms straight. Magic Circle between knees.</p>\r\n<p><br></p>\r\n<p><u><strong>The Excercise&nbsp;</strong></u></p>\r\n<p>Inhale to prepare. Exhale roll back into C curve until Sacrum is in contact with carriage. Hold position and squeeze magic circle 10 times. Exhale deepen core connection and roll up.&nbsp;</p>	1 BLUE	Green Room Magic Circle Sqeezes.jpg		2018-04-05 13:06:32.463+00	2018-07-03 11:45:03.489+00	1
201	Green Room Magic Circle Row 	<p><u><strong>Set up</strong></u></p>\r\n<p>Sitting at bottom edge of carriage. Knees bent. Feet on Head Rest. Straps crossed holding straps at knots. Elbows wide level with shoulders. Magic Circle between knees&nbsp;</p>\r\n<p><br></p>\r\n<p><u><strong>The Excercise&nbsp;</strong></u></p>\r\n<p>Inhale to prepare. Exhale roll back into C curve until Sacrum is in contact with carriage. Rowing arms 10 times. Return to set up.&nbsp;</p>	1 BLUE 	Green Room Magic Cricles Rows.jpg		2018-04-05 13:13:50.805+00	2018-07-03 11:45:18.552+00	1
198	Comandos 	<p><u><strong>Set Up&nbsp;</strong></u></p>\r\n<p>Plank on Mat&nbsp;</p>\r\n<p><br></p>\r\n<p><u><strong>The Exercise&nbsp;</strong></u></p>\r\n<p>From plank bring elbows down one at a time to an elbow plank then reverse back to straight arm plank.&nbsp;</p>\r\n<p><br></p>\r\n<p><em><strong>NOTE; Be mindful to maintain strong plank position thoughout exercise.&nbsp;</strong></em></p>	MAT 	Comandos.jpg		2018-04-05 13:05:07.056+00	2018-09-02 02:19:16.054+00	1
207	Side Lying Magic Circle Adductor Squeeze	<p><u><strong>Set Up</strong></u></p>\r\n<p>Side lying. Head rests on outstretched arm. Standing on center of jump board Magic Cirle between knees.&nbsp;</p>\r\n<p><br></p>\r\n<p><u><strong>The Exercise</strong></u></p>\r\n<p>Exhale squeeze Magic Circle. Be midful to squeeze top leg to bottom leg.</p>\r\n<p><br></p>\r\n<p><br></p>	1 RED 	\N		2018-04-06 14:03:43.036+00	2018-04-18 13:18:47.724+00	1
195	Jump Kneeling Legs Stag 	<p><u><strong>Set up</strong></u></p>\r\n<p>Quadruped with hands on shoulder rests. Neutral spine. Single leg extended onto jump board in external rotation. Rotate entire pelvis. Look towards foot.&nbsp;</p>\r\n<p><br></p>\r\n<p><u><strong>The exercise</strong></u></p>\r\n<p>Inhal prepare exhale jump in mid air flex hip and pull knee towards armpit to stag position.&nbsp;</p>	1 BLUE or 1 RED 	\N		2018-04-05 12:26:59.973+00	2018-04-18 13:18:47.724+00	1
210	Wide Squat Reach 	<p><u><strong>Set Up</strong></u>&nbsp;</p>\r\n<p>Legs wide. Hand weights optional.&nbsp;</p>\r\n<p><br></p>\r\n<p><u><strong>The Exercise</strong></u></p>\r\n<p>Wide squat reaching left arm to right ankle. Right arm reaches directly to ceiling. Alternate sides. To make it advanced add a jump squat inbetween each side reach.&nbsp;</p>	MAT	\N		2018-04-07 01:43:11.847+00	2018-04-18 13:18:47.724+00	1
212	Oblique Squeeze Magic Circle	<p><u><strong>Set Up&nbsp;</strong></u></p>\r\n<p>Single Leg on parallel on jump board, other leg at table top. Magic Circle pressing into table top knee oppisite hand holding Magic Circle in place other hand behing head.</p>\r\n<p><br></p>\r\n<p><u><strong>The Exercise&nbsp;</strong></u></p>\r\n<p>Come into a chest lift. Squeeze Magic Circle into table to knee and knee into Magic Circle activating adductors. 10 Squeezes each side.&nbsp;</p>	2 RED	\N		2018-04-07 01:51:43.01+00	2018-04-18 13:18:47.724+00	1
22	Jump Elbows Single Leg Single Arm 	<p><u><strong>Set Up</strong></u></p>\r\n<p>Supine on carriage. Elbows propped against shoulder rests in "poolside position". Hands on small of back or by hips.&nbsp;</p>\r\n<p><br></p>\r\n<p><u><strong>The Exercise</strong></u></p>\r\n<p>Exhale Jump. Reach arm out diagonally elbow straight opposite leg at Table Top. Bring elbow back to land. Alternate legs or keep going with same leg.&nbsp;</p>\r\n<p><br></p>\r\n<p><em><strong>NOTE; Regres by putting rolled up mat against shoulder rests and coming into a chest lift.&nbsp;</strong></em></p>	1 Blue	\N		2018-03-22 00:05:34+00	2018-04-18 13:18:47.724+00	1
217	Shoulder Press on Toes. 	<p><u><strong>Set Up&nbsp;</strong></u></p>\r\n<p>Standing on mat feet together holding hand weights.&nbsp;</p>\r\n<p><br></p>\r\n<p><u><strong>The Exercise</strong></u></p>\r\n<p>Squeesing legs together rising up onto balls of feet bend knees into demi squat. Bring arms to goal post position. Elbows 90/90. Press arms above head x 10, 3 sets.&nbsp;</p>	MAT 	\N		2018-04-07 09:07:20.632+00	2018-04-18 13:18:47.724+00	1
218	Sumo Squat	<p><u><strong>Set Up</strong></u>&nbsp;</p>\r\n<p>Standing on mat.&nbsp;</p>\r\n<p><br></p>\r\n<p><u><strong>The Exercise</strong></u>&nbsp;</p>\r\n<p>Jump into wide squat bring hands to floor between feet jump back into plank. Jump to wide squat with hands between feet. Jump legs together standing upright.&nbsp;</p>\r\n<p><br></p>\r\n<p><em><strong>NOTE; modify by taking out the jump and replace with stepping.&nbsp;</strong></em></p>	MAT	\N		2018-04-07 11:34:41.329+00	2018-04-18 13:18:47.724+00	1
219	Jump Elbows Single Legs 	<p><u><strong>Set Up</strong></u></p>\r\n<p>Supine on carriage. Elbows propped against shoulder rests in "poolside position". Hands on small of back or by hips. Gentle imprint of lumber spine.&nbsp;Single leg at Table Top&nbsp;</p>\r\n<p><br></p>\r\n<p><u><strong>The Exercise</strong></u></p>\r\n<p>Exhale Jump. Maintain "poolside" elbow position. Switch legs mid air.&nbsp;</p>\r\n<p><br></p>\r\n<p><em><strong>NOTE; Regres by putting rolled up mat against shoulder rests and coming into a chest lift.&nbsp;</strong></em></p>	1 Blue	\N		2018-04-07 11:41:13.06+00	2018-04-18 13:18:47.724+00	1
220	Jump Elbows Teaser 	<p><u><strong>Set Up</strong></u></p>\r\n<p>Supine on carriage. Elbows propped against shoulder rests in "poolside position". Hands on small of back or by hips.&nbsp;Both feet on jump board.</p>\r\n<p><br></p>\r\n<p><u><strong>The Exercise</strong></u></p>\r\n<p>Exhale Jump. Reach both arms out diagonally elbows straight to Teaser position. Bring elbow back to land.&nbsp;</p>\r\n<p><br></p>\r\n<p><em><strong>NOTE; Regres by putting rolled up mat against shoulder rests and coming into a chest lift.&nbsp;</strong></em></p>	1 Blue	\N		2018-04-07 12:04:51.539+00	2018-04-18 13:18:47.724+00	1
221	Plank to Pigeon 	<p><u><strong>Set Up</strong></u>&nbsp;</p>\r\n<p>Plank on mat.&nbsp;</p>\r\n<p><br></p>\r\n<p><u><strong>The Exercise</strong></u></p>\r\n<p>Exhale bring single leg forward into pigeon position. Inhale return to plank. Alternate legs.&nbsp;</p>	MAT	\N		2018-04-07 12:28:28.18+00	2018-04-18 13:18:47.724+00	1
222	1/2 Roll Back 	<p><u><strong>Set Up&nbsp;</strong></u></p>\r\n<p>Sitting on the mat knees bent feet flat on the floor holding single hand weight.&nbsp;</p>\r\n<p><br></p>\r\n<p><u><strong>The Exercise&nbsp;</strong></u></p>\r\n<p>Inhale to prepare. Exhale initiate roll back by imprinting the lumbar spine scooping low abs in and rolling back halfway. Inhale at bottom, exhale roll up.&nbsp;</p>\r\n<p><br></p>\r\n<p><em><strong>NOTE; Only go to point of control.&nbsp;</strong></em></p>	MAT 	\N		2018-04-07 13:07:54.47+00	2018-04-18 13:18:47.724+00	1
315	Reverse Stomach Massage Toes Wide 	<p><u><strong>Set Up&nbsp;</strong></u></p>\r\n<p>Seated in Foot Plate. Hands on Foot Bar. Toes wide turned out on carriage. Spine long.&nbsp;Holding blue ball reaching arms diagonally up. Gennle squueze in ball.&nbsp;</p>\r\n<p><br></p>\r\n<p><u><strong>The Exercise</strong></u></p>\r\n<p>Exhale press knees straight. Inhale bend.&nbsp;</p>	1 RED 1 BLUE 	\N		2018-04-10 06:36:23.111+00	2018-04-18 13:18:47.724+00	1
211	Chest Lift Feet on Jump Board	<p><u><strong>Set up</strong></u>&nbsp;</p>\r\n<p>Feet on center of jump board together. Legs straight. Hands interlaced behing head or holding Magic Circle optional.&nbsp;</p>\r\n<p><br></p>\r\n<p><u><strong>The Exercise</strong></u></p>\r\n<p>Inhale prepare, exhale lift head neck shoulders into a chest lift.&nbsp;</p>	2 RED	Chest Lift Feet on Jump Board.JPG		2018-04-07 01:49:35.87+00	2018-07-09 12:40:31.014+00	1
216	Side Lunge Over Head Press 	<p><u><strong>Set Up</strong></u>&nbsp;</p>\r\n<p>Standing wide on mat. Weights optional.&nbsp;</p>\r\n<p><br></p>\r\n<p><u><strong>The Exercise</strong></u>&nbsp;</p>\r\n<p>Shift weight to one side for side lunge push off bent (lunging side) come to single leg standing lunge leg ankle at knee press weights above head. Repeat.&nbsp;</p>	MAT	Side Lunge Over Head Press.jpg		2018-04-07 09:02:18.305+00	2018-09-02 02:19:02.212+00	1
223	Roll Back Oblique Twist Single Leg 	<p><u><strong>Set Up&nbsp;</strong></u></p>\r\n<p>Sitting on the mat knees bent feet flat on the floor holding single hand weight.&nbsp;</p>\r\n<p><br></p>\r\n<p><u><strong>The Exercise&nbsp;</strong></u></p>\r\n<p>Inhale to prepare. Exhale initiate roll back by imprinting the lumbar spine scooping low abs in and rolling back halfway. Rotate shoulders to the side taking weight to same side lift single leg to table top (same sibe weight is on). Alternate sides x 10 Roll back up.&nbsp;</p>\r\n<p><br></p>\r\n<p><em><strong>NOTE; Only go to point of control.&nbsp;</strong></em></p>	MAT 	\N		2018-04-07 13:09:23.305+00	2018-04-18 13:18:47.724+00	1
225	Plank to V 	<p><u><strong>Set Up&nbsp;</strong></u></p>\r\n<p>Elbow plank on mat.&nbsp;</p>\r\n<p><br></p>\r\n<p><u><strong>The Exercise&nbsp;</strong></u></p>\r\n<p>Exhale lift hips to inverted V Inhale return to elbow plank. &nbsp;x 10&nbsp;</p>	MAT 	\N		2018-04-07 13:17:20.032+00	2018-04-18 13:18:47.724+00	1
227	Side Plank Knee Bends 	<p><u><strong>Set Up&nbsp;</strong></u></p>\r\n<p>Side elbow plank on reformer. Be sure shoulder is over elbow. Feet on foot plate crossed at ankles top leg in front. Hand on hip.</p>\r\n<p><br></p>\r\n<p><u><strong>The Exercise</strong></u></p>\r\n<p>Squeezing adductors together bend knees. Maintain strong plank and shoulder alignment. Extend knees.&nbsp;</p>	1 BLUE or 1 RED 	\N		2018-04-07 13:25:51.583+00	2018-04-18 13:18:47.724+00	1
230	Booty Blast Pulses 	<p><u><strong>Set Up</strong></u></p>\r\n<p>Standing holding onto top of jump board or wall.&nbsp;</p>\r\n<p><br></p>\r\n<p><u><strong>The Exercise</strong></u></p>\r\n<p>Legs together feet parallel rise up onto balls of feet. Demi squat. Squeezing adductors together. Pulse down and up x 10&nbsp;</p>	MAT 	\N		2018-04-07 13:46:27.49+00	2018-04-18 13:18:47.724+00	1
231	Booty Blas Pelvic Tilt 	<p><u><strong>Set Up</strong></u></p>\r\n<p>Standing holding onto top of jump board or wall.&nbsp;</p>\r\n<p><br></p>\r\n<p><u><strong>The Exercise</strong></u></p>\r\n<p>Legs together feet parallel rise up onto balls of feet. Demi squat. Squeezing adductors together tuck pelvis under and release. x 10&nbsp;</p>\r\n<p><br></p>\r\n<p><em><strong>NOTES; Maintain squat thoughout.&nbsp;</strong></em></p>	MAT	\N		2018-04-07 13:49:07.34+00	2018-04-18 13:18:47.724+00	1
232	Booty Blast Leg Press 	<p><u><strong>Set Up</strong></u></p>\r\n<p>Standing holding onto top of jump board or wall.&nbsp;lean back elbows straight. Demi squat.&nbsp;</p>\r\n<p><br></p>\r\n<p><u><strong>The Exercise</strong></u></p>\r\n<p>Lift single leg behind knee bent. Foot pressing towards ceiling. Pulse leg up x 10. Focus is in the Glute activation and maintaing suppoting leg squat.&nbsp;</p>\r\n<p><br></p>	MAT	\N		2018-04-07 13:53:16.644+00	2018-04-18 13:18:47.724+00	1
233	Booty Blast Sides 	<p><u><strong>Set Up</strong></u></p>\r\n<p>Standing holding onto top of jump board or wall facing side.&nbsp;</p>\r\n<p><br></p>\r\n<p><u><strong>The Exercise</strong></u></p>\r\n<p>Lean in towards jump board or wall elbow may rest on jump board or wall. Demi squat lift outside leg. Pulse leg up towards ceiling keeping knee bent x 10&nbsp;</p>\r\n<p><br></p>\r\n<p><em><strong>NOTE; You may choose to repeat with a straight working leg.&nbsp;</strong></em></p>	MAT 	\N		2018-04-07 13:58:09.719+00	2018-04-18 13:18:47.724+00	1
234	Scooter on Long Box	<p><u><strong>Set Up&nbsp;</strong></u></p>\r\n<p>Long Box pressed up against the side of reformer closest to jump bpard or foot bar.&nbsp;Standing on Long Box other heel against shoulder rest. Knees bent. Pelvis aligned. Hands on Foot bar jump board or behing back.&nbsp;</p>\r\n<p><br></p>\r\n<p><u><strong>The exercise</strong></u></p>\r\n<p>Inhale to prepare. Exhale press heel into shoulder rest taking the hip into extension. Inhale return.&nbsp;</p>	1 BLUE or 1 RED	\N		2018-04-07 14:02:28.178+00	2018-04-18 13:18:47.724+00	1
237	Jump Star Jumps 	<p><u><strong>Set Up&nbsp;</strong></u></p>\r\n<p>Supine. Feet in small V or parallel. &nbsp;Arms by sides. Head rest comfortable or in a chest lift.&nbsp;</p>\r\n<p><br></p>\r\n<p><u><strong>The Exercise</strong></u></p>\r\n<p>Inhale bend knees. Exhale jump into star jump while mid air.&nbsp;</p>\r\n<p><br></p>\r\n<p><em><strong>NOTE You may choose Jump with chest lift&nbsp;</strong></em></p>\r\n<p><em><strong>Curl head neck shoulders into chest lift. Inhale bend knees. Exhale jump. Place soft ball under upper thoracic if jumping in chest lift for extended&nbsp;</strong></em></p>	1 BLUE 	\N		2018-04-07 14:15:06.403+00	2018-04-18 13:18:47.724+00	1
316	Reverse Stomach Massage Rises	<p><u><strong>Set Up&nbsp;</strong></u></p>\r\n<p>Seated in Foot Plate. Hands on Foot Bar. Toes parallel on carriage. Spine long.&nbsp;Holding blue ball reaching arms diagonally up. Gennle squueze in ball.&nbsp;</p>\r\n<p><br></p>\r\n<p><u><strong>The Exercise</strong></u></p>\r\n<p>Inhale calf stretch sending heels down. Exhale calf rise. Keeping legs straight.&nbsp;</p>	1 RED 1 BLUE 	\N		2018-04-10 06:38:19.999+00	2018-04-18 13:18:47.724+00	1
226	Leg Pull Front 	<p><u><strong>Set Up</strong></u></p>\r\n<p>Plank on mat.</p>\r\n<p><br></p>\r\n<p><u><strong>The Exercise</strong></u>&nbsp;</p>\r\n<p>Inahle to prepare. Exhale lift single straight leg up. Keep it low and pelvise alighned. Alternate legs.&nbsp;</p>\r\n<p><br></p>\r\n<p><em><strong>NOTE; Maintain good head neck and shoulder alignment. Come to elbows if there are wrist issues.&nbsp;</strong></em></p>	MAT 	Leg Pull Front.jpg		2018-04-07 13:21:36.748+00	2018-07-03 11:06:38.695+00	1
229	Side Plank Tree	<p><u><strong>Set Up&nbsp;</strong></u></p>\r\n<p>Side elbow plank on reformer. Be sure shoulder is over elbow. Feet on foot plate crossed at ankles top leg in front. Hand on hip.</p>\r\n<p><br></p>\r\n<p><u><strong>The Exercise</strong></u></p>\r\n<p>Lift top leg and place foot above or below supporting legs knee (never on the knee) &nbsp;Hold for 3 breaths.&nbsp;</p>\r\n<p><br></p>\r\n<p><em><strong>NOTE; Maintain good head neck and shoulder alignment.&nbsp;</strong></em></p>	1 BLUE or 1 RED 	Side Plank Tree.jpg		2018-04-07 13:33:05.957+00	2018-08-28 13:54:34.601+00	1
236	Jump Leg Circles	<p><u><strong>Set Up&nbsp;</strong></u></p>\r\n<p>Supine. Feet parallel. &nbsp;Arms by sides. Head rest comfortable or in a chest lift.&nbsp;</p>\r\n<p><br></p>\r\n<p><u><strong>The Exercise</strong></u></p>\r\n<p>Inhale bend knees. Exhale jump circle legs around while in mid air. Alternate directions or stay the same.&nbsp;</p>\r\n<p><br></p>\r\n<p><em><strong>NOTE You may choose Jump with chest lift&nbsp;</strong></em></p>\r\n<p><em><strong>Curl head neck shoulders into chest lift. Inhale bend knees. Exhale jump. Place soft ball under upper thoracic if jumping in chest lift for extended&nbsp;</strong></em></p>	1 BLUE 	Jump Footwork Circles.jpg		2018-04-07 14:11:43.848+00	2018-08-28 14:00:49.669+00	1
241	Pelvic Floor Activation 	<p><u><strong>Set Up</strong></u>&nbsp;</p>\r\n<p>Neutral spine supine on reformer or mat. Head rest comfortable. Arms by sides or resting on low belly. Feet on Foot bar or mat.&nbsp;</p>\r\n<p><br></p>\r\n<p><u><strong>The Exercise</strong></u></p>\r\n<p>Feel spine long, allow the natural curves of the spine to be present. The ASIS and Pubic Bone align. Release low ribs, widen the collar bones. Inhale relax, feel belly rise. Exhale draw sitbones together, draw pubic bone towards tail bone. Inhale release. Exhale "lift" pelvic flooras though stopping a wee. Inhale relese.&nbsp;</p>\r\n<p><br></p>\r\n<p><u><strong>Progression to Core Activation</strong></u></p>\r\n<p>Inhale relax exhale activate pelvic floor and &nbsp;cylindrically contract waist as though drawing a draw string tight around the navel. Inhale release. Exhale activate Pelvic Floor draw waist in and funnel low ribs down towards the navel. Inhale release belly. Exhale repeate the 3 steops to activate deep core. Keeping neck and shoulders relaxed.</p>\r\n<p><br></p>\r\n<p><em><strong>NOTE; There are many different ways to cue pelvic floor activation. Get creative and be sure to practice on yourself first.</strong></em></p>	2 RED or MAT 	\N		2018-04-08 10:51:35.06+00	2018-04-18 13:18:47.724+00	1
250	Kneeling Arm Series Sides Single Arm Hug A Tree	<p><u><strong>Set up</strong></u></p>\r\n<p>Kneeling towards the side of carriage. Side Facing. Knees pelvis distance apart. Spine and pelvis neutral. Strap in hand closest to head rest.</p>\r\n<p><br></p>\r\n<p><u><strong>The Exercise</strong></u></p>\r\n<p>Both hands in second position (only one hand has the strap) exhale hug a tree inhale release.&nbsp;</p>\r\n<p><br></p>\r\n<p><em><strong>NOTE; Progression is to pull into thoracic rotation as hugging the tree.</strong></em>&nbsp;</p>	1 BLUE 	\N		2018-04-08 12:12:14.279+00	2018-04-18 13:18:47.724+00	1
240	Roll Back Obliques 	<p><u><strong>Set Up</strong></u>&nbsp;</p>\r\n<p>Seated on the edge of Reformer knees bent feet flat on the ground. Reaching arms out in front of shoulders.&nbsp;</p>\r\n<p><br></p>\r\n<p><u><strong>The Exercise</strong></u></p>\r\n<p>Inhale prepare feel sitbones on the carriage. Exhale intitate roll back with a lumbur imprint roll back one vertebra at a time &nbsp;to point of control. Scoop the low belly towards spine. Feet remain on the floor.&nbsp;Hald way down reach single arm back to rotate thoracic spine and engage obliques. Inhale Return arms to front Exhale deepen core conection and roll back up. Repeat.&nbsp;</p>\r\n<p><br></p>\r\n<p><em><strong>NOTE; Putting a ball between the knees will deepen the core connection</strong></em>.&nbsp;</p>	2 RED 	Roll Back Obliques.jpg		2018-04-08 10:49:36.791+00	2018-06-14 10:49:17.815+00	2
238	Jump Peter Pan 	<p><u><strong>Set Up&nbsp;</strong></u></p>\r\n<p>Supine. Feet in small V. &nbsp;Arms by sides. Head rest comfortable or in a chest lift.&nbsp;</p>\r\n<p><br></p>\r\n<p><u><strong>The Exercise</strong></u></p>\r\n<p>Inhale bend knees. Exhale jump take one leg to the side, bend the other knee to the stag possition. Keep pelvis stable and neutral.&nbsp;</p>\r\n<p><br></p>\r\n<p><em><strong>NOTE You may choose Jump with chest lift&nbsp;</strong></em></p>\r\n<p><em><strong>Curl head neck shoulders into chest lift. Inhale bend knees. Exhale jump. Place soft ball under upper thoracic if jumping in chest lift for extended&nbsp;</strong></em></p>	1 BLUE 	Jump Peter Pan.JPG		2018-04-07 14:15:41.151+00	2018-07-09 12:52:56.319+00	1
239	Roll Back Round Back 	<p><u><strong>Set Up</strong></u>&nbsp;</p>\r\n<p>Seated on the edge of Reformer knees bent feet flat on the ground. Reaching arms out in front of shoulders.&nbsp;</p>\r\n<p><br></p>\r\n<p><u><strong>The Exercise</strong></u></p>\r\n<p>Inhale prepare feel sitbones on the carriage. Exhale intitate roll back with a lumbur imprint rolling back one vertebra at a time to point of control. Scoop the low belly towards spine. Inhale. Exhale deepen core control as you roll back up. Feet remain on the floor.&nbsp;</p>\r\n<p><br></p>\r\n<p><em><strong>NOTE; Putting a ball between the knees will deepen the core connection</strong></em>.&nbsp;</p>	2 RED 	Roll Back Round Back.jpg		2018-04-08 10:45:37.581+00	2018-06-14 10:48:36.985+00	2
251	Shoulder Press and Spine Extension 	<p><u><strong>Set Up</strong></u></p>\r\n<p>Lying prone on Long Box on Reformer. Hands on footbar shoulder distance apart. Legs together adductors active.&nbsp;</p>\r\n<p><br></p>\r\n<p><u><strong>The Exercise</strong></u></p>\r\n<p>Exhale bend elbows wide coming into shoulder press, extend elbows. Inhale keeping elbows straight lifting sternum into spine extension. Exhale lower. Repeat.</p>\r\n<p><br></p>\r\n<p><em><strong>NOTE; Keep the movemnt fluid. Let the springs pull the body into spine extension keeeping elbows straight.</strong></em>&nbsp;</p>	1 RED 	Spine Extension.JPG		2018-04-08 12:22:10.634+00	2018-07-09 12:11:57.979+00	2
245	Footwork Hip Circles 	<p><u><strong>Set up</strong></u></p>\r\n<p>Supine. Toes wide on foot bar knees in line with toes. Spine neutral. Arms by sides. Head rest comfortable.&nbsp;</p>\r\n<p><br></p>\r\n<p><u><strong>The exercise</strong></u></p>\r\n<p>Inhale to prepare. Exhale press toes into foot bar piviting on toes circle hips into internal rotation let knees come towards eachother as they straighten, externally rotale hips as knees bend back to starting point. &nbsp;After 10 &nbsp;hip circles alternate directions.&nbsp;</p>	3 RED 	Footwork Hip Circles.jpg		2018-04-08 11:55:31.311+00	2018-08-29 01:42:06.401+00	1
249	Feet in Straps Diamonds 	<p><u><strong>Set up</strong></u></p>\r\n<p>Supine. Spine and Pelvis Neutral. Feet in Straps at bottom of metatarsal arch. Head rest comfortable. &nbsp;Feet in V knees in like with second big toe.&nbsp;</p>\r\n<p><br></p>\r\n<p><u><strong>The exercise</strong></u></p>\r\n<p>Bend knees to diamond shape. Inhale keep diamond shape (knees bent) hinge at hips flexing hips. Exhale press back to set up position.&nbsp;</p>\r\n<p><br></p>\r\n<p><em><strong>NOTE; Maintain diamond shape thoughout. &nbsp;</strong></em></p>	1 BLUE 1 RED or 2 RED 	Feet in Straps Diamonds.jpg		2018-04-08 12:11:21.33+00	2018-09-01 01:40:53.566+00	1
244	Pelvic Curl Glide 	<p><u><strong>Set up</strong></u></p>\r\n<p>Supine. Heels on foot bar. Spine neutral. Arms by sides. Head rest down.&nbsp;</p>\r\n<p><br></p>\r\n<p><u><strong>The exercise</strong></u></p>\r\n<p>Inhale to prepare. Exhale move through imprint, curl tail bone to pubic bone, pubic bone to navle roll up 1 vertebra at a time to T6.&nbsp;Glide pelvice to left then right come back to center and down one vertebra repeat till sacrum is in contact with the mat. Be mindful to keep pelvis level during glide.&nbsp;</p>\r\n<p><br></p>\r\n<p><strong>NOTE &nbsp;Be sure not to roll into spine extension. Sink the sternum lift the Pubic Bone.&nbsp;</strong></p>\r\n<p><strong>Use the light spring setting for more hamstring connection, heavy spring for focus on spine articulation.</strong></p>	3 RED 	Pelvic Curl Glide.jpg		2018-04-08 11:49:14.089+00	2018-09-01 09:36:20.35+00	1
246	Elbows in Straps 	<p>Set Up&nbsp;</p>	3 RED 	Elbows in Straps.jpg		2018-04-08 11:57:24.779+00	2018-09-01 09:39:21.548+00	1
255	Cat Stretch 	<p><u><strong>Set up</strong></u></p>\r\n<p>Four Point kneeling facing foot bar.&nbsp;Knees at front of carriage toes relaxed. Hands of footplate. armpits over wrists hips over knees. Tesion in the spring. &nbsp;Spine neutral.</p>\r\n<p><br></p>\r\n<p><u><strong>The exercise</strong></u></p>\r\n<p>Exhlae spine moves into C curve flexion drawing belly to center pressing ribs to roof. Inhale move through neutral to spine extension opening chest.&nbsp;</p>\r\n<p><br></p>\r\n<p><u><strong>NOTE; Maintain tension in the springs holding knees and shoulders at 90/90 throughout the exercise.</strong></u>&nbsp;</p>	1 YELLOW or 1 BLUE 	\N		2018-04-08 13:15:06.509+00	2018-04-18 13:18:47.724+00	1
254	Breast Stroke Long Box No Straps 	<p><u><strong>Set up</strong></u></p>\r\n<p>Prone on long box legs stretched out long heels together or wide. Head towards foot bar. Foot bar down.</p>\r\n<p><br></p>\r\n<p><u><strong>The exercise</strong></u></p>\r\n<p>Both arms reaching past head. Elbows straight. Wrists shoulder distance apart. Circle arms around like breast stroke. Alternate directions.&nbsp;</p>\r\n<p><br></p>\r\n<p><em><strong>NOTE for advanced clients come into spine extension.</strong></em></p>	- 	\N		2018-04-08 13:09:01.629+00	2018-04-18 13:18:47.724+00	1
253	Swimming Long Box No Straps 	<p><u><strong>Set up</strong></u></p>\r\n<p>Prone on long box legs stretched out long heels together or wide. Head towards foot bar. Foot bar down.</p>\r\n<p><br></p>\r\n<p><u><strong>The exercise</strong></u></p>\r\n<p>Both arms reaching past head. Elbows straight. Wrists shoulder distance apart. Lift opposite arm and leg. Switch.&nbsp;</p>\r\n<p><br></p>\r\n<p><em><strong>NOTE for advanced clients come into spine extension.</strong></em></p>	-	\N		2018-04-08 13:07:54.852+00	2018-04-18 13:18:47.724+00	1
256	Cat Stretch Leg and Arm Reach 	<p><u><strong>Set up</strong></u></p>\r\n<p>Four Point kneeling facing foot bar.&nbsp;Knees at front of carriage toes relaxed. Hands of footplate. armpits over wrists hips over knees. Tesion in the spring. &nbsp;Spine neutral. &nbsp;Foot bard down.&nbsp;</p>\r\n<p><br></p>\r\n<p><u><strong>The exercise</strong></u></p>\r\n<p>Maintaining a neutral spine reach opposite arm and leg away from eachother. Maintain hips and shoulders at 90/90&nbsp;</p>	1 YELLOW or 1 BLUE 	\N		2018-04-08 13:20:42.36+00	2018-04-18 13:18:47.724+00	1
268	Reverse Strap Abs Chest Lift	<p><u><strong>Set Up</strong></u>&nbsp;</p>\r\n<p>Sitting on carriage. Straps around thighs just above knees. Sit bones as close to shoulder rests as possible, roll back into chest lift position legs at table top. Holding tension on strap. Imprint low back.&nbsp;</p>\r\n<p><br></p>\r\n<p><u><strong>The Exercise&nbsp;</strong></u></p>\r\n<p>Exhale lift into chest lift. Hold legs stable at table top keeping tension on the straps. Inhale release headnck shoulders down. Exhale chest lift. Repeat.&nbsp;</p>	1 BLUE or 1 RED 	\N		2018-04-09 00:22:12.619+00	2018-04-18 13:18:47.724+00	1
312	Seated Roll Down Shoulder Press 	<p><u><strong>Set Up&nbsp;</strong></u></p>\r\n<p>Sitting straddling reformer sitbones on Foot Plate. Hands on long box.&nbsp;</p>\r\n<p><br></p>\r\n<p><u><strong>The Exercise</strong></u></p>\r\n<p>Inhale prepare exhale initiate roll down by nodding chin to throat. Begin to press away long box as core connection deepens rolling down one vertebra at a time. Inhale bend elbows. Exhale shoulder press by extending elbows.Repeat.&nbsp;</p>	1 YELLOW 1 BLUE 	\N		2018-04-10 06:25:05.471+00	2018-04-18 13:18:47.724+00	1
261	Reverse Plank Shoulders 	<p><u><strong>Set Up</strong></u>&nbsp;</p>\r\n<p>Standing on footplate. Bring elbos to just infront of shoulder rests interlace hands and rest on head rest. Shoulders over elbows. Press into elbow plank.&nbsp;</p>\r\n<p><br></p>\r\n<p><u><strong>The Exercise</strong></u></p>\r\n<p>Inhale prepare. Exhale press elbows away in hale draw elbows back to set up. Maintain plank position. &nbsp;</p>	1 RED	Reverse Plank Shoulders.jpg		2018-04-08 13:47:55.783+00	2018-09-01 01:43:10.986+00	1
265	Hands in Straps with Blue Ball Up an Down	<p><u><strong>Set up</strong></u></p>\r\n<p>Supine. Blue Ball under sacrum. Hands in straps reaching to ceiling. Legs table top. Head rest comfortable. Engage abdominals by imprinting lumbar spine.&nbsp;</p>\r\n<p><br></p>\r\n<p><u><strong>The Exercise</strong></u></p>\r\n<p>Inhale to prepare. Exhale press the hands down to sides Inhale return x 2. Reach right leg long keeping left leg at table top continue pressing arms up and down x 4. switch legs x 4.</p>\r\n<p><br></p>\r\n<p><em><strong>NOTE; Advanced both legs reaching straight to point of control.&nbsp;</strong></em></p>	1 RED 1 BLUE or 2 RED 	Hands in Straps with blue ball up down.jpg		2018-04-08 14:11:57.809+00	2018-07-03 12:15:21.762+00	2
262	Roll Down Walk Out Push Up 	<p><u><strong>Set Up&nbsp;</strong></u></p>\r\n<p>Standing on mat. Feet parallel hip distance apart.&nbsp;</p>\r\n<p><br></p>\r\n<p><u><strong>The Exercise</strong></u></p>\r\n<p>Inhale prepare. Exhale nod chin to throat and roll dowm one vertebra at a time. Hands come to floor. Walk hands out into plank position exhlae push up. walk hands back lifting hips. Roll up one vertebra at a time knees soft. Repeat.&nbsp;</p>\r\n<p><br></p>\r\n<p><em><strong>NOTE; To modify come down to knees in push up position</strong></em>.&nbsp;</p>	MAT 	Roll Down walk Out Push Up.jpg		2018-04-08 14:02:28.149+00	2018-07-03 11:03:45.361+00	2
260	Reverse Plank Knee Bends	<p><u><strong>Set Up</strong></u>&nbsp;</p>\r\n<p>Standing on footplate. Bring elbos to just infront of shoulder rests interlace hands and rest on head rest. Shoulders over elbows. Press into elbow plank.&nbsp;</p>\r\n<p><br></p>\r\n<p><u><strong>The Exercise</strong></u></p>\r\n<p>Inhale prepare. Exhale dip knees into well. letting carriage draw in. Extend knees and hips to set up position. Maintain plank thoughout.&nbsp;</p>	1 RED	Reverse Plank Knee Bends.jpg		2018-04-08 13:46:07.287+00	2018-09-01 04:48:49.054+00	1
258	Phoenix Warrior 	<p><u><strong>Set Up&nbsp;</strong></u></p>\r\n<p>Standing beside carriage. Single leg resting in high heel postition heel on shoulder rest. Arms by side.&nbsp;</p>\r\n<p><br></p>\r\n<p><u><strong>The Exercise</strong></u>&nbsp;</p>\r\n<p>Inhale reach arms to ceiling to prayer position. Exhale bring arms to front of heart at the same time press the bed back into lunge chest comes to bent knee bringing hands either side of foot on floor. Maintain lunge reach arms up to ceiling &nbsp;into warrior 1 possition hold here for 3 breaths. Bring hands back down to either side of the foot. Chest to thigh. Straighten leg (supporting leg) and keep chest on thigh hold forward bend and take 3 breathes. Reach arms back up to ceiling roll up. Repeat 5 times. Then change sides.&nbsp;</p>	1 RED 	Phoenix Warrior.jpg		2018-04-08 13:40:49.056+00	2018-09-01 09:48:21.612+00	1
269	Reverse Strap Abs Knee Pull 	<p><u><strong>Set Up</strong></u>&nbsp;</p>\r\n<p>Sitting on carriage. Straps around thighs just above knees. Sit bones as close to shoulder rests as possible, roll back. Come into chest lift position legs at table top. Holding tension on strap. Imprint low back.&nbsp;</p>\r\n<p><br></p>\r\n<p><u><strong>The Exercise&nbsp;</strong></u></p>\r\n<p>Exhale lift into chest lift. Pull knees towards chest, inhale release to table top. Maintain chest lift. &nbsp;</p>	1 BLUE or 1 RED	\N		2018-04-09 00:24:19.379+00	2018-04-18 13:18:47.724+00	1
271	Kneeling Arm Side Series Circles 	<p><u><strong>Set up</strong></u></p>\r\n<p>Kneeling towards the side of carriage, facing side. Knees pelvis distance apart. Spine and pelvis neutral. Holing hand strap in hand closest to head rest.&nbsp;</p>\r\n<p><br></p>\r\n<p><u><strong>The Exercise</strong></u></p>\r\n<p>Abducting arm full circle straight (or elbow slightly bent) &nbsp;arm around above head and across body. Repeat then alternate direction.&nbsp;</p>	1 YELLOW or 1 BLUE or 1 RED 	\N		2018-04-09 00:29:37.139+00	2018-04-18 13:18:47.724+00	1
272	Kneeling Arm Side Series Straight Arm Rotation 	<p><u><strong>Set up</strong></u></p>\r\n<p>Kneeling towards the side of carriage facing side. Knees pelvis distance apart. Spine and pelvis neutral. Holing hand strap closest to head rest. Arm straight at shoulder hight. Other hand behind head.&nbsp;</p>\r\n<p><br></p>\r\n<p><u><strong>The Exercise&nbsp;</strong></u></p>\r\n<p>Inhale prepare. Exhale Rotate torso towards foot bar pulling strap. Maintain set up position through rotation.&nbsp;</p>	1 YELLOW or 1 BLUE or 1 RED 	\N		2018-04-09 00:36:38.518+00	2018-04-18 13:18:47.724+00	1
275	Feet in Straps Single Strap Up Down 	<p><u><strong>Set up</strong></u></p>\r\n<p>Supine. Spine and Pelvis Neutral. Single foot in Strap at bottom of metatarsal arch. Head rest comfortable. &nbsp;Feet Parallel legs straight. Start at 45 degrees.</p>\r\n<p><br></p>\r\n<p><u><strong>The exercise</strong></u></p>\r\n<p>Inhale lift straight legs to as close to 90 degrees at hips while maintaining neutral spine. Exhale press straight legs down as thought there are straps on both legs.&nbsp;</p>\r\n<p><br></p>\r\n<p><em><strong>NOTE Be sure to maintain neutral pelvis as legs move. If the pelvis is moving this is an idication that the core is not engaged correctly. Decrease the range or change the spring settings.&nbsp;</strong></em></p>	1 RED or 1 RED 1 BLUE 	\N		2018-04-09 01:07:32.214+00	2018-04-18 13:18:47.724+00	1
270	Feet in Straps Wide Circles	<p><u><strong>Set up</strong></u></p>\r\n<p>Supine. Spine and Pelvis Neutral. Feet in Straps at bottom of metatarsal arch. Head rest comfortable. Legs 45 degrees. Heel together legs straight.</p>\r\n<p><br></p>\r\n<p><u><strong>The Exercise</strong></u>&nbsp;</p>\r\n<p>Abduct legs wide. Circles as wide as dinner plates maintaining abducted legs.&nbsp;</p>\r\n<p><br></p>\r\n<p><em><strong>NOTE; Stop if there is pain in the pubic bone.</strong></em></p>	1 RED 1 BLUE or 2 RED 	\N		2018-04-09 00:25:10.45+00	2018-04-18 13:18:47.724+00	1
274	Feet in Straps Single Strap Frog 	<p><u><strong>Set up</strong></u></p>\r\n<p>Supine. Spine and Pelvis Neutral. Single foot in Strap at bottom of metatarsal arch. Head rest comfortable. &nbsp;Feet in V knees in like with second big toe Legs straight.&nbsp;</p>\r\n<p><br></p>\r\n<p><u><strong>The exercise</strong></u></p>\r\n<p>Inhale bend knees to small frog. Exhale press foot into strap to straight legs. Move as though there are straps on booth feet. Spine and Pelvis maintain neutral.&nbsp;</p>\r\n<p><br></p>\r\n<p>NOTE; Keep spring light for more abdominal challenge.&nbsp;</p>	1 RED or 1 RED 1 BLUE  	\N		2018-04-09 00:59:47.559+00	2018-04-18 13:18:47.724+00	1
273	Feet in Straps Single Strap Up Down 	<p><u><strong>Set up</strong></u></p>\r\n<p>Supine. Spine and Pelvis Neutral. Single foot in Straps at bottom of metatarsal arch. Head rest comfortable. &nbsp;Feet Parallel legs straight. Start at 45 degrees.</p>\r\n<p><br></p>\r\n<p><u><strong>The exercise</strong></u></p>\r\n<p>Inhale lift straight legs to as close to 90 degrees at hips while maintaining neutral spine. Exhale press straight legs down.&nbsp;Feel as though there are straps on both feet.&nbsp;</p>	1 RED or 1 RED and 1 BLUE 	\N		2018-04-09 00:56:57.751+00	2018-04-18 13:18:47.724+00	1
276	Reverse Box Plank Knees 	<p><u><strong>Set Up</strong></u>&nbsp;</p>\r\n<p>Foot Bar at gear 2 and 3rd position. Short Box resting on foot bar and foot plank. Elbows on box on shoulder rests , knees resting on bed. Spine neutral, head in line with spine.&nbsp;</p>\r\n<p><br></p>\r\n<p><u><strong>The Exercise&nbsp;</strong></u></p>\r\n<p>Inhale prepare Exhlae extend knees and come into plank position. Inhale bend knees, exhale extend knees.&nbsp;</p>\r\n<p><br></p>\r\n<p><em><strong>NOTE; To modify keep knees on bed thoughout.&nbsp;</strong></em></p>	1 RED 	\N		2018-04-09 01:10:19.37+00	2018-04-18 13:18:47.724+00	1
278	Reverse Box Plank Single Leg Lift 	<p><u><strong>Set Up</strong></u>&nbsp;</p>\r\n<p>Foot Bar at gear 2 and 3rd position. Short Box resting on foot bar and foot plank. Elbows on box on shoulder rests , knees resting on bed. Spine neutral, head in line with spine.&nbsp;</p>\r\n<p><br></p>\r\n<p><u><strong>The Exercise&nbsp;</strong></u></p>\r\n<p>Extend knees and come into plank position. Exhale lift single leg. Inhale return. Repeat.</p>\r\n<p><br></p>	1 RED	\N		2018-04-09 01:25:04.149+00	2018-04-18 13:18:47.724+00	1
277	Reverse Box Plank Shoulders 	<p><u><strong>Set Up</strong></u>&nbsp;</p>\r\n<p>Foot Bar at gear 2 and 3rd position. Short Box resting on foot bar and foot plank. Elbows on box on shoulder rests , knees resting on bed. Spine neutral, head in line with spine.&nbsp;</p>\r\n<p><br></p>\r\n<p><u><strong>The Exercise&nbsp;</strong></u></p>\r\n<p>Extend knees and come into plank position. Exhale Press elbows into box pressing body back coming into shoulder flexion. Inhale return. Repeat.</p>\r\n<p><br></p>\r\n<p><em><strong>NOTE; To modify keep knees on bed thoughout.&nbsp;</strong></em></p>	1 RED 	\N		2018-04-09 01:20:50.765+00	2018-04-18 13:18:47.724+00	1
279	Scooter on Long Box with Thera Band Shoulder Rest 1	<p><u><strong>Set Up&nbsp;</strong></u></p>\r\n<p>Long Box pressed up against the side of reformer closest to foot bar.&nbsp;Standing on Long Box leg closest to reformer heel against shoulder rest 1 (closest). Knees bent. Pelvis aligned. Thera Band looped around foot bar. Holding Thera Band.</p>\r\n<p><br></p>\r\n<p><u><strong>The exercise</strong></u></p>\r\n<p>Inhale to prepare. Exhale press heel into shoulder rest taking the hip into extension.Pulling thera Band towards hips, elbows squeeing back.&nbsp;</p>	1 RED or 1 RED 1 BLUE 	\N		2018-04-09 01:44:03.095+00	2018-04-18 13:18:47.724+00	1
314	Reverse Stomach Massage Heels 	<p><u><strong>Set Up&nbsp;</strong></u></p>\r\n<p>Seated in Foot Plate. Hands on Foot Bar. Heels parrallel on carriage, blue ball between ankles. Spine long.&nbsp;</p>\r\n<p><br></p>\r\n<p><u><strong>The Exercise</strong></u></p>\r\n<p>Exhale press knees straight. Inhale bend.&nbsp;</p>	1 RED 1 BLUE 	\N		2018-04-10 06:34:40.039+00	2018-04-18 13:18:47.724+00	1
280	Scooter on Long Box With Thera Band Shoulder Rest 2 	<p><u><strong>Set Up&nbsp;</strong></u></p>\r\n<p>Long Box pressed up against the side of reformer closest to foot bar.&nbsp;Standing on Long Box leg closest to reformer heel against shoulder rest 2 (furthest away) Knees bent. Pelvis aligned. Thera Band looped around foot bar. Holding Thera Band.</p>\r\n<p><br></p>\r\n<p><u><strong>The exercise</strong></u></p>\r\n<p>Inhale to prepare. Exhale press heel into shoulder rest taking the hip into extension.Pulling thera Band towards hips, elbows squeeing back.&nbsp;</p>	1 RED or 1 RED 1 BLUE 	\N		2018-04-09 01:47:02.721+00	2018-04-18 13:18:47.724+00	1
283	Phoenix Lunge Arm Pulls 	<p><u><strong>Set Up&nbsp;</strong></u></p>\r\n<p>Standing on<strong> right </strong>side of Reformer holding strap with <strong>left </strong>arm. Diagonally face pulleys. Lunge <strong>right</strong> leg back <strong>left</strong> arm is straight.&nbsp;</p>\r\n<p><br></p>\r\n<p><u><strong>The Exercise&nbsp;</strong></u></p>\r\n<p>Exhale pull strap towards hip elbow pressing back maintain deep lunge release strap elbow extends. Exhale pull strap back inhale release. x 10</p>\r\n<p><br></p>\r\n<p><em><strong>NOTE; Repeat other side or continue with Phoenix Lunge Series and then repeat.&nbsp;</strong></em></p>	1 YELLOW or 1 BLUE or 1 RED 	\N		2018-04-09 02:06:16.319+00	2018-04-18 13:18:47.724+00	1
290	Hands In Straps Magic Circle 	<p><u><strong>Set up</strong></u></p>\r\n<p>Supine. Magic Circle in hands and hands in straps. Spine neutral. Legs table top. Head rest comfortable. If the core is not strong enough lumbar spine can imprint otherwise neutral pelvis.&nbsp;</p>\r\n<p><br></p>\r\n<p><u><strong>The Exercise&nbsp;</strong></u></p>\r\n<p>Exhale press Magic Circle towards knees. Inhale return. x 8 Exhale come up into a chest lift pressing arms over knees towards shins. x 10&nbsp;</p>\r\n<p><br></p>\r\n<p><em><strong>NOTE; Keep a gentle press on the Magic Circle at all times.&nbsp;</strong></em></p>	1 RED 1 BLUE or 2 RED 	\N		2018-04-09 02:39:35.841+00	2018-04-18 13:18:47.724+00	1
288	Pelvic Curl Press Magic Circle 	<p><u><strong>Set up</strong></u></p>\r\n<p>Supine. Heels on foot bar. Spine neutral. Arms by sides. Head rest down.&nbsp;Magic Circle between knees.&nbsp;</p>\r\n<p><br></p>\r\n<p><u><strong>The exercise</strong></u></p>\r\n<p>Inhale to prepare. Exhale move through imprint, curl tail bone to pubic bone, pubic bone to navle roll up 1 vertebra at a time to T6.&nbsp;Once at top Squeeze Magic Circle and press extending knees to straight legs. Inhale return.&nbsp;</p>\r\n<p><br></p>\r\n<p><strong>NOTE &nbsp;Be sure not to roll into spine extension. Sink the sternum lift the Pubic Bone.&nbsp;</strong></p>\r\n<p><strong>Use the light spring setting for more hamstring connection, heavy spring for focus on spine articulation.&nbsp;</strong></p>	1 RED 	\N		2018-04-09 02:30:43.946+00	2018-04-18 13:18:47.724+00	1
295	Kneeling Press Magic Circle 	<p><u><strong>Set Up</strong></u></p>\r\n<p>Kneeling on carriage facing foot bar. Sitting on heels. Holding Magic Circle hands in straps elbows bent.&nbsp;</p>\r\n<p><br></p>\r\n<p><u><strong>The Exercise&nbsp;</strong></u></p>\r\n<p>Inhale prepare. Exhale press arms forwad. Inhale return elbows glide along body.&nbsp;</p>	1 BLUE or 1 RED 	\N		2018-04-09 03:19:08.272+00	2018-04-18 13:18:47.724+00	1
293	Feet in Straps Magic Circle Lid on a Box 	<p><u><strong>Set up</strong></u></p>\r\n<p>Supine. Spine and Pelvis Neutral. Feet in Straps at bottom of metatarsal arch Magic Circle between ankles. Head rest comfortable. Legs parallel and straight.&nbsp;</p>\r\n<p><br></p>\r\n<p><u><strong>The Exercise</strong></u></p>\r\n<p>Inhale hips come into flexion to create L shape or as close to as possibble. Exhale leave thighs still bending knees to create table top position inhale extend knees. Shins are the lid on the box.&nbsp;Gentle squeeze of Magic Circle thoughout.&nbsp;</p>\r\n<p><br></p>\r\n<p><em><strong>NOTE; Modify to 45 degrees if hamstrings are not long enough.&nbsp;</strong></em></p>	1 RED 1 BLUE or 2 RED 	Feet in Straps Lid on a Box.jpg		2018-04-09 02:57:32.119+00	2018-08-28 22:53:48.314+00	1
292	Feet in Straps Magic Circle Frogs 	<p><u><strong>Set up</strong></u></p>\r\n<p>Supine. Spine and Pelvis Neutral. Feet in Straps at bottom of metatarsal arch Magic Circle between ankles. Head rest comfortable. &nbsp;Feet in V knees in like with second big toe.&nbsp;Legs bent.</p>\r\n<p><br></p>\r\n<p><u><strong>The exercise</strong></u></p>\r\n<p>Exhale press feet into straps to extend knees. Spine and Pelvis maintain neutral. Push equal pressure in both feet.&nbsp;Gentle squeeze of Magic Circle thoughout.&nbsp;</p>	1 RED 1 BLUE or 2 RED 	Feet in Straps Magic Circle Frogs.jpg.jpg		2018-04-09 02:51:55.38+00	2018-08-28 22:52:11.794+00	1
285	Magic Circle Adductor Squeeze 	<p><u><strong>Set Up</strong></u>&nbsp;</p>\r\n<p>Supine on carriage. Head rest comfortable arms by sides. Feet on foot plate parallel. Magic Circle between knees. Neutral Spine.&nbsp;</p>\r\n<p><br></p>\r\n<p><u><strong>The Exercise&nbsp;</strong></u></p>\r\n<p>Exhale squeeze Magic Circle. Inhale release. x 10. Squeeze small pulses with rhythmic exhalation x 10&nbsp;</p>\r\n<p><br></p>\r\n<p><em><strong>NOTE; Squeeze Magic Circle with entire inner thigh not just where the Circle is in contact with the knees.&nbsp;</strong></em></p>	3 RED 	Magic Circle Adductor Squeeze.jpg		2018-04-09 02:27:10.007+00	2018-08-28 22:56:30.387+00	1
289	Pelvic Curl Magic Circle Push 	<p><u><strong>Set up</strong></u></p>\r\n<p>Supine. Heels on foot bar. Spine neutral. Arms by sides. Head rest down.&nbsp;Magic Circle on outside of knees (step legs through the middle) &nbsp;</p>\r\n<p><br></p>\r\n<p><u><strong>The exercise</strong></u></p>\r\n<p>Inhale to prepare. Exhale move through imprint, curl tail bone to pubic bone, pubic bone to navle roll up 1 vertebra at a time to T6.&nbsp;Once at top press knees out into Magic Circle (Abducting hips)&nbsp;</p>\r\n<p>&nbsp;x 10&nbsp;</p>\r\n<p><strong>NOTE &nbsp;Be sure not to roll into spine extension. Sink the sternum lift the Pubic Bone.&nbsp;</strong></p>\r\n<p><strong>Use the light spring setting for more hamstring connection, heavy spring for focus on spine articulation.&nbsp;</strong></p>	1 RED 	Pelvic Curl Magic Circle Push.jpg		2018-04-09 02:37:56.841+00	2018-08-28 23:01:54.375+00	1
296	Kneeling Triceps Magic Circle 	<p><u><strong>Set Up</strong></u></p>\r\n<p>Kneeling on carriage facing foot bar. Sitting on heels. Holding Magic Circle hands in straps elbows bent.&nbsp;</p>\r\n<p><br></p>\r\n<p><u><strong>The Exercise&nbsp;</strong></u></p>\r\n<p>Inhale prepare. Exhale press arms forward squeeze glutes and come up to kneeling. Continue to press arms up to 45 degrees. Inhale bend elbows Magic Circle comes towards head. Exhale extend elbows. Repeat.&nbsp;</p>\r\n<p><br></p>\r\n<p><em><strong>NOTE; Gently pitch body forward during tricep press.</strong></em>&nbsp;</p>	1 BLUE or 1 RED 	\N		2018-04-09 03:22:30.458+00	2018-04-18 13:18:47.724+00	1
297	Green Room Magic Circle Arms	<p><u><strong>Set up</strong></u></p>\r\n<p>Sitting at bottom edge of carriage. Knees bent. Feet on Head Rest. Holding Magic Circle hands in straps in bicep curl. Elbows level with shoulders.&nbsp;</p>\r\n<p><br></p>\r\n<p><u><strong>The Excercise&nbsp;</strong></u></p>\r\n<p>Inhale to prepare. Exhale roll back into C curve until Sacrum is in contact with carriage. Inhale extend elbows. Exhale gentle bicep curl x10 and squeeze magic circle in hands at same time.&nbsp;</p>	1 BLUE 	\N		2018-04-09 03:26:14.43+00	2018-04-18 13:18:47.724+00	1
298	Green Room Magic Circle Oblique Twist 	<p><u><strong>Set up</strong></u></p>\r\n<p>Sitting at bottom edge of carriage. Knees bent. Feet on Head Rest. Holding Magic Circle hands in straps in bicep curl. Elbows level with shoulders. Sitting tall. &nbsp;</p>\r\n<p><br></p>\r\n<p><u><strong>The Exercise</strong></u></p>\r\n<p>Exhale roll back into C curve until Sacrum is in contact with carriage. Take knees to left rotate thoracic to right. Inhale extend elbows. Exhale gently rainbow arms over head to other side sending knees in opposite direction x10.&nbsp;</p>	1 BLUE 	\N		2018-04-09 03:27:06.601+00	2018-04-18 13:18:47.724+00	1
299	Rowing Back Series 2 Flat Back Magic Circle 	<p><u><strong>Set up</strong></u></p>\r\n<p>Sitting tall on carriage legs long through shoulder rests or knees bent feet on head rest. Holding Magic Circle Hands in Straps.&nbsp;</p>\r\n<p><br></p>\r\n<p><u><strong>The Exercise&nbsp;</strong></u></p>\r\n<p>Arms at 90/90. Hinge at hips maintaining flat back to a point of control. Exhale extend elbows and reach hands above head. Inhale returners to 90/90. Repeat&nbsp;Gently squeezing Magic Circle throughout.&nbsp;</p>	1 RED	\N		2018-04-09 03:32:05.357+00	2018-04-18 13:18:47.724+00	1
300	Dart Magic Circle 	<p><u><strong>Set Up&nbsp;</strong></u></p>\r\n<p>Prone on Long Box. Holding Magic Circle in hands behind back. Elbows straight. Legs straight and active.&nbsp;</p>\r\n<p><br></p>\r\n<p><u><strong>The Exercise&nbsp;</strong></u></p>\r\n<p>Inhale prepare. Exhale squeeze Magic Circle drawing scapular towards eachother feel as though shoulders are externally rotating. Lift from crown of head into spine extension. Exhale return to set up.&nbsp;</p>\r\n<p><br></p>\r\n<p><em><strong>NOTE; Make sure there is equal extension from nexk to mid thoracic. Dont hyper extend neck.&nbsp;</strong></em></p>	1 RED	\N		2018-04-09 03:41:03.309+00	2018-04-18 13:18:47.724+00	1
294	Kneeling Serving Magic Circle	<p><u><strong>Set Up</strong></u></p>\r\n<p>Kneeling on carriage facing foot bar. Sitting on heels. Holding Magic Circle hands in straps elbows bent hands close to waist.&nbsp;</p>\r\n<p><br></p>\r\n<p><u><strong>The Exercise&nbsp;</strong></u></p>\r\n<p>Inhale prepare. Exhale press arms forward squeeze glutes and come up to kneeling. Continue to press arms up to 45 degrees. Inhale return to set up. Repeat.&nbsp;</p>	1 BLUE or 1 RED 	\N		2018-04-09 03:14:09.858+00	2018-04-18 13:18:47.724+00	1
305	Balance Combo Part 1 Plié	<p><u><strong>Set Up</strong></u>&nbsp;</p>\r\n<p>Standing wide on mat hips and feet externally rotate 45 degrees second position. Holding Magic Circle infront of chest elbows bent.&nbsp;</p>\r\n<p><br></p>\r\n<p><u><strong>The Exercise</strong></u></p>\r\n<p>Bend knees into half squat (Plié) at the same time squeeze Magic Circle. &nbsp;Exhale straighten knees. Repeat. x 10&nbsp;</p>\r\n<p><br></p>\r\n<p><em><strong>NOTE; Advanced come onto balls of feet.</strong></em></p>	MAT 	\N		2018-04-09 04:12:45.522+00	2018-04-18 13:18:47.724+00	1
306	Balance Combo Part 2 Lunge	<p><u><strong>Set Up</strong></u></p>\r\n<p>Trun body to side. &nbsp;Magic Circle out stretched infront of body.&nbsp;</p>\r\n<p><br></p>\r\n<p><u><strong>The Exercise</strong></u></p>\r\n<p>Lunge knee to as low to the ground as there is control. Keep front knee in line with the ankle.&nbsp;</p>	MAT	\N		2018-04-09 10:46:31.466+00	2018-04-18 13:18:47.724+00	1
307	Balance Combo Part 3 Hip Extension	<p><u><strong>Set Up</strong></u>&nbsp;</p>\r\n<p>Bing weight into front leg.&nbsp;</p>\r\n<p><br></p>\r\n<p><u><strong>The Exercise</strong></u></p>\r\n<p>Lift back leg into hip extension. Supporting leg is straight. Lift and lower back leg.&nbsp;</p>	MAT 	\N		2018-04-09 10:47:54.524+00	2018-04-18 13:18:47.724+00	1
264	Roll Up with Thera Band 	<p><u><strong>Set Up&nbsp;</strong></u></p>\r\n<p>Lying supine on mat. Holding onto Thera Band. Thera Band around feet.&nbsp;</p>\r\n<p><br></p>\r\n<p><u><strong>The Exercise</strong></u></p>\r\n<p>Inhale prepare, exhale nod chin to throat roll up one vertebra at a time. Sitting up on sit bones. Inhale at top, Exhale roll back.&nbsp;</p>\r\n<p><br></p>\r\n<p><u><strong>NOTE; Use the Thera Bands to deepen core connection and spine articulation.</strong></u></p>	MAT 	\N		2018-04-08 14:10:31.599+00	2018-04-18 13:18:47.724+00	1
309	Roll Up with Blue Ball 	<p><u><strong>Set Up&nbsp;</strong></u></p>\r\n<p>Lying supine on mat. Blue Ball under ankles, pressing down into ball. Hands reaching to ceiling.&nbsp;</p>\r\n<p><br></p>\r\n<p><u><strong>The Exercise</strong></u></p>\r\n<p>Inhale prepare, exhale nod chin to throat roll up one vertebra at a time reaching arms forward. Sitting up &nbsp;on sit bones. Inhale at top. Exhale roll back.&nbsp;</p>	MAT 	\N		2018-04-09 11:45:04.492+00	2018-04-18 13:18:47.724+00	1
308	Rolling Like a Ball 	<p><u><strong>Set Up</strong></u>&nbsp;</p>\r\n<p>Sitting on mat ball&nbsp;inbetween calves and hanstrings. Hands on&nbsp;knees. Feet off floor sitting in ballance point.&nbsp;</p>\r\n<p><br></p>\r\n<p><u><strong>The Exercise</strong></u></p>\r\n<p>Inhale prepare, Exhale deepen core connection &nbsp;deep abdominal scoop and roll back to shoulder blades, roll back up to balance point. Maintain set up position thoughout roll.&nbsp;</p>\r\n<p><br></p>\r\n<p><em><strong>NOTE; Modify take ball away.&nbsp;</strong></em></p>	MAT 	\N		2018-04-09 11:42:10.254+00	2018-04-18 13:18:47.724+00	1
311	Seated Roll down Assisted Saw 	<p><u><strong>Set Up&nbsp;</strong></u></p>\r\n<p>Sitting stradeling reformer sitbones on Foot Plate. Hands on long box.&nbsp;</p>\r\n<p><br></p>\r\n<p><u><strong>The Exercise</strong></u></p>\r\n<p>Inhale prepare exhale initiate roll down by nodding chin to throat. Begin to press away long box as core connection deepens rolling down one vertebra at a time. Reach left arm around holdnig onto right side of frame continue to push and pull thoracic spine into rotation. Repeat or alternate sides.&nbsp;</p>	1 YELLOW 1 BLUE	\N		2018-04-09 14:15:39.319+00	2018-04-18 13:18:47.724+00	1
317	Reverse Stomach Massage Single Leg 	<p><u><strong>Set Up&nbsp;</strong></u></p>\r\n<p>Seated in Foot Plate. Hands on Foot Bar. Single foot on carriage (toe or heel) other leg in well. Spine long.&nbsp;Holding blue ball reaching arms diagonally up. Gennle squueze in ball.&nbsp;</p>\r\n<p><u><strong>The Exercise</strong></u></p>\r\n<p>Exhale press knee straight. Inhale bend.&nbsp;Be sure knee is tracking in line with second big toe.&nbsp;</p>	1 RED 1 BLUE 	\N		2018-04-10 06:42:02.872+00	2018-04-18 13:18:47.724+00	1
319	Side Lying Arm in Strap Forward Back 	<p><u><strong>Set Up</strong></u></p>\r\n<p>Side lying on carriage. Long strap in top hand reaching forward. Head supported by underneath arm. Legs straight. Optional hold ball inbetween knees.&nbsp;</p>\r\n<p><br></p>\r\n<p><u><strong>The Exercise</strong></u></p>\r\n<p>Inhale prepare. Exhale press arm to side of body. Core connection to to maintain stable side lying position. &nbsp;</p>	1 YELLOW or 1 BLUE or 1 RED 	\N		2018-04-10 06:49:53.423+00	2018-04-18 13:18:47.724+00	1
318	Side Lying Arm in Strap Sides 	<p><u><strong>Set Up</strong></u></p>\r\n<p>Side lying on carriage. Long strap in top hand reaching up to ceiling. Head supported by underneath arm. Legs straight. Optional hold ball inbetween knees.&nbsp;</p>\r\n<p><br></p>\r\n<p><u><strong>The Exercise</strong></u></p>\r\n<p>Inhale prepare. Exhale press arm down to side of body. Keep arm in peripheral vision.&nbsp;</p>	1 YELLOW or 1 BLUE or 1 RED 	\N		2018-04-10 06:46:57.955+00	2018-04-18 13:18:47.724+00	1
320	Side Lying Arm in Strap Triceps 	<p><u><strong>Set Up</strong></u></p>\r\n<p>Side lying on carriage. Long strap in top arm by side. Head supported by underneath arm. Legs straight. Optional hold ball inbetween knees.&nbsp;</p>\r\n<p><br></p>\r\n<p><u><strong>The Exercise</strong></u></p>\r\n<p>Inhale bend elbow . Exhale press arm straight. Let arm hover 2 inches away from side of body. Core connection to to maintain stable side lying position. &nbsp;</p>	1 YELLOW or 1 BLUE or 1 RED 	\N		2018-04-10 06:53:46.154+00	2018-04-18 13:18:47.724+00	1
321	Side Lying Arm in Strap Adductor Squeeze	<p><u><strong>Set Up</strong></u></p>\r\n<p>Side lying on carriage. Long strap in top hand reaching up to ceiling. Head supported by underneath arm. Legs straight. Holding ball inbetween knees.&nbsp;</p>\r\n<p><br></p>\r\n<p><u><strong>The Excercise</strong></u>&nbsp;</p>\r\n<p>Press arm down to 45 degrees and hold stable. Exhale squueze ball with adductors inhale release.&nbsp;</p>	1 YELLOW or 1 BLUE or 1 RED 	\N		2018-04-10 07:06:23.596+00	2018-04-18 13:18:47.724+00	1
322	Side Lying Arm in Strap Top Leg 	<p><u><strong>Set Up</strong></u></p>\r\n<p>Side lying on carriage. Long strap in top hand reaching up to ceiling. Head supported by underneath arm. Legs straight.&nbsp;</p>\r\n<p><br></p>\r\n<p><u><strong>The Excercise</strong></u>&nbsp;</p>\r\n<p>Press arm down to 45 degrees and hold stable. Lift and lower to straight leg x 10. Core connection to hold side lying stable.&nbsp;</p>\r\n<p><br></p>\r\n<p><em><strong>NOTE; Bend underneath leg to stabilize id needed.&nbsp;</strong></em></p>	1 YELLOW or 1 BLUE or 1 RED 	\N		2018-04-10 07:15:02.699+00	2018-04-18 13:18:47.724+00	1
323	Thigh in Strap Scissors	<p><u><strong>Set Up</strong></u>&nbsp;</p>\r\n<p>Sitting on side of carriage stap on mid thigh closest shoulder rest. Sit on very edge of carriage. Inhale prepare, exhale roll back one vertebra at a time until in chest lift position and legs are at table top. Hands interlaced behind head, or holding onto carriage.&nbsp;</p>\r\n<p><br></p>\r\n<p><u><strong>The Exercise</strong></u></p>\r\n<p>Take legs to L shape single leg to ceiling other leg leaching reaching long. Exhale switch legs x 10&nbsp;</p>\r\n<p><br></p>\r\n<p><em><strong>NOTE; Keep carriage as still as possible.&nbsp;</strong></em></p>	1 BLUE 	\N		2018-04-10 08:18:34.009+00	2018-04-18 13:18:47.724+00	1
324	Thigh in Strap Single Bent Leg Stretch 	<p><u><strong>Set Up</strong></u>&nbsp;</p>\r\n<p>Sitting on side of carriage stap on mid thigh closest shoulder rest. Sit on very edge of carriage. Inhale prepare, exhale roll back one vertebra at a time until in chest lift position and legs are at table top. Hands interlaced behind head, or holding onto carriage.&nbsp;</p>\r\n<p><br></p>\r\n<p><u><strong>The Exercise</strong></u></p>\r\n<p>Holding one leg at table top the other reached out straight. Hands on table top knee or interlaced behind head. Exhale switch. Keep toes in same plane.</p>\r\n<p>&nbsp;</p>\r\n<p><em><strong>NOTE; Keep carriage as still as possible.&nbsp;</strong></em></p>	1 BLUE 	\N		2018-04-10 08:20:00.383+00	2018-04-18 13:18:47.724+00	1
325	Thigh in Strap Helicopter	<p><u><strong>Set Up</strong></u>&nbsp;</p>\r\n<p>Sitting on side of carriage stap on mid thigh closest shoulder rest. Sit on very edge of carriage. Inhale prepare, exhale roll back one vertebra at a time until in chest lift position and legs are at table top. Hands interlaced behind head, or holding onto carriage.&nbsp;</p>\r\n<p><br></p>\r\n<p><u><strong>The Exercise</strong></u></p>\r\n<p>Take legs to L shape single leg to ceiling other leg leaching reaching long. Scissor legs twice circle legs around in helicopter. Repeat.&nbsp;</p>\r\n<p><br></p>\r\n<p><em><strong>NOTE; Carriage will move in helicopter</strong></em></p>	1 BLUE 	\N		2018-04-10 08:23:17.347+00	2018-04-18 13:18:47.724+00	1
330	Pulling Pike	<p><u><strong>Set Up</strong></u>&nbsp;</p>\r\n<p>Standing on inside of well at pulley end feet parallel hands on out side of carriage. Carriage pushed in all the way to the stopper.&nbsp;</p>\r\n<p><br></p>\r\n<p><u><strong>The Exercise</strong></u></p>\r\n<p>Inhale to prepare exhale press heels into ground pull carriage in towards knees. Use same energy as Elephant. Initiate movement from the deep core.&nbsp;</p>	NO SPRINGS 	\N		2018-04-10 11:37:27.789+00	2018-04-18 13:18:47.724+00	1
326	Mermaid Combo 	<p><u><strong>Set Up&nbsp;</strong></u></p>\r\n<p>Z sit on carriage facing sidewards.Short strap in hand closest to foot bar. Other hand resting on head rest.&nbsp;</p>\r\n<p><br></p>\r\n<p><u><strong>The Exercise</strong></u></p>\r\n<p>Inhale Pull strap until arm is straight to side in line with shoulder. Inhale arc arm over head let spine come into lateral felxion towards head reast mermaid position. Exhale pull from ribs arm comes back to side reach flat back. Inhale rotate arm across body. Exhale de-rotate arm comes back to side. Repeat.&nbsp;</p>	1 BLUE 	\N		2018-04-10 08:27:10.423+00	2018-04-18 13:18:47.724+00	1
331	Push Up on Frame	<p><u><strong>Set Up</strong></u></p>\r\n<p>Feet on frame hands on mid carriage head towards foot bar. In plank position.</p>\r\n<p><br></p>\r\n<p><u><strong>The Exercise</strong></u></p>\r\n<p>Find strong plank, neutral spine. Inhale lower into push up. Exhale press up.&nbsp;</p>\r\n<p><br></p>\r\n<p><em><strong>NOTE; Only go to point of control if the scapular start to glide together shoulder alignment has been lost. &nbsp;Press pinky finger side of arm into frame.&nbsp;</strong></em></p>	1 RED	\N		2018-04-10 11:42:23.016+00	2018-04-18 13:18:47.724+00	1
328	Kneeling Foot in Strap Bent Leg Press 	<p><u><strong>Set Up</strong></u>&nbsp;</p>\r\n<p>4 point kneeling on carriage bring foot strap on foot. Alternatively put strap on foot before 4 point kneeling, what ever is most comfortable. Bring elbows down to carriage rotate towards foot in strap, that hand goes onto carriage. Hips externally rotate looking towards foot.&nbsp;</p>\r\n<p><br></p>\r\n<p><u><strong>The Exercise&nbsp;</strong></u></p>\r\n<p>Inhale bend knee towards chest, &nbsp;exhale extend knee to straight externally rotated leg. Repeat.&nbsp;</p>\r\n<p><br></p>\r\n<p><em><strong>NOTE; Maintain shoulder stability thoughout.&nbsp;</strong></em></p>	1 BLUE	\N		2018-04-10 09:32:18.965+00	2018-04-18 13:18:47.724+00	1
327	Kneeling Foot in Strap Leg Press Parallel	<p><u><strong>Set Up</strong></u>&nbsp;</p>\r\n<p>4 point kneeling on carriage bring foot strap on foot. Alternatively put strap on foot before 4 point kneeling, what ever is most comfortable. Bring elbows down to carriage interlace hands on shoulder rest. Press straight leg back to parallel.</p>\r\n<p><br></p>\r\n<p><u><strong>The Exercise&nbsp;</strong></u></p>\r\n<p>Inhale bend knee towards chest, &nbsp;exhale extend knee to straight leg parallel. Repeat.&nbsp;</p>\r\n<p><br></p>\r\n<p><em><strong>NOTE; Maintain shoulder stability thoughout.&nbsp;</strong></em></p>	1 BLUE	\N		2018-04-10 09:26:50.133+00	2018-04-18 13:18:47.724+00	1
329	Kneeling Foot in Strap Circles 	<p><u><strong>Set Up</strong></u>&nbsp;</p>\r\n<p>4 point kneeling on carriage bring foot strap on foot. Alternatively put strap on foot before 4 point kneeling, what ever is most comfortable. Bring elbows down to carriage rotate towards foot in strap, that hand goes onto carriage. Hips externally rotate looking towards foot.&nbsp;</p>\r\n<p><br></p>\r\n<p><u><strong>The Exercise&nbsp;</strong></u></p>\r\n<p>Inhale circle straight leg around. Repeat. Alternate directions.&nbsp;</p>\r\n<p><br></p>\r\n<p><em><strong>NOTE; Maintain shoulder stability thoughout.&nbsp;</strong></em></p>	1 BLUE 	\N		2018-04-10 09:39:38.501+00	2018-04-18 13:18:47.724+00	1
335	Kneeling Rhomboid Release 	<p><u><strong>Set Up&nbsp;</strong></u></p>\r\n<p>Kneeling on carriage facing head rest knees hip distance apart. Arms crossed holding onto shoulder rests.&nbsp;</p>\r\n<p><br></p>\r\n<p><u><strong>The Exercise</strong></u></p>\r\n<p>Exhale pull scapular away from eachother pulling on shoulder rests. Press heart towards spine. Take 3 deep breaths.&nbsp;</p>\r\n<p><br></p>	1 BLUE or 1 RED	\N		2018-04-10 11:58:37.897+00	2018-04-18 13:18:47.724+00	1
333	Kneeling Bent Arm Tricep 	<p><u><strong>Set Up&nbsp;</strong></u></p>\r\n<p>Kneeling on carriage facing head rest knees hip distance apart. Hands in straps.&nbsp;</p>\r\n<p><br></p>\r\n<p><u><strong>The Exercise</strong></u></p>\r\n<p>Bring fists to heart, elbows wide. Exhale extend elbows to straighten arms into tricep press. Return to set up.&nbsp;</p>\r\n<p><br></p>\r\n<p><em><strong>Note; Be mindful of moving carriage. Core and glutes switched on.&nbsp;</strong></em></p>	1 BLUE or 1 RED 	\N		2018-04-10 11:54:16.639+00	2018-04-18 13:18:47.724+00	1
334	Kneeling Straight Arm Press	<p><u><strong>Set Up&nbsp;</strong></u></p>\r\n<p>Kneeling on carriage facing head rest knees hip distance apart. Hands in straps.&nbsp;</p>\r\n<p><br></p>\r\n<p><u><strong>The Exercise</strong></u></p>\r\n<p>Arm straight at 45 degrees. Inhale press arms back drawing scapular together. &nbsp;Exhale return to set up.&nbsp;</p>\r\n<p><br></p>\r\n<p><em><strong>Note; Be mindful of moving carriage. Core and glutes switched on.&nbsp;</strong></em></p>	1 BLUE or 1 RED	\N		2018-04-10 11:57:14.295+00	2018-04-18 13:18:47.724+00	1
338	Scooter Squat	<p><u><strong>Set Up&nbsp;</strong></u></p>\r\n<p>Long Box pressed up against the side of reformer closest to foot bar.&nbsp;Standing on Long Box other heel against shoulder rest. Sitting on heel. Hands on hips.</p>\r\n<p><br></p>\r\n<p><u><strong>The Exercise</strong></u></p>\r\n<p>Exhale press scooter leg into hip extension simultaneously lift sitbones up off heel. &nbsp;</p>	1 RED	\N		2018-04-10 12:23:47.197+00	2018-04-18 13:18:47.724+00	1
339	Footwork V Rises Half V Rises	<p><u><strong>Set up</strong></u></p>\r\n<p>Supine. Toes foot bar. in small V. &nbsp;Spine neutral. Arms by sides. Head rest comfortable.&nbsp;</p>\r\n<p><br></p>\r\n<p><u><strong>The exercise</strong></u></p>\r\n<p>Rise onto balls of feet then sink heels under the foot bar. x10 Bend knees half way hold carriage still rise onto balls of feet then sink heels under footbar x 10 &nbsp;Maintain Neutral Spine.&nbsp;</p>\r\n<p><br></p>\r\n<p><strong>NOTE; </strong><em><strong>Smooth movement be sure not to bounce.</strong></em></p>	3 RED 	\N		2018-04-10 12:42:18.182+00	2018-04-18 13:18:47.724+00	1
179	Pelvic Curl with T.B	<p><u><strong>Set up</strong></u></p>\r\n<p>Supine. Heels on jump board. Spine neutral.Thread THERA BAND underneath head and around shoulder restes. Arms by sides holding onto THERA BAND. Head rest down.&nbsp;</p>\r\n<p><br></p>\r\n<p><u><strong>The exercise</strong></u></p>\r\n<p>Inhale to prepare. Exhale move through imprint, curl tail bone to pubic bone, pubic bone to navle roll up 1 vertebra at a time to T6.&nbsp;Hold at top and pulse arms up and dowm maintating tension on thera band.&nbsp;Inhale at top, exhale roll down articulating each vertebra till set up position is reached.</p>\r\n<p><br></p>\r\n<p><strong>NOTE &nbsp;Be sure not to roll into spine extension. Sink the sternum lift the Pubic Bone.&nbsp;</strong></p>	1 YELLOW 1 BLUE 	\N		2018-04-05 06:23:30.947+00	2018-04-18 13:18:47.724+00	1
263	Pelvic Curl with Thera Band	<p><u><strong>Set up</strong></u></p>\r\n<p>Supine. Heels on foot bar. Spine neutral. Thera Band over thighs hands holding Thera Band pressing into mat.&nbsp;</p>\r\n<p><br></p>\r\n<p><u><strong>The Exercise</strong></u></p>\r\n<p>Inhale to prepare. Exhale move through lumbar imprint, curl tail bone to pubic bone, pubic bone to navle roll up 1 vertebra at a time to T6.&nbsp;Let hands lift at top and pulse hands down to ground squeezing glutes at same time.Inhale at top, exhale roll down articulating each vertebra till set up position is reached.&nbsp;</p>\r\n<p><br></p>\r\n<p><strong>NOTE &nbsp;Be sure not to roll into spine extension. Sink the sternum lift the Pubic Bone.&nbsp;</strong></p>\r\n<p><br></p>	MAT 	\N		2018-04-08 14:05:43.955+00	2018-04-18 13:18:47.724+00	1
332	Leg Pull Front on Frame	<p><u><strong>Set Up</strong></u></p>\r\n<p>Feet on frame hands on mid carriage head towards foot bar. In plank position.</p>\r\n<p><br></p>\r\n<p><u><strong>The Exercise</strong></u></p>\r\n<p>Find strong plank, neutral spine. Lift single leg into hip extension x 10 times, swap legs.&nbsp;</p>\r\n<p><br></p>\r\n<p><em><strong>NOTE; If the scapular start to glide together shoulder alignment has been lost. &nbsp;Press pinky finger side of arm into frame.&nbsp;</strong></em></p>	1 RED	\N		2018-04-10 11:47:10.107+00	2018-07-03 11:06:46.411+00	2
336	Kneeling Rowing Combo	<p><u><strong>The Exercise&nbsp;</strong></u></p>\r\n<p>Pulling straps into row, elbows wide, release back pull elbows into row elbows close to body. Repeat.&nbsp;</p>	2 RED	Kneeling Rowing Combo.JPG		2018-04-10 12:03:05.453+00	2018-07-03 13:02:28.617+00	1
360	Feet in Straps Side Lying Bent Knee	<p><u><strong>Set Up</strong></u>&nbsp;</p>\r\n<p>Side lying on carriage. HEad resting on arm. Top foot in strap. Long neutral spine. Stacked pelvis. &nbsp;Leg parallel.</p>\r\n<p><br></p>\r\n<p><u><strong>The Exercise</strong></u></p>\r\n<p>Inhale bend knee to bring leg 90/90 in front of body. Exhale extend knee and hip to straight leg. Repeat.</p>\r\n<p><br></p>\r\n<p><em><strong>NOTE; If neutral spine set up is compromised the spring is too heavy &nbsp;</strong></em></p>	1 RED or 1 BLUE	Feet in Straps Side Lying Bent Knee.jpg		2018-04-13 03:58:58.887+00	2018-08-29 01:47:49.445+00	1
342	Prone Heel Beats	<p><u><strong>Set Up&nbsp;</strong></u></p>\r\n<p>Prone on Long Box. Arms folded across top of box, spine in gentle thoracic extension. Heels together legs straight.&nbsp;</p>\r\n<p><br></p>\r\n<p><u><strong>The Exercise</strong></u></p>\r\n<p>Beat heels together. Initiate movemnt from adductors. Gentley lift Quads off long box, or aim to. Beat for 10, rest 20 rest, 30 rest.&nbsp;</p>	1 RED	\N		2018-04-10 13:03:20.002+00	2018-04-18 13:18:47.724+00	1
343	Seated Rowing	<p><u><strong>Set Up&nbsp;</strong></u></p>\r\n<p>Seated on carriage facing foot bar legs straight though ontop head rest. Optional to sit on long box or slightly bend knees. Hands in straps, straps crossed.&nbsp;</p>\r\n<p><br></p>\r\n<p><u><strong>The Exercise</strong></u></p>\r\n<p>Exhale pull straps into rowing position, elbows wide, Inhale return arms, Exhale pull straps into rowing elbows &nbsp;close to body. Return to set up.&nbsp;</p>\r\n<p><br></p>	2 RED 	\N		2018-04-10 13:10:46.533+00	2018-04-18 13:18:47.724+00	1
344	Standing Rises with Thera Band and Blue Ball 	<p><u><strong>Set Up&nbsp;</strong></u></p>\r\n<p>Standing. Feet parallel Blue Ball Between ankles. Holding Thera Band arms straight out front in line with shoulders.</p>\r\n<p><br></p>\r\n<p><u><strong>The Exercise</strong></u></p>\r\n<p>Inhale prepare feel spine long. Exhale rise up onto balls of feet, pulling the Thera Band. Inhale lower release Thera Band.&nbsp;</p>	MAT 	\N		2018-04-13 01:27:27.803+00	2018-04-18 13:18:47.724+00	1
345	Standing Demi Squat with T.B and Blue and Blue Ball 	<p><u><strong>Set Up&nbsp;</strong></u></p>\r\n<p>Standing. Feet parallel Blue Ball Between ankles. Holding Thera Band arms straight out front in line with shoulders.</p>\r\n<p><br></p>\r\n<p><u><strong>The Exercise</strong></u></p>\r\n<p>Inhale prepare feel spine long. Exhale rise up onto balls of feet, pulling the Thera Band. Manintain rise inhale demi (1/2) squat. Exhale extend knees, repeate.&nbsp;</p>\r\n<p><br></p>\r\n<p><em><strong>NOTE; Maintain heel rise thoughout squats. &nbsp;</strong></em></p>	Mat	\N		2018-04-13 01:28:02.189+00	2018-04-18 13:18:47.724+00	1
348	Chest Lift over Ball Knees Hooked	<p><u><strong>Set Up&nbsp;</strong></u></p>\r\n<p>Supine on carriage, wriggle body as far down on carriage as possible. Blue Ball under upper thoracic. Hands interlaced behind head in chest lift position. Knees hooked over foot bar pulling heels towards sitbones.&nbsp;</p>\r\n<p><br></p>\r\n<p><u><strong>The Exercise&nbsp;</strong></u></p>\r\n<p>Exhale lift head neck and shoulders into chest lift.&nbsp;Inhale return to set up.&nbsp;</p>\r\n<p><br></p>\r\n<p><em><strong>NOTE; Keep elbows in peripheral vision.</strong></em></p>	3 RED	\N		2018-04-13 01:48:48.333+00	2018-04-18 13:18:47.724+00	1
350	Chest Lift Extension over Ball Knees Hooked	<p><u><strong>Set Up&nbsp;</strong></u></p>\r\n<p>Supine on carriage, wriggle body as far down on carriage as possible. Blue Ball under upper thoracic. Hands interlaced behind head in chest lift position. Knees hooked over foot bar pulling heels towards sitbones.&nbsp;</p>\r\n<p><br></p>\r\n<p><u><strong>The Exercise&nbsp;</strong></u></p>\r\n<p>Inhale take head back to carriage coming into thoracic extension ove the ball. Exhale lift head neck and shoulders into chest lift.&nbsp;Inhale return to set up.&nbsp;</p>\r\n<p><br></p>\r\n<p><em><strong>NOTE; Keep elbows in peripheral vision. The abdominals are the primary mover, keep tension out of the neck.&nbsp;</strong></em></p>	3 RED 	\N		2018-04-13 01:52:05.987+00	2018-04-18 13:18:47.724+00	1
357	Hands in Straps Single Arm Up Down 	<p><u><strong>Set up</strong></u></p>\r\n<p>Supine. Single hand in strap. Spine neutral. Legs table top. Head rest comfortable. If the core is not strong enough lumbar spine can imprint otherwise neutral pelvis. Hands reaching to ceiling.</p>\r\n<p><br></p>\r\n<p><u><strong>The exercise</strong></u></p>\r\n<p>Inhale to prepare. Exhale press the hands down to sides Inhale return. Maintain set up position while disassociating the shoulders.&nbsp;Feel as though both hands are in staps.&nbsp;</p>\r\n<p><br></p>\r\n<p><em><strong>NOTE Come into chest lift if client is able to maintaion good neck stability, shoulder alignment and core control.&nbsp;</strong></em></p>	1 RED 1 BLUE 	\N		2018-04-13 03:42:54.147+00	2018-04-18 13:18:47.724+00	1
355	Kneeling Hip Extension 	<p><u><strong>Set Up&nbsp;</strong></u></p>\r\n<p>4 point kneeling on carriage. Hands on top of shoulder rests. Single leg reaching back to foot bar. Heel or toe on foot bar. Legs parallel.&nbsp;</p>\r\n<p><br></p>\r\n<p><u><strong>The Exercise&nbsp;</strong></u></p>\r\n<p>Inhale prepare, exhale press foot into bar and extend knee. Inhale bend knee.&nbsp;Repeate.</p>\r\n<p><br></p>\r\n<p><em><strong>NOTE; Be sure to maintain neutral spine, pelvis and shoulder placement. Shoulders remain above wrists.&nbsp;</strong></em></p>	1 RED 1 BLUE or 2 RED	\N		2018-04-13 03:39:07.551+00	2018-04-18 13:18:47.724+00	1
356	Kneeling Hip Extension External Rotation	<p><u><strong>Set Up&nbsp;</strong></u></p>\r\n<p>4 point kneeling on carriage. Hands on top of shoulder rests. Single leg reaching back to foot bar. Heel or toe on foot bar. Hip externally rotated.</p>\r\n<p><br></p>\r\n<p><u><strong>The Exercise&nbsp;</strong></u></p>\r\n<p>Inhale prepare, exhale press foot into bar and extend knee. Inhale bend knee.&nbsp;</p>\r\n<p><br></p>\r\n<p><em><strong>NOTE; Be sure to maintain neutral spine, pelvis and shoulder placement. Shoulders remain above wrists.&nbsp;</strong></em></p>	1 RED 1 BLUE or 2 RED	\N		2018-04-13 03:41:10.704+00	2018-04-18 13:18:47.724+00	1
353	Footwork Side Lying External Rotation 	<p><u><strong>Set Up</strong></u></p>\r\n<p>Side Lying on Carriage. Head supported by underneath arm. Top foot heel on bar. Hip externally rotated second big toe in line with the knee. Bring foot the the front of the bar. Maintain a stacked pelvis a neutral spine.&nbsp;</p>\r\n<p><br></p>\r\n<p><u><strong>The Exercise</strong></u></p>\r\n<p>Exhale press &nbsp;heel into the foot bar and extend knee. Inhale bend. Repeat.&nbsp;</p>\r\n<p><br></p>\r\n<p><em><strong>NOTE; Be sure to maintain neutal spine and pelvis. Client should feel this in glutes, if they feel it in the hip fexors or quads angle pelvis forward and slightly drop knee. otherwise knee is in line with the second big toe.&nbsp;</strong></em></p>	1 RED 1 BLUE or 2 RED 	Footwork Sidelying External Rotation.jpg		2018-04-13 02:12:35.51+00	2018-07-03 12:30:45.46+00	1
341	Kneeling Arm Series Serving Combo 	<p><u><strong>Set Up</strong></u></p>\r\n<p>Kneeling on carriage facing foot bar. Sitting on heels. Holding straps elbows bent.&nbsp;</p>\r\n<p><br></p>\r\n<p><u><strong>The Exercise&nbsp;</strong></u></p>\r\n<p>Inhale prepare. Exhale press arms forward squeeze glutes and come up to kneeling. &nbsp;Inhale return to set up. Repeat.&nbsp;</p>	1 RED	Kneeling Arm Series Serving.jpg		2018-04-10 12:58:56.121+00	2018-09-01 05:05:01.69+00	1
358	Hands in Straps Single Arm Sides 	<p><u><strong>Set up</strong></u></p>\r\n<p>Supine. Single hand in strap. Spine neutral. Legs table top. Head rest comfortable. If the core is not strong enough lumbar spine can imprint otherwise neutral pelvis. Arms reaching our to the sides.</p>\r\n<p><br></p>\r\n<p><u><strong>The exercise</strong></u></p>\r\n<p>Inhale to prepare. Exhale press hands in towards sides Inhale return. Maintain set up position while disassociating the shoulders.&nbsp;Feel as though both hands are in staps.&nbsp;</p>\r\n<p><br></p>\r\n<p><em><strong>NOTE Come into chest lift if client is able to maintaion good neck stability, shoulder alignment and core control.&nbsp;</strong></em></p>	1 RED 1 BLUE 	\N		2018-04-13 03:46:13.086+00	2018-04-18 13:18:47.724+00	1
368	Hamstring Pull with Thera Band 	<p><u><strong>Set Up</strong></u></p>\r\n<p>Put foot bar down. Short Box on frame next to pulleys. Sitting on Box. Heels over shoulder rests. Thread Thera Band behind back. Hands holding Thera Band 90/90 elbows, ready for RTC. Hands in front of bady.&nbsp;</p>\r\n<p><br></p>\r\n<p><u><strong>The Exercise</strong></u></p>\r\n<p>Exhale Hamstring pull carriage towards box with heels. At the same time exteranally rotate shoulders takeing Thera Band into a double RTC.&nbsp;</p>\r\n<p><br></p>\r\n<p><em><strong>NOTE; Sitting tall on the box.&nbsp;</strong></em></p>	1 RED	\N		2018-04-13 06:01:46.743+00	2018-04-18 13:18:47.724+00	1
369	Hamstring Pull Single Leg with Thera Band  	<p><u><strong>Set Up</strong></u></p>\r\n<p>Put foot bar down. Short Box on frame next to pulleys. Sitting on Box. Single geel over shoulder rest, the other leg hovering knee bent. Thread Thera Band behind back. Hands holding Thera Band 90/90 elbows, ready for RTC. Hands in front of bady.&nbsp;</p>\r\n<p><br></p>\r\n<p><u><strong>The Exercise</strong></u></p>\r\n<p>Exhale Hamstring pull carriage towards box with single leg heels. At the same time exteranally rotate shoulders takeing Thera Band into a double RTC and press arms away, extending elbows. Inhale return.&nbsp;</p>\r\n<p><br></p>\r\n<p><em><strong>NOTE; Sitting tall on the box.&nbsp;</strong></em></p>	1 RED 	\N		2018-04-13 06:14:15.477+00	2018-04-18 13:18:47.724+00	1
364	Side Plank Short Box Front Back 	<p><u><strong>Set Up</strong></u></p>\r\n<p>Put foot bar down. Short Box on frame past head rest. &nbsp;Side elbow plank on Short Box. Underneath knee &nbsp;on carriage as in photo. Top leg reaches long. Top arm reaches for the ceiling.</p>\r\n<p><br></p>\r\n<p><u><strong>The Exercise</strong></u></p>\r\n<p>Inhale top leg comes into hip felxion knee stays straight for front kick. Exhale press leg back into hip extension.Keeping spine and pelvis stable side of body lifted. &nbsp;</p>\r\n<p><br></p>\r\n<p><em><strong>NOTE; Maitain shoulder set up. Pressing elbow into box, shoulder drawing away from ear. &nbsp;</strong></em></p>	3 RED	\N		2018-04-13 05:45:58.718+00	2018-04-18 13:18:47.724+00	1
363	Side Plank Short Box Circles	<p><u><strong>Set Up</strong></u></p>\r\n<p>Put foot bar down. Short Box on frame past head rest. Side elbow plank on Short Box. Underneath knee &nbsp;on carriage as in photo. Top leg reaches long. Top arm reaches for the ceiling.</p>\r\n<p><br></p>\r\n<p><u><strong>The Exercise</strong></u></p>\r\n<p>Top leg lifts circles around. Alternated directions. Keeping spine and pelvis stable side of body lifted. &nbsp;</p>\r\n<p><br></p>\r\n<p><em><strong>NOTE; Maitain shoulder set up. Pressing elbow into box, shoulder drawing away from ear. &nbsp;</strong></em></p>	3 RED	\N		2018-04-13 05:42:09.819+00	2018-04-18 13:18:47.724+00	1
362	Side Plank Short Box Up Down 	<p><u><strong>Set Up</strong></u></p>\r\n<p>Put foot bar down. Short Box on frame past head rest. &nbsp;Side elbow plank on Short Box. Underneath knee &nbsp;on carriage as in photo. Top leg reaches long. Top arm reaches for the ceiling.</p>\r\n<p><br></p>\r\n<p><u><strong>The Exercise</strong></u></p>\r\n<p>Top leg lifts up and down. Adbucts and adducts.&nbsp;Keeping spine and pelvis stable side of body lifted. &nbsp;</p>\r\n<p><br></p>\r\n<p><em><strong>NOTE; Maitain shoulder set up. Pressing elbow into box, shoulder drawing away from ear. &nbsp;</strong></em></p>	3 RED	\N		2018-04-13 04:03:49.201+00	2018-04-18 13:18:47.724+00	1
365	Booty Ball Short Box Squeezes	<p><u><strong>Set Up</strong></u></p>\r\n<p>Put foot bar down. Short Box on frame past head rest. Elbow plank on Short Box. Knees on carriage. Hold Blue Ball behind knee. Lift that leg in preperation.&nbsp;</p>\r\n<p><br></p>\r\n<p><u><strong>The Exercise&nbsp;</strong></u></p>\r\n<p>Lift knee up in line with hip. Exhale squeeze the ball, inhale release.&nbsp;</p>\r\n<p><br></p>\r\n<p><em><strong>NOTE; Mantain strong shoulder alignment, head in line with the spine.&nbsp;</strong></em></p>	3 RED 	\N		2018-04-13 05:47:25.426+00	2018-04-18 13:18:47.724+00	1
367	Booty Ball Short Box Circles	<p><u><strong>Set Up</strong></u></p>\r\n<p>Put foot bar down. Short Box on frame past head rest. Elbow plank on Short Box. Knees on carriage. Hold Blue Ball behind knee. Lift that leg in preperation.</p>\r\n<p>&nbsp;</p>\r\n<p><u><strong>The Exercise&nbsp;</strong></u></p>\r\n<p>Circle hip around, Squeezing the ball at the same time.&nbsp;</p>\r\n<p><br></p>\r\n<p><em><strong>NOTE; Mantain strong shoulder alignment, head in line with the spine.&nbsp;</strong></em></p>	3 RED 	\N		2018-04-13 05:54:57.132+00	2018-04-18 13:18:47.724+00	1
370	Tricep Press on Short Box 	<p><u><strong>Set Up</strong></u></p>\r\n<p>Short Box on frame next to pulleys. Feet on head rest or carriage dependent on leg length.&nbsp;</p>\r\n<p><br></p>\r\n<p><u><strong>The Exercise&nbsp;</strong></u></p>\r\n<p>Tricep dips.&nbsp;</p>\r\n<p><br></p>\r\n<p><em><strong>NOTE; Maintain shoulder alignment. Keeping shoulders away from ears.&nbsp;</strong></em></p>	1 RED 	\N		2018-04-13 06:17:22.148+00	2018-04-18 13:18:47.724+00	1
366	Booty Ball Up and Down	<p><u><strong>Set Up</strong></u></p>\r\n<p>Put foot bar down. Short Box on frame past head rest. Elbow plank on Short Box. Knees on carriage. Hold Blue Ball behind knee. Lift that leg in preperation.&nbsp;</p>\r\n<p><br></p>\r\n<p><u><strong>The Exercise&nbsp;</strong></u></p>\r\n<p>Lift knee up into hip extension and lower. Keeping leg parrallel.&nbsp;</p>\r\n<p><br></p>\r\n<p><em><strong>NOTE; Mantain strong shoulder alignment, head in line with the spine.&nbsp;</strong></em></p>	3 RED	\N		2018-04-13 05:53:43.092+00	2018-04-18 13:18:47.724+00	1
383	100's on Foot Bar 	<p><u><strong>Set up</strong></u></p>\r\n<p>Supine. Legs straight feet paralle on foor bar Magic Circle between ankles.</p>\r\n<p>Lumbar spine can imprint Reach arms to roof.</p>\r\n<p>&nbsp;</p>\r\n<p><u><strong>The exercise</strong></u></p>\r\n<p>Exhale chest lift. Bring arms by sides. Beat arms down, inhale for 5 beats exhale for 5 beats. Feel as though legs are "standing" on foot bar,&nbsp;</p>	2 RED 	\N		2018-04-13 20:43:48.911+00	2018-04-18 13:18:47.724+00	1
371	Sitting Foot Bar Rises	<p><u><strong>Set Up&nbsp;</strong></u></p>\r\n<p>Sitting on foot bar balls of feet on carriage edge. Blue Ball in between ankles. Holding Thera Bandin front of body straight elbows. Hook sit bones just to front of foot bar.&nbsp;</p>\r\n<p><u><strong>The Exercise&nbsp;</strong></u></p>\r\n<p>Knees straight. Sink heels under carriage exhale press into calf rise. Reaching arms to front of body pulling on Thera Band each rise.&nbsp;</p>	2 RED	\N		2018-04-13 06:22:49.152+00	2018-04-18 13:18:47.724+00	1
375	Reverse Standing Splits 	<p><u><strong>Set Up</strong></u>&nbsp;</p>\r\n<p>Standing on stable side of platform first bringing single leg to center of carriage foot parallel standing platform foot on ball of foot parallel. Arms out stretched to sides.&nbsp;</p>\r\n<p><br></p>\r\n<p><u><strong>The Exercise&nbsp;</strong></u></p>\r\n<p>Inhhale press into feet pushing the carriage out into split &nbsp;position. Only go to point of control. Exhale drawing carriage back home. Repeat&nbsp;</p>	1 RED 	\N		2018-04-13 13:49:28.755+00	2018-04-18 13:18:47.724+00	1
376	Reverse Standing Lunge 	<p><u><strong>Set Up</strong></u>&nbsp;</p>\r\n<p>Standing on stable side of platform first bringing single leg to center of carriage foot parallel standing platform foot on ball of foot parallel. Arms out stretched to sides.&nbsp;</p>\r\n<p>&nbsp;</p>\r\n<p><u><strong>The Exercise&nbsp;</strong></u></p>\r\n<p>Inhhale press into feet pushing the carriage out into lunge. Only go to point of control. Exhale drawing carriage back home. Repeat&nbsp;</p>	1 RED	\N		2018-04-13 13:51:39.601+00	2018-04-18 13:18:47.724+00	1
377	Reverse Standing Lunge with Rotation 	<p><u><strong>Set Up</strong></u>&nbsp;</p>\r\n<p>Standing on stable side of platform first bringing single leg to center of carriage foot parallel standing platform foot on ball of foot parallel. Arms behind head.&nbsp;</p>\r\n<p><br></p>\r\n<p><u><strong>The Exercise&nbsp;</strong></u></p>\r\n<p>Inhhale press into feet pushing the carriage out into lunge. Only go to point of control. Rotate torso away from front leg. Exhale drawing carriage back home. Repeat&nbsp;</p>	1 RED 	\N		2018-04-13 13:53:39.813+00	2018-04-18 13:18:47.724+00	1
380	Scooter Side 2 Straight Legs 	<p><u><strong>Set Up&nbsp;</strong></u></p>\r\n<p>Standing to side of carriage facing <u><em><strong>away </strong></em></u>from carriage. One foot on carriage pressing agains shoulder rest, the other leg on ground. Both legs straight. Holding magic circle or arm reached above head.&nbsp;</p>\r\n<p><br></p>\r\n<p><u><strong>The Exercise&nbsp;</strong></u></p>\r\n<p>Inhale press carriage leg away abducting hips. Exhale draw carriage back home adducting hips. Keeping legs straight. Squeezing Magic Circle with hands or reaching arms above head.&nbsp;</p>	1 RED 	\N		2018-04-13 20:27:05.598+00	2018-04-18 13:18:47.724+00	1
378	Scooter Side 1 Straight Legs 	<p><u><strong>Set Up&nbsp;</strong></u></p>\r\n<p>Standing to side of carriage<u><em><strong> facing</strong></em></u> carriage. One foot on carriage pressing agains shoulder rest, the other leg on ground. Both legs straight. Holding magic circle or arm reached above head.&nbsp;</p>\r\n<p><br></p>\r\n<p><u><strong>The Exercise&nbsp;</strong></u></p>\r\n<p>Inhale press carriage leg away abducting hips. Exhale draw carriage back home adducting hips. Keeping legs straight. Squeezing Magic Circle with hands or reaching arms above head. &nbsp;</p>	1 RED 	\N		2018-04-13 20:22:02.949+00	2018-04-18 13:18:47.724+00	1
379	Scooter Side 1 Bent Legs 	<p><u><strong>Set Up&nbsp;</strong></u></p>\r\n<p>Standing to side of carriage <u><em><strong>facing </strong></em></u>carriage. One foot on carriage pressing agains shoulder rest knee bent, the other leg on ground knee straight. Both legs parallel. Holding magic circle or arm reached above head.&nbsp;</p>\r\n<p><br></p>\r\n<p><u><strong>The Exercise&nbsp;</strong></u></p>\r\n<p>Exhale extend knee (on carriage) to push carriage away. Inhale return carriage. Supporting leg remains straight.&nbsp;</p>	1 RED 	\N		2018-04-13 20:25:28.188+00	2018-04-18 13:18:47.724+00	1
381	Scooter Side 2 Bent Legs	<p><u><strong>Set Up&nbsp;</strong></u></p>\r\n<p>Standing to side of carriage facing<u><em><strong> away</strong></em></u><em> &nbsp;</em>from carriage. One foot on carriage pressing agains shoulder rest knee bent, the other leg on ground knee straight. Both legs parallel. Holding magic circle or arm reached above head.&nbsp;</p>\r\n<p><br></p>\r\n<p><u><strong>The Exercise&nbsp;</strong></u></p>\r\n<p>Exhale extend knee (on carriage) to push carriage away. Inhale return carriage. Supporting leg remains straight.&nbsp;</p>	1 RED 	\N		2018-04-13 20:29:52.853+00	2018-04-18 13:18:47.724+00	1
386	Knee in Strap Side Lying Up Down 	<p><u><strong>Set Up&nbsp;</strong></u></p>\r\n<p>Side lying on carriage. Top leg in strap, strap just above knee. Both knees bent legs together. Head supported &nbsp;by underneath arm.&nbsp;</p>\r\n<p><br></p>\r\n<p><u><strong>The Exercise&nbsp;</strong></u></p>\r\n<p>Inhale lift entire top leg, exhale lower leg keeping knees bent. Repeat.&nbsp;</p>\r\n<p><br></p>\r\n<p><em><strong>NOTE; Maintain stacked pelvis and neutral side lying spine.</strong></em></p>	1 RED 	\N		2018-04-15 13:01:32.572+00	2018-04-18 13:18:47.724+00	1
387	Knee in Strap Side Lying Circles 	<p><u><strong>Set Up&nbsp;</strong></u></p>\r\n<p>Side lying on carriage. Top leg in strap, strap just above knee. Both knees bent legs together. Head supported &nbsp;by underneath arm.&nbsp;</p>\r\n<p><br></p>\r\n<p><u><strong>The Exercise&nbsp;</strong></u></p>\r\n<p>Inhale lift entire top leg, exhale cirecle leg. Repeat. Alternate directions.</p>\r\n<p><br></p>\r\n<p><em><strong>NOTE; Maintain stacked pelvis and neutral side lying spine.</strong></em></p>	1 RED 	\N		2018-04-15 13:03:19.406+00	2018-04-18 13:18:47.724+00	1
382	Roll Over Prep 	<p><u><strong>Set Up&nbsp;</strong></u></p>\r\n<p>Supine. Head rest down. Legs at table top magic circle between ankles optional. Hands in straps reaching towards ceiling, elbows straight.&nbsp;</p>\r\n<p><br></p>\r\n<p><u><strong>The Exercise&nbsp;</strong></u></p>\r\n<p>Inhale prepare reaching legs towards celiling in L shape or as clase to 90/90 straight legs as possible. &nbsp;Exhale begin to pull straps towards sides. Roll though imprint and lift hips off the carriage reaching legs towards the ceiling. Lift as much of lumbur spine off as possible. Inhale return arms to ceiling and straight legs to L position. Repeat.&nbsp;</p>	1 RED 	Roll Over Prep.jpg		2018-04-13 20:37:49.004+00	2018-09-01 01:43:26.539+00	1
373	Tendon Stretch Prep 	<p><u><strong>Set Up&nbsp;</strong></u></p>\r\n<p>Sitting on foot bar balls of feet on carriage edge. Blue Ball in between ankles.Hands holding into foot bar to sides of body. Knuckles facing towards feet.&nbsp;</p>\r\n<p><br></p>\r\n<p><u><strong>The Exercise</strong></u></p>\r\n<p>Inhale prepare. Exhale push into handes in bar and lift hips off foot bar. find a deep C curve with the spine using the exhalatin to find core connection.&nbsp;</p>\r\n<p><br></p>\r\n<p><em><strong>NOTE; Lift with the abdominals as much as the arms.&nbsp;</strong></em></p>	1 RED 1 BLUE 	Tendon Stretch Prep.jpeg		2018-04-13 12:22:37.035+00	2018-04-19 00:09:20.601+00	1
388	Knee in Strap Side Lying Forward Back 	<p><u><strong>Set Up&nbsp;</strong></u></p>\r\n<p>Side lying on carriage. Top leg in strap, strap just above knee. Both knees bent legs together. Head supported &nbsp;by underneath arm.&nbsp;</p>\r\n<p><br></p>\r\n<p><u><strong>The Exercise&nbsp;</strong></u></p>\r\n<p>Inhale lift entire top leg and bring hip into forward flexion &nbsp;exhale press lex backcoming into hip extension. Repeat. Alternate directions.</p>\r\n<p><br>\r\n<em><strong>NOTE; Maintain stacked pelvis and neutral side lying spine.</strong></em></p>	1 RED 	\N		2018-04-15 13:04:44.375+00	2018-04-18 13:18:47.724+00	1
389	Reverse Abdominals Knees Up 	<p><u><strong>Set up</strong></u></p>\r\n<p>Kneeling on carriage knees against shoulder rests toes tucked. Lift knees 6 inches . Hands on frames wrists under shoulders. Round Back.&nbsp;</p>\r\n<p><br></p>\r\n<p><u><strong>The Exercise</strong></u></p>\r\n<p>Inhale to prepare. Exhale pull carriage towards wrists. Inhale return to start position.</p>\r\n<p><br></p>\r\n<p><em><strong>NOTE ; Pull from abdominals and lats not upper traps. Keep shoulders drawing away from ears.&nbsp;</strong></em></p>	1 BLUE 	\N		2018-04-15 13:06:11.837+00	2018-04-18 13:18:47.724+00	1
390	Reverse Abdominals Knees Lifted Single Knee 	<p><u><strong>Set up</strong></u></p>\r\n<p>Kneeling on carriage knees against shoulder rests toes tucked. Lift knees 6 inches . Squeeze left leg agains right lifting left toes if possible. Hands on frames wrists under shoulders. Round Back.&nbsp;</p>\r\n<p><br></p>\r\n<p><u><strong>The Exercise</strong></u></p>\r\n<p>Inhale to prepare. Exhale pull carriage towards wrists. Inhale return to start position.</p>\r\n<p><br></p>\r\n<p><em><strong>NOTE ; Pull from abdominals and lats not upper traps. Keep shoulders drawing away from ears.&nbsp;</strong></em></p>	1 BLUE 	\N		2018-04-15 13:11:26.301+00	2018-04-18 13:18:47.724+00	1
419	Moving Bridge 	<p><u><strong>Set Up&nbsp;</strong></u></p>\r\n<p>Short Box pressed up against shoulder rests. sitting on box hands by hips. Feet parallel on foot bar.&nbsp;</p>\r\n<p><br></p>\r\n<p><u><strong>The Exercise</strong></u></p>\r\n<p>Curl pelvis off box pushing hips up into bridge possition. Press feet into foot plate extending knees. Keeping shoulders over wrists. Return and repeat.</p>\r\n<p><br></p>\r\n<p><em><strong>TEACHING TIP; Try different breathing patterns and see what works best. Initiate the move from the legs, hips and core.&nbsp;</strong></em></p>	1 BLUE 	\N		2018-04-18 01:42:23.669+00	2018-04-18 13:18:47.724+00	1
395	Modified Arabesque 	<p><u><strong>Set Up</strong></u></p>\r\n<p>Come into Elephant position. Taking one leg and hanging it over the well.</p>\r\n<p><br></p>\r\n<p><u><strong>The Exercise</strong></u>&nbsp;</p>\r\n<p>Press carriage back dipping the single leg into the well. Draw carriage forward taking single leg into arabesque. Reteat.</p>	1 RED 1 BLUE 	\N		2018-04-15 13:36:31.864+00	2018-04-18 13:18:47.724+00	1
396	Scooter Flying 	<p><u><strong>Set up</strong></u></p>\r\n<p>Standing next to carriage one foot on ground other heel against shoulder rest. Knees bent. Pelvis aligned. Hands on Foot bar.&nbsp;</p>\r\n<p><br></p>\r\n<p><u><strong>The exercise</strong></u></p>\r\n<p>Inhale to prepare. Exhale press heel into shoulder rest Inhale simultaneously bend knee on carriage and kick supporting lg into air into hip extension. Press carriage back simultaneously land "flying" leg back to set up.&nbsp;</p>\r\n<p><br></p>\r\n<p><em><strong>NOTE; Dont bring flying leg back to the ground rather pull into deep hip and knee flexion.&nbsp;</strong></em></p>	1 RED +	\N		2018-04-15 13:38:14.43+00	2018-04-18 13:18:47.724+00	1
393	Star Front Kick 	<p><u><strong>Set Up</strong></u></p>\r\n<p>Kneeling side facing on carriage. Single arm comes to center of foot bar. Reach top leg straight. Arm beside side.</p>\r\n<p><br></p>\r\n<p><u><strong>The Exercise</strong></u></p>\r\n<p>Push into foot bar arm to press out into a side plank to point of control raising top arm. Lift top leg. Inhale take straight leg forward into hip flexion, exhale leg back into hip extension. To make it harder use lighter springs.&nbsp;</p>\r\n<p><br></p>\r\n<p><u><strong>NOTE; Maintain good head neck and shoulder alignment.&nbsp;</strong></u></p>	1 RED or 1 BLUE	Star Front Kick.jpg		2018-04-15 13:29:05.914+00	2018-07-03 12:36:58.691+00	2
394	Star Glute Circles	<p><u><strong>Set Up</strong></u></p>\r\n<p>Kneeling side facing on carriage. Single arm comes to center of foot bar. Reach top leg straight. Arm beside side.</p>\r\n<p><br></p>\r\n<p><u><strong>The Exercise</strong></u></p>\r\n<p>Push into foot bar arm to press out into a side plank to point of control raising top arm. Lift top straight leg. Circle around. Alternate directions. To make it harder use lighter springs.&nbsp;</p>\r\n<p><br></p>\r\n<p><u><strong>NOTE; Maintain good head neck and shoulder alignment.&nbsp;</strong></u></p>	1 RED or 1 BLUE	Star Front Kick.jpg		2018-04-15 13:31:41.474+00	2018-07-03 12:37:03.425+00	2
398	Squatting Arms Serving with Magic Circle Arms	<p><u><strong>Set Up</strong></u></p>\r\n<p>Standing over carriage facing foot bar in wide squar hips in external rotation. Deep squat so sit bones are almost touching carriage holding Magic Circle. Straps in hands.</p>\r\n<p>Elbos bent as though holding a tray in hands.</p>\r\n<p><br></p>\r\n<p><u><strong>The Excersise&nbsp;</strong></u></p>\r\n<p>Exhale press hands forward extending elbows keeping the "tray" level. Inhale return to start.&nbsp;</p>	1 RED or 1 BLUE	IMG_9835.jpg		2018-04-15 13:49:53.202+00	2018-09-02 03:43:34.843+00	2
392	Star Glutes 	<p><u><strong>Set Up</strong></u></p>\r\n<p>Kneeling side facing on carriage. Single arm comes to center of foot bar. Reach top leg straight. Arm beside side.</p>\r\n<p><br></p>\r\n<p><u><strong>The Exercise</strong></u></p>\r\n<p>Push into foot bar arm to press out into a side plank to point of control raising top arm. Lift and lower top leg x 10 while in extended side plank To make it harder use lighter springs.&nbsp;</p>\r\n<p><br></p>\r\n<p><u><strong>NOTE; Maintain good head neck and shoulder alignment.&nbsp;</strong></u></p>	1 RED or 1 BLUE 	Star Glutes.jpg		2018-04-15 13:26:16.639+00	2018-07-03 12:36:49.295+00	2
400	Chest Lift Obliques Magic Circle 	<p><u><strong>Set Up&nbsp;</strong></u></p>\r\n<p>Lying supine on carriage or mat knees bent on foot bar, mat or top of jump board. Hands interlaced behind head.&nbsp;You can also lye supine on Long Box. Magic Circle between knees.&nbsp;</p>\r\n<p><br></p>\r\n<p><u><strong>The Exercise&nbsp;</strong></u></p>\r\n<p>Inhale prepare. Exhale lift head neck and shoulders into chest lift.&nbsp;Rotate shoulder towards left knee squeeze magic circle with left knee only. Alternte sides. connecting to the antirior oblique sling. &nbsp;</p>	1 RED or MAT 	Chest Lift Obliques Magic Circle.jpg		2018-04-15 23:53:17.753+00	2018-09-01 01:40:37.089+00	1
397	Squatting Arms Triceps with Magic Circle 	<p><u><strong>Set Up</strong></u></p>\r\n<p>Standing over carriage facing foot bar in wide squar hips in external rotation. Deep squat so sit bones are almost touching carriage holding Magic Circle. Straps in hands.</p>\r\n<p><br></p>\r\n<p><u><strong>The Exercise</strong></u></p>\r\n<p>Lift arms holding Magic Circle above head elbows parallel and high. Exhale press into tricep press keeping elbows still in space. Inhale return to set up. &nbsp;</p>	1 RED or 1 BLUE 	Squatting Arms Triceps with Magic Circle.jpg		2018-04-15 13:49:16.23+00	2018-09-02 03:42:08.158+00	2
401	Plank Magic Circle	<p><u><strong>Set Up</strong></u>&nbsp;</p>\r\n<p>Come into plank position. On feet or knees. Reach single arm out shoulder width apart and hold Magic Circle pressing it towards the ground.&nbsp;</p>\r\n<p><br></p>\r\n<p><u><strong>The Exercise</strong></u></p>\r\n<p>Maintain strong plank. Exhale press circle down towards ground. Inhale release. Repeat.&nbsp;</p>\r\n<p><br></p>\r\n<p><em><strong>NOTE; Maintain strong shoulder alignment. To regress go to 4 point kneeling on knees.&nbsp;</strong></em></p>	MAT 	\N		2018-04-15 23:57:04.248+00	2018-04-18 13:18:47.724+00	1
404	Footwork in Chest Lift Heels 	<p><u><strong>Set up</strong></u></p>\r\n<p>Supine. Heels on foot bar parallel. Blue ball or rolled up mat under scapular, hands interlaced behind head. Chest lift.</p>\r\n<p><br></p>\r\n<p>T<u><strong>he Exercise</strong></u></p>\r\n<p>Inhale to prepare. Exhale press heels into foot bar to extend knees. Maintain chest lift use exhalating to deepen abdominal scoop and core connection. &nbsp;</p>\r\n<p><br></p>\r\n<p><em><strong>NOTE Optional add pulses.&nbsp;</strong></em></p>	3 RED 	Footwork in Chest Lift Hees.JPG		2018-04-16 00:03:13.458+00	2018-06-30 10:58:14.185+00	1
403	Footwork in Chest Lift Toes 	<p><u><strong>Set up</strong></u></p>\r\n<p>Supine. Toes (balls of feet) on foot bar parallel. Blue ball or rolled up mat under scapular, hands interlaced behind head. Chest lift.</p>\r\n<p><br></p>\r\n<p>T<u><strong>he Exercise</strong></u></p>\r\n<p>Inhale to prepare. Exhale press toes into foot bar to extend knees. Maintain chest lift use exhalating to deepen abdominal scoop and core connection. &nbsp;</p>\r\n<p><br></p>\r\n<p><em><strong>NOTE Optional add pulses.&nbsp;</strong></em></p>	3 RED	Footwork in Chest Lift Toes.JPG		2018-04-16 00:02:03.68+00	2018-06-30 11:11:25.637+00	1
402	Footwork in Chest Lift Small V	<p><u><strong>Set up</strong></u></p>\r\n<p>Supine. Toes in small V on foot bar. Blue ball or rolled up mat under scapular, hands interlaced behind head. Chest lift.</p>\r\n<p><br></p>\r\n<p>T<u><strong>he Exercise</strong></u></p>\r\n<p>Inhale to prepare. Exhale press toes into foot bar to extend knees. Maintain chest lift use exhalating to deepen abdominal scoop and core connection. &nbsp;Squeeze heels together.&nbsp;</p>\r\n<p><br></p>\r\n<p><em><strong>NOTE Optional add pulses.&nbsp;</strong></em></p>	3 RED 	Footwork in Chest Lift V.JPG		2018-04-16 00:00:32.777+00	2018-06-30 11:12:05.006+00	1
406	Footwork in Chest Lift Wide Heels	<p><u><strong>Set up</strong></u></p>\r\n<p>Supine. Heels on footbar wide exterally rotated to 45 degrees. Blue ball or rolled up mat under scapular, hands interlaced behind head. Chest lift.</p>\r\n<p><br></p>\r\n<p>T<u><strong>he Exercise</strong></u></p>\r\n<p>Inhale to prepare. Exhale press heels into foot bar to extend knees. Maintain chest lift use exhalating to deepen abdominal scoop and core connection. &nbsp;</p>\r\n<p><br></p>\r\n<p><em><strong>NOTE; Optional add pulses.&nbsp;</strong></em><em><strong>To challenge core change to BLUE spring and slow down.&nbsp;</strong></em></p>	3 RED	Footwork in Chest Lift Wide HeelsJPG.JPG		2018-04-16 00:05:37.292+00	2018-06-30 11:12:46.788+00	1
405	Footwork in Chest Lift Wide V Toes 	<p><u><strong>Set up</strong></u></p>\r\n<p>Supine. Toes (balls of feet) on foot wide exterally rotated to 45 degrees. Blue ball or rolled up mat under scapular, hands interlaced behind head. Chest lift.</p>\r\n<p><br></p>\r\n<p>T<u><strong>he Exercise</strong></u></p>\r\n<p>Inhale to prepare. Exhale press toes into foot bar to extend knees. Maintain chest lift use exhalating to deepen abdominal scoop and core connection. &nbsp;</p>\r\n<p><br></p>\r\n<p><em><strong>NOTE Optional add pulses.&nbsp;</strong></em></p>	3 RED	Footwork in Chest Lift Wide Toes.JPG		2018-04-16 00:04:40.287+00	2018-06-30 11:13:56.557+00	1
408	Footwork in Chest Lift Prances	<p><u><strong>Set up</strong></u></p>\r\n<p>Supine. Toes (balls of feet) on footbar hip distance apart parallel. Blue ball or rolled up mat under scapular, hands interlaced behind head. Chest lift.</p>\r\n<p><br></p>\r\n<p>T<u><strong>he Exercise</strong></u></p>\r\n<p>Inhale to prepare. Exhale press toes into foot bar to extend knees. Inhale sink left heel under the bar bending right knee. &nbsp;Exhale alternate legs. &nbsp;Maintain chest lift use exhalating to deepen abdominal scoop and core connection.&nbsp;</p>\r\n<p><br></p>\r\n<p><em><strong>NOTE; To challenge core change to BLUE spring and slow down.&nbsp;</strong></em></p>	3 RED	Footwork in Chest Lift Prances.jpg		2018-04-16 00:10:31.541+00	2018-09-01 01:41:09.245+00	1
407	Footwork in Chest Lift Rises	<p><u><strong>Set up</strong></u></p>\r\n<p>Supine. Toes (balls of feet) on footbar hip distance apart parallel. Blue ball or rolled up mat under scapular, hands interlaced behind head. Chest lift.</p>\r\n<p><br></p>\r\n<p>T<u><strong>he Exercise</strong></u></p>\r\n<p>Inhale to prepare. Exhale press toes into foot bar to extend knees. Inhale sink heels under bar. Exhale lift into calf rise. Maintain chest lift use exhalating to deepen abdominal scoop and core connection. &nbsp;</p>\r\n<p><br></p>\r\n<p><em><strong>NOTE; To challenge core change to BLUE spring and slow down.&nbsp;</strong></em></p>	3 RED	Footwork in Chest Lift Rises.jpg		2018-04-16 00:07:42.935+00	2018-09-01 01:41:14.924+00	1
410	Pelvic Curl Press Blue 	<p><u><strong>Set up</strong></u></p>\r\n<p>Supine. Heels or toes on foot bar. Spine neutral. Arms by sides. Head rest down.&nbsp;</p>\r\n<p><br></p>\r\n<p><u><strong>The Exercise</strong></u></p>\r\n<p>Inhale to prepare. Exhale move through imprint, curl tail bone to pubic bone, pubic bone to navle roll up 1 vertebra at a time to T6. Press carriage out. Exhale draw carriage in.&nbsp;</p>\r\n<p><br></p>\r\n<p><strong>TEACHING TIP; Squeeze greator trocantor (clients know these at hip bones, or out side of thighs) together to activat glutes. &nbsp;Be sure not to roll into spine extension. Sink the sternum lift the Pubic Bone.&nbsp;If client has a hamstring cramp stretch it out and try again. It is in the Supine legs category in hope to warm up legs first to prevant cramping.</strong></p>	1 BLUE	Pelvic Curl Press Blue.jpg		2018-04-17 22:37:50.164+00	2018-09-01 02:04:41.939+00	1
411	Pelvic Tilts Straight Legs 	<p><u><strong>Set up</strong></u></p>\r\n<p>Supine. Toes or heels on foot bar. Spine neutral. Arms by sides. Head rest down.&nbsp;Curl up into Pelvic Curl Press</p>\r\n<p><br></p>\r\n<p><u><strong>The Exercise</strong></u></p>\r\n<p>Holding the carriage out roll down one vertebra at a time until sacrum reaches bed. Exhale pelvic tilt &nbsp;drawing pubic bone to belly button. Use deep low core and glutes togehter.&nbsp;</p>\r\n<p><em>&nbsp;</em></p>\r\n<p><u><em><strong>TEACHING TIP;</strong></em></u><em><strong> Squeeze greator trocantors (clients know these at hip bones, or out side of thighs) together to activat glutes. &nbsp;If client has a hamstring cramp stretch it out and try again. It is in the Supine legs category in hope to warm up legs first to prevant cramping.</strong></em></p>	1 BLUE 	Pelvic Tilts Straight Legs.jpg		2018-04-17 22:47:18.274+00	2018-09-01 02:04:53.659+00	1
412	Pelvic Tilt Straight Legs Prances 	<p><u><strong>Set up</strong></u></p>\r\n<p>Supine. Toes on foot bar. Spine neutral. Arms by sides. Head rest down.&nbsp;Curl up into Pelvic Curl Press</p>\r\n<p><br></p>\r\n<p><u><strong>The Exercise</strong></u></p>\r\n<p>Holding the carriage out maintain Pelvic Tilt. Bend the left knee sink the right heel under footbar. Alterante.</p>\r\n<p><br></p>\r\n<p><u><strong>TEACHING TIP</strong></u><u><em><strong>;</strong></em></u><em><strong> Keep Pelvis stable as thought ballancing a cup of water on pubic bone. Squeeze greator trocantors (clients know these at hip bones, or out side of thighs) together to activat glutes. Move through Pelvic Curl/ Press/ Tilt on BLUE as a preperation for the exercise.&nbsp;It is in the Supine legs category in hope to warm up legs first to prevant cramping.</strong></em></p>	1 BLUE 	\N		2018-04-17 22:51:46.218+00	2018-04-18 13:18:47.724+00	1
413	Roll Up Reformer	<p><u><strong>Set up&nbsp;</strong></u></p>\r\n<p>Supine. Head rest down. Arms reaching towards celiling. Heels wide V on footbar. Knees bent.</p>\r\n<p><br></p>\r\n<p><u><strong>The Exercise</strong></u></p>\r\n<p>Inhale to prepare. Exhale start to extend knees and simultaneously roll up from crown of head one vertebrea at a time. Reaching arms forward. Knees are full exteded by the time you reach your sitbones. Inhale roll back down simultaneously bending knees.</p>\r\n<p><br></p>\r\n<p><u><strong>Theaching Tip;</strong></u><em><strong> Breath is key. Wiggle away from shoulder rests a little before rolling up. &nbsp;</strong></em></p>	1 BLUE 	\N		2018-04-17 22:57:46.199+00	2018-04-18 13:18:47.724+00	1
414	Hands in Straps Chicken Wings	<p><u><strong>Set up</strong></u></p>\r\n<p>Supine. Hands in straps. Spine neutral. Legs table top. Head rest comfortable. If the core is not strong enough lumbar spine can imprint otherwise neutral pelvis. Hands reachingdown along body.&nbsp;</p>\r\n<p><br></p>\r\n<p><u><strong>The Exercise</strong></u></p>\r\n<p>Inhale bend elbows and gluide hands along bed. Elbos go out to sides. Shoulders abduct. Exhale push hands back to set up.&nbsp;</p>\r\n<p><br></p>\r\n<p><u><em><strong>TEACHING TIP;</strong></em></u><em><strong> A great excercise inbetween other Hands in Straps exercises.&nbsp;</strong></em></p>	1 RED 1 BLUE 	\N		2018-04-18 01:01:14.24+00	2018-04-18 13:18:47.724+00	1
415	Feet in Straps No Straps Frogs 	<p><u><strong>Set up</strong></u></p>\r\n<p>Supine. Spine and Pelvis Neutral. Head rest comfortable. &nbsp;&nbsp;Feet in V knees in like with second big toe.&nbsp;Lift legs to 45 degree angel or point of control</p>\r\n<p><br></p>\r\n<p><u><strong>The Exercise</strong></u></p>\r\n<p>Inhale bend knees into small frog. Exhale press feetawey from body to extend knees. Spine and Pelvis maintain neutral or imprint. Inhale bend back to starting position.&nbsp;</p>\r\n<p><br></p>\r\n<p><u><strong>TEACHING TIP;</strong></u><em><strong> Feel as though feet are pushing into straps. This is a long leaver for the abdominals. Choose imprint or neutral and maintain thoughout.&nbsp;</strong></em></p>	1 RED 	\N		2018-04-18 01:05:32.902+00	2018-04-18 13:18:47.724+00	1
416	Feet in Straps No Straps Circles	<p><u><strong>Set up</strong></u></p>\r\n<p>Supine. Spine and Pelvis Neutral. Head rest comfortable. &nbsp;Straight legs lifted to 90 degrees or as close to L shape as possible.&nbsp;</p>\r\n<p><br></p>\r\n<p><u><strong>The Exercise</strong></u></p>\r\n<p>Cxhale circle straight legs around. Alternat direction. Spine and Pelvis maintain neutral or imprint. Inhale bend back to starting position.&nbsp;</p>\r\n<p><br></p>\r\n<p><u><strong>TEACHING TIP;</strong></u><em><strong> Feel as though feet are pushing into straps. This is a long leaver for the abdominals. Choose imprint or neutral and maintain thoughout.&nbsp;</strong></em></p>	1 RED 	\N		2018-04-18 01:07:59.245+00	2018-04-18 13:18:47.724+00	1
417	Feet in Straps No Straps Parallel Knee Bends	<p><u><strong>Set up</strong></u></p>\r\n<p>Supine. Spine and Pelvis Neutral. Head rest comfortable. &nbsp;Legs in Table Top. Legs together.</p>\r\n<p><br></p>\r\n<p><u><strong>The Exercise</strong></u></p>\r\n<p>Exhale extend knees Inhale return to Table top. Extend knees only to point of control. Spine and Pelvis maintain neutral or imprint.&nbsp;</p>\r\n<p><br></p>\r\n<p><u><strong>TEACHING TIP;</strong></u><em><strong> Feel as though feet are pushing into straps. This is a long leaver for the abdominals. Choose imprint or neutral and maintain thoughout.&nbsp;</strong></em></p>	1 RED 	\N		2018-04-18 01:14:15.962+00	2018-04-18 13:18:47.724+00	1
418	Long Stretch Combo 	<p><u><strong>Set Up</strong></u></p>\r\n<p>Extended Plank.&nbsp;</p>\r\n<p><br></p>\r\n<p><u><strong>The Exercise&nbsp;</strong></u></p>\r\n<p>x2 Inverted V, &nbsp;x2 Jack Rabbit, x Long Stretch. x 2 Push Ups. Reteate x 10</p>\r\n<p><br></p>\r\n<p><u><strong>TEACHING TIP; </strong></u><em><strong>Please review each individual exercise.&nbsp;</strong></em></p>	1 RED 1 BLUE 	\N		2018-04-18 01:21:03.91+00	2018-04-18 13:18:47.724+00	1
420	Green Room Modified 	<p><u><strong>Set up</strong></u></p>\r\n<p>Sitting at bottom edge of carriage. Knees bent. Legs straight thread through onto head rest. Thread arms through strpas till on elbows. &nbsp;Elbows level with shoulders. Sitting tall. &nbsp;</p>\r\n<p><br></p>\r\n<p><u><strong>The Excercise&nbsp;</strong></u></p>\r\n<p>Inhale to prepare. Exhale roll back into C curve until Sacrum is in contact with carriage. Inhale at bottom. Exhale roll back up to start position.&nbsp;</p>\r\n<p><br></p>\r\n<p><u><strong>TEACHING TIP;</strong></u><em><strong> Keep elbows in line with shoulders.&nbsp;</strong></em></p>	1 BLUE 	\N		2018-04-18 10:56:25.727+00	2018-04-18 13:18:47.724+00	1
421	Green Room Modified Obliques 	<p><u><strong>Set up</strong></u></p>\r\n<p>Sitting at bottom edge of carriage. Knees bent. Legs straight thread through onto head rest. Thread arms through strpas till on elbows. &nbsp;Elbows level with shoulders. Sitting tall. &nbsp;</p>\r\n<p><br></p>\r\n<p><u><strong>The Excercise&nbsp;</strong></u></p>\r\n<p>Inhale to prepare. Exhale roll back into C curve until Sacrum is in contact with carriage. Rotate thoracic spine towards side. Alternate sides x 10 Exhale roll back up to set up.&nbsp;</p>\r\n<p><br></p>\r\n<p><u><strong>TEACHING TIP;</strong></u><em><strong> Keep elbows in line with shoulders. The strap will go slack in one elbow as rotation occurs.&nbsp;</strong></em></p>	1 BLUE	\N		2018-04-18 11:08:26.932+00	2018-04-18 13:18:47.724+00	1
422	Green Room Rainbow Arms 	<p><u><strong>Set up</strong></u></p>\r\n<p>Sitting at bottom edge of carriage. Knees bent. Legs straight thread through onto head rest. Holding straps. Straps crossed or straight.</p>\r\n<p><br></p>\r\n<p><u><strong>The Excercise&nbsp;</strong></u></p>\r\n<p>Inhale to prepare. Exhale roll back into C curve until Sacrum is in contact with carriage. Lifting straight arms to 45 degrees high keeping fists in line with shoulders. &nbsp;Rotate thoracic spine towards side. Rainbow arms and thoracic spine to other side. Alternate sides x 10 Exhale roll back up to set up.&nbsp;</p>\r\n<p><br></p>\r\n<p><u><strong>TEACHING TIP;</strong></u><em><strong> Keep fists as wide as shoulders.&nbsp;</strong></em></p>	1 BLUE 	\N		2018-04-18 11:12:10.162+00	2018-04-18 13:18:47.724+00	1
\.


--
-- Data for Name: labels; Type: TABLE DATA; Schema: public; Owner: phoenix_lib
--

COPY public.labels (id, type, name, description, color, "createdAt", "updatedAt") FROM stdin;
1	0	Pump	\N	\N	2018-03-21 16:02:59+00	2018-03-21 16:02:59+00
2	0	Jump	\N	\N	2018-03-21 16:02:59+00	2018-03-21 16:02:59+00
3	0	Connect	\N	\N	2018-03-21 16:02:59+00	2018-03-21 16:02:59+00
4	0	Freestyle	\N	\N	2018-03-21 16:02:59+00	2018-03-21 16:02:59+00
5	0	Technique	\N	\N	2018-03-21 16:02:59+00	2018-03-21 16:02:59+00
6	1	Warm Up	\N	\N	2018-03-21 16:02:59+00	2018-03-21 16:02:59+00
7	1	Supine Legs	\N	\N	2018-03-21 16:02:59+00	2018-03-21 16:02:59+00
8	1	Supine Arms & Abs	\N	\N	2018-03-21 16:02:59+00	2018-03-21 16:02:59+00
9	1	Weight Bearing Arms	\N	\N	2018-03-21 16:02:59+00	2018-03-21 16:02:59+00
10	1	Seated / Knealing	\N	\N	2018-03-21 16:02:59+00	2018-03-21 16:02:59+00
11	1	Prone	\N	\N	2018-03-21 16:02:59+00	2018-03-21 16:02:59+00
12	1	Full Body / Standing	\N	\N	2018-03-21 16:02:59+00	2018-03-21 16:02:59+00
13	1	Jump	\N	\N	2018-04-03 17:02:59+00	2018-04-03 17:02:59+00
14	1	Core and HIIT	\N	\N	2018-04-03 17:02:59+00	2018-04-03 17:02:59+00
15	1	Jump Side Lying	\N	\N	2018-05-21 17:02:59+00	2018-05-21 17:02:59+00
\.


--
-- Data for Name: ping; Type: TABLE DATA; Schema: public; Owner: phoenix_lib
--

COPY public.ping (id, "lastPing") FROM stdin;
127056	2024-12-05 13:13:50.65+00
\.


--
-- Data for Name: templates; Type: TABLE DATA; Schema: public; Owner: phoenix_lib
--

COPY public.templates (id, categories, "createdAt", "updatedAt") FROM stdin;
1	6,13,14,15,13,10,9,14,13,14	2018-04-18 13:18:47.692+00	2018-04-18 13:18:47.692+00
2	6,7,8,9,10,11,12	2018-04-18 13:18:47.692+00	2018-04-18 13:18:47.692+00
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: phoenix_lib
--

COPY public.users (id, "firstName", "lastName", email, password, "lastLogin", "createdAt", "updatedAt", permissions, logins) FROM stdin;
1	Liz	Chamas	magnoliasoup@gmail.com	pbkdf2$10000$b38c4931c3346ce44b32235b4859ca55b01417bc9c4d69972a26eb79cba9bc5642c3ed31b9c0d84e9e311571400334e04c2b423a339ac53c93173db863287558$a5ad0fc8634bb4914c06b13c7b94cba83e9908f1147b3612504f7577084796ad5b1caf4160b338c92e7efa94d08aef20bd3fb1c05c63241606099988e556c091$sha512	2023-04-11 01:19:34.272+00	2018-03-30 02:46:57.012+00	2023-04-11 01:19:34.273+00	333	72
10	Phoenix	Pilates	info@phoenixpilates.org	pbkdf2$10000$f911b9457cba618e857ed69ea34f1750bcbd914fb55704554b39eb6de5022e8cccffcec3b77668c4de690be046835b3b28d22bdbcc8f9ff90f74bff1567bb601$e5a404d4bfb9044f0dd09a6cf4110a37d8aa25aa52427f63971689640ce4878382ea6ccc6de3a7bb48c3857b0b2d01e18b907fed5e863482d34a288592cee638$sha512	2023-04-11 03:19:10.66+00	2023-04-11 01:21:05.967+00	2023-04-11 03:19:10.661+00	333	3
3	Ali	Chamas	dragonworxau@yahoo.com.au	pbkdf2$10000$e1d28cf859db3e9a43b1b029ad07d6815ee32090be4415feaae947ccfd502f3c77fc47c0768414f1f97fe9c77d9563a46a9850bb1a52abbdacbaa4a40175f8d1$daa52c5b030ee2e7f210f51c47f7fa1d9000f7d7be9b5b064f32c1cc1631afff07f05add21b153fbc21d155f6dcd8f2cc5b3e0d29c865e49f63187f8fb1bfb3b$sha512	2024-12-05 03:23:37.707+00	2018-06-14 14:26:18.012+00	2024-12-05 03:23:37.709+00	333	2
\.


--
-- Name: classExercises_id_seq; Type: SEQUENCE SET; Schema: public; Owner: phoenix_lib
--

SELECT pg_catalog.setval('public."classExercises_id_seq"', 4909, true);


--
-- Name: classMovementCategories_id_seq; Type: SEQUENCE SET; Schema: public; Owner: phoenix_lib
--

SELECT pg_catalog.setval('public."classMovementCategories_id_seq"', 1291, true);


--
-- Name: classTemplates_id_seq; Type: SEQUENCE SET; Schema: public; Owner: phoenix_lib
--

SELECT pg_catalog.setval('public."classTemplates_id_seq"', 5, true);


--
-- Name: classes_id_seq; Type: SEQUENCE SET; Schema: public; Owner: phoenix_lib
--

SELECT pg_catalog.setval('public.classes_id_seq', 19, true);


--
-- Name: exercise_labels_id_seq; Type: SEQUENCE SET; Schema: public; Owner: phoenix_lib
--

SELECT pg_catalog.setval('public.exercise_labels_id_seq', 3144, true);


--
-- Name: exercises_id_seq; Type: SEQUENCE SET; Schema: public; Owner: phoenix_lib
--

SELECT pg_catalog.setval('public.exercises_id_seq', 439, true);


--
-- Name: labels_id_seq; Type: SEQUENCE SET; Schema: public; Owner: phoenix_lib
--

SELECT pg_catalog.setval('public.labels_id_seq', 12, true);


--
-- Name: ping_id_seq; Type: SEQUENCE SET; Schema: public; Owner: phoenix_lib
--

SELECT pg_catalog.setval('public.ping_id_seq', 127056, true);


--
-- Name: templates_id_seq; Type: SEQUENCE SET; Schema: public; Owner: phoenix_lib
--

SELECT pg_catalog.setval('public.templates_id_seq', 2, true);


--
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: phoenix_lib
--

SELECT pg_catalog.setval('public.users_id_seq', 10, true);


--
-- Name: classExercises classExercises_pkey; Type: CONSTRAINT; Schema: public; Owner: phoenix_lib
--

ALTER TABLE ONLY public."classExercises"
    ADD CONSTRAINT "classExercises_pkey" PRIMARY KEY (id);


--
-- Name: classMovementCategories classMovementCategories_pkey; Type: CONSTRAINT; Schema: public; Owner: phoenix_lib
--

ALTER TABLE ONLY public."classMovementCategories"
    ADD CONSTRAINT "classMovementCategories_pkey" PRIMARY KEY (id);


--
-- Name: classTemplates classTemplates_pkey; Type: CONSTRAINT; Schema: public; Owner: phoenix_lib
--

ALTER TABLE ONLY public."classTemplates"
    ADD CONSTRAINT "classTemplates_pkey" PRIMARY KEY (id);


--
-- Name: classes classes_pkey; Type: CONSTRAINT; Schema: public; Owner: phoenix_lib
--

ALTER TABLE ONLY public.classes
    ADD CONSTRAINT classes_pkey PRIMARY KEY (id);


--
-- Name: exercise_labels exercise_labels_pkey; Type: CONSTRAINT; Schema: public; Owner: phoenix_lib
--

ALTER TABLE ONLY public.exercise_labels
    ADD CONSTRAINT exercise_labels_pkey PRIMARY KEY (id);


--
-- Name: exercises exercises_pkey; Type: CONSTRAINT; Schema: public; Owner: phoenix_lib
--

ALTER TABLE ONLY public.exercises
    ADD CONSTRAINT exercises_pkey PRIMARY KEY (id);


--
-- Name: labels labels_pkey; Type: CONSTRAINT; Schema: public; Owner: phoenix_lib
--

ALTER TABLE ONLY public.labels
    ADD CONSTRAINT labels_pkey PRIMARY KEY (id);


--
-- Name: ping ping_pkey; Type: CONSTRAINT; Schema: public; Owner: phoenix_lib
--

ALTER TABLE ONLY public.ping
    ADD CONSTRAINT ping_pkey PRIMARY KEY (id);


--
-- Name: templates templates_pkey; Type: CONSTRAINT; Schema: public; Owner: phoenix_lib
--

ALTER TABLE ONLY public.templates
    ADD CONSTRAINT templates_pkey PRIMARY KEY (id);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: phoenix_lib
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: class_id; Type: INDEX; Schema: public; Owner: phoenix_lib
--

CREATE UNIQUE INDEX class_id ON public.classes USING btree (id);


--
-- Name: exercise_id; Type: INDEX; Schema: public; Owner: phoenix_lib
--

CREATE UNIQUE INDEX exercise_id ON public.exercises USING btree (id);


--
-- PostgreSQL database dump complete
--

