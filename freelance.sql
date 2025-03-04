--
-- PostgreSQL database dump
--

-- Dumped from database version 17.2
-- Dumped by pg_dump version 17.2

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
-- Name: bids; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.bids (
    id integer NOT NULL,
    freelancer_id integer NOT NULL,
    project_id integer NOT NULL,
    bid_amount numeric(10,2) NOT NULL,
    message text,
    status character varying(20) DEFAULT 'pending'::character varying,
    sub_category_id integer NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT bids_bid_amount_check CHECK ((bid_amount >= (0)::numeric)),
    CONSTRAINT bids_status_check CHECK (((status)::text = ANY ((ARRAY['pending'::character varying, 'accepted'::character varying, 'rejected'::character varying])::text[])))
);


ALTER TABLE public.bids OWNER TO postgres;

--
-- Name: bids_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.bids_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.bids_id_seq OWNER TO postgres;

--
-- Name: bids_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.bids_id_seq OWNED BY public.bids.id;


--
-- Name: clients; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.clients (
    id integer NOT NULL,
    user_id integer NOT NULL,
    company_name character varying(100),
    industry character varying(50)
);


ALTER TABLE public.clients OWNER TO postgres;

--
-- Name: clients_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.clients_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.clients_id_seq OWNER TO postgres;

--
-- Name: clients_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.clients_id_seq OWNED BY public.clients.id;


--
-- Name: contract_statuses; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.contract_statuses (
    id integer NOT NULL,
    status_name character varying(20) NOT NULL
);


ALTER TABLE public.contract_statuses OWNER TO postgres;

--
-- Name: contract_statuses_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.contract_statuses_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.contract_statuses_id_seq OWNER TO postgres;

--
-- Name: contract_statuses_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.contract_statuses_id_seq OWNED BY public.contract_statuses.id;


--
-- Name: contracts; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.contracts (
    id integer NOT NULL,
    project_id integer NOT NULL,
    freelancer_id integer NOT NULL,
    start_date date NOT NULL,
    end_date date,
    payment numeric(10,2) NOT NULL,
    status_id integer DEFAULT 1 NOT NULL,
    CONSTRAINT contracts_payment_check CHECK ((payment >= (0)::numeric))
);


ALTER TABLE public.contracts OWNER TO postgres;

--
-- Name: contracts_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.contracts_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.contracts_id_seq OWNER TO postgres;

--
-- Name: contracts_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.contracts_id_seq OWNED BY public.contracts.id;


--
-- Name: freelancer_profiles; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.freelancer_profiles (
    id integer NOT NULL,
    user_id integer NOT NULL,
    skills text,
    experience_years integer,
    hourly_rate numeric(10,2),
    CONSTRAINT freelancer_profiles_experience_years_check CHECK ((experience_years >= 0)),
    CONSTRAINT freelancer_profiles_hourly_rate_check CHECK ((hourly_rate >= (0)::numeric))
);


ALTER TABLE public.freelancer_profiles OWNER TO postgres;

--
-- Name: freelancer_profiles_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.freelancer_profiles_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.freelancer_profiles_id_seq OWNER TO postgres;

--
-- Name: freelancer_profiles_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.freelancer_profiles_id_seq OWNED BY public.freelancer_profiles.id;


--
-- Name: messages; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.messages (
    id integer NOT NULL,
    sender_id integer NOT NULL,
    receiver_id integer NOT NULL,
    content text NOT NULL,
    sent_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.messages OWNER TO postgres;

--
-- Name: messages_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.messages_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.messages_id_seq OWNER TO postgres;

--
-- Name: messages_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.messages_id_seq OWNED BY public.messages.id;


--
-- Name: notifications; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.notifications (
    id integer NOT NULL,
    user_id integer NOT NULL,
    type character varying(50) NOT NULL,
    related_id integer,
    related_table character varying(50),
    message text NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT notifications_type_check CHECK (((type)::text = ANY ((ARRAY['message'::character varying, 'project_update'::character varying, 'bid_status'::character varying, 'payment'::character varying])::text[])))
);


ALTER TABLE public.notifications OWNER TO postgres;

--
-- Name: notifications_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.notifications_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.notifications_id_seq OWNER TO postgres;

--
-- Name: notifications_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.notifications_id_seq OWNED BY public.notifications.id;


--
-- Name: payments; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.payments (
    id integer NOT NULL,
    contract_id integer NOT NULL,
    amount numeric(10,2) NOT NULL,
    payment_date timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT payments_amount_check CHECK ((amount >= (0)::numeric))
);


ALTER TABLE public.payments OWNER TO postgres;

--
-- Name: payments_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.payments_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.payments_id_seq OWNER TO postgres;

--
-- Name: payments_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.payments_id_seq OWNED BY public.payments.id;


--
-- Name: project_categories; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.project_categories (
    id integer NOT NULL,
    name character varying(100) NOT NULL
);


ALTER TABLE public.project_categories OWNER TO postgres;

--
-- Name: project_categories_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.project_categories_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.project_categories_id_seq OWNER TO postgres;

--
-- Name: project_categories_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.project_categories_id_seq OWNED BY public.project_categories.id;


--
-- Name: projects; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.projects (
    id integer NOT NULL,
    client_id integer NOT NULL,
    title character varying(255) NOT NULL,
    description text,
    budget numeric(10,2),
    status character varying(20) DEFAULT 'open'::character varying,
    category_id integer NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT projects_budget_check CHECK ((budget >= (0)::numeric)),
    CONSTRAINT projects_status_check CHECK (((status)::text = ANY ((ARRAY['open'::character varying, 'in_progress'::character varying, 'completed'::character varying, 'cancelled'::character varying])::text[])))
);


ALTER TABLE public.projects OWNER TO postgres;

--
-- Name: projects_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.projects_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.projects_id_seq OWNER TO postgres;

--
-- Name: projects_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.projects_id_seq OWNED BY public.projects.id;


--
-- Name: resources; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.resources (
    id integer NOT NULL,
    user_id integer NOT NULL,
    project_id integer,
    contract_id integer,
    filename character varying(255) NOT NULL,
    uploaded_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT resources_check CHECK ((((project_id IS NOT NULL) AND (contract_id IS NULL)) OR ((contract_id IS NOT NULL) AND (project_id IS NULL))))
);


ALTER TABLE public.resources OWNER TO postgres;

--
-- Name: resources_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.resources_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.resources_id_seq OWNER TO postgres;

--
-- Name: resources_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.resources_id_seq OWNED BY public.resources.id;


--
-- Name: reviews; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.reviews (
    id integer NOT NULL,
    reviewer_id integer NOT NULL,
    reviewed_id integer NOT NULL,
    rating integer NOT NULL,
    comment text,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT reviews_rating_check CHECK (((rating >= 1) AND (rating <= 5)))
);


ALTER TABLE public.reviews OWNER TO postgres;

--
-- Name: reviews_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.reviews_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.reviews_id_seq OWNER TO postgres;

--
-- Name: reviews_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.reviews_id_seq OWNED BY public.reviews.id;


--
-- Name: service_categories; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.service_categories (
    id integer NOT NULL,
    name character varying(100) NOT NULL
);


ALTER TABLE public.service_categories OWNER TO postgres;

--
-- Name: service_categories_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.service_categories_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.service_categories_id_seq OWNER TO postgres;

--
-- Name: service_categories_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.service_categories_id_seq OWNED BY public.service_categories.id;


--
-- Name: sub_categories; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sub_categories (
    id integer NOT NULL,
    category_id integer NOT NULL,
    name character varying(100) NOT NULL
);


ALTER TABLE public.sub_categories OWNER TO postgres;

--
-- Name: sub_categories_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.sub_categories_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.sub_categories_id_seq OWNER TO postgres;

--
-- Name: sub_categories_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.sub_categories_id_seq OWNED BY public.sub_categories.id;


--
-- Name: transactions; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.transactions (
    id integer NOT NULL,
    user_id integer NOT NULL,
    contract_id integer,
    amount numeric(10,2) NOT NULL,
    transaction_date timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    type character varying(20) NOT NULL,
    CONSTRAINT transactions_amount_check CHECK ((amount >= (0)::numeric)),
    CONSTRAINT transactions_type_check CHECK (((type)::text = ANY ((ARRAY['deposit'::character varying, 'withdrawal'::character varying, 'payment'::character varying])::text[])))
);


ALTER TABLE public.transactions OWNER TO postgres;

--
-- Name: transactions_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.transactions_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.transactions_id_seq OWNER TO postgres;

--
-- Name: transactions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.transactions_id_seq OWNED BY public.transactions.id;


--
-- Name: user_statuses; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.user_statuses (
    id integer NOT NULL,
    user_id integer NOT NULL,
    status character varying(20) DEFAULT 'active'::character varying,
    CONSTRAINT user_statuses_status_check CHECK (((status)::text = ANY ((ARRAY['active'::character varying, 'suspended'::character varying, 'deleted'::character varying])::text[])))
);


ALTER TABLE public.user_statuses OWNER TO postgres;

--
-- Name: user_statuses_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.user_statuses_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.user_statuses_id_seq OWNER TO postgres;

--
-- Name: user_statuses_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.user_statuses_id_seq OWNED BY public.user_statuses.id;


--
-- Name: users; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.users (
    id integer NOT NULL,
    username character varying(50) NOT NULL,
    email character varying(100) NOT NULL,
    password_hash text NOT NULL,
    role character varying(20) NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT users_role_check CHECK (((role)::text = ANY ((ARRAY['admin'::character varying, 'client'::character varying, 'freelancer'::character varying])::text[])))
);


ALTER TABLE public.users OWNER TO postgres;

--
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.users_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.users_id_seq OWNER TO postgres;

--
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.users_id_seq OWNED BY public.users.id;


--
-- Name: bids id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.bids ALTER COLUMN id SET DEFAULT nextval('public.bids_id_seq'::regclass);


--
-- Name: clients id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.clients ALTER COLUMN id SET DEFAULT nextval('public.clients_id_seq'::regclass);


--
-- Name: contract_statuses id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.contract_statuses ALTER COLUMN id SET DEFAULT nextval('public.contract_statuses_id_seq'::regclass);


--
-- Name: contracts id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.contracts ALTER COLUMN id SET DEFAULT nextval('public.contracts_id_seq'::regclass);


--
-- Name: freelancer_profiles id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.freelancer_profiles ALTER COLUMN id SET DEFAULT nextval('public.freelancer_profiles_id_seq'::regclass);


--
-- Name: messages id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.messages ALTER COLUMN id SET DEFAULT nextval('public.messages_id_seq'::regclass);


--
-- Name: notifications id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.notifications ALTER COLUMN id SET DEFAULT nextval('public.notifications_id_seq'::regclass);


--
-- Name: payments id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.payments ALTER COLUMN id SET DEFAULT nextval('public.payments_id_seq'::regclass);


--
-- Name: project_categories id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.project_categories ALTER COLUMN id SET DEFAULT nextval('public.project_categories_id_seq'::regclass);


--
-- Name: projects id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.projects ALTER COLUMN id SET DEFAULT nextval('public.projects_id_seq'::regclass);


--
-- Name: resources id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resources ALTER COLUMN id SET DEFAULT nextval('public.resources_id_seq'::regclass);


--
-- Name: reviews id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.reviews ALTER COLUMN id SET DEFAULT nextval('public.reviews_id_seq'::regclass);


--
-- Name: service_categories id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.service_categories ALTER COLUMN id SET DEFAULT nextval('public.service_categories_id_seq'::regclass);


--
-- Name: sub_categories id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sub_categories ALTER COLUMN id SET DEFAULT nextval('public.sub_categories_id_seq'::regclass);


--
-- Name: transactions id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.transactions ALTER COLUMN id SET DEFAULT nextval('public.transactions_id_seq'::regclass);


--
-- Name: user_statuses id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_statuses ALTER COLUMN id SET DEFAULT nextval('public.user_statuses_id_seq'::regclass);


--
-- Name: users id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users ALTER COLUMN id SET DEFAULT nextval('public.users_id_seq'::regclass);


--
-- Data for Name: bids; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.bids (id, freelancer_id, project_id, bid_amount, message, status, sub_category_id, created_at) FROM stdin;
1	1	1	1400000.00	Готов разработать современный веб-сайт с учетом всех требований.	pending	2	2025-03-03 18:23:12.214251
2	2	1	1600000.00	Имею большой опыт в разработке интернет-магазинов, сделаю качественно.	pending	8	2025-03-03 18:23:12.214251
3	3	3	280000.00	Разработаю эффективную SMM стратегию для вашего бизнеса.	pending	14	2025-03-03 18:23:12.214251
4	4	4	650000.00	Создам креативный и запоминающийся анимационный ролик.	pending	19	2025-03-03 18:23:12.214251
5	6	5	380000.00	Предлагаю несколько вариантов дизайна упаковки, учту все пожелания.	accepted	4	2025-03-03 18:24:55.645033
6	1	5	420000.00	Имею опыт в дизайне упаковки для продуктов питания, портфолио по запросу.	rejected	7	2025-03-03 18:24:55.645033
7	9	6	1900000.00	Разработаю кросс-платформенное приложение с удобным интерфейсом.	pending	10	2025-03-03 18:24:55.645033
8	5	9	1750000.00	Backend разработка на Node.js - моя специализация, сделаю быстро и качественно.	accepted	9	2025-03-03 18:24:55.645033
9	7	7	230000.00	Настрою эффективную таргетированную рекламу, анализ и отчетность гарантирую.	pending	14	2025-03-03 18:24:55.645033
10	8	8	550000.00	Сниму профессиональный видеообзор с монтажом и эффектами.	accepted	20	2025-03-03 18:24:55.645033
11	4	10	700000.00	Создам качественные 3D модели одежды для вашего сайта.	pending	6	2025-03-03 18:24:55.645033
12	3	11	400000.00	Проведу комплексный SEO аудит и оптимизацию вашего сайта.	rejected	16	2025-03-03 18:24:55.645033
\.


--
-- Data for Name: clients; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.clients (id, user_id, company_name, industry) FROM stdin;
1	5	ТОО "Зерек Технологии"	Информационные технологии
2	6	ИП "Гүлназ Дизайн"	Дизайн и мода
3	7	Компания "Алтын Бастау"	Торговля
4	8	Фонд "Келешек"	Образование
5	16	ТОО "АйСеним"	Производство продуктов питания
6	17	ИП "Кайсар Курылыс"	Строительство
7	18	Салон красоты "Динара"	Сфера услуг
8	19	Интернет-магазин "Технодом"	Электроника и бытовая техника
\.


--
-- Data for Name: contract_statuses; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.contract_statuses (id, status_name) FROM stdin;
1	В ожидании
2	Активен
3	Завершен
4	Отменен
\.


--
-- Data for Name: contracts; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.contracts (id, project_id, freelancer_id, start_date, end_date, payment, status_id) FROM stdin;
1	1	1	2024-01-20	2024-03-20	1400000.00	2
2	2	2	2024-02-01	2024-02-15	500000.00	2
3	5	6	2024-02-05	2024-03-05	380000.00	2
4	9	5	2024-02-10	2024-04-10	1750000.00	2
5	8	8	2024-01-15	2024-01-25	550000.00	3
\.


--
-- Data for Name: freelancer_profiles; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.freelancer_profiles (id, user_id, skills, experience_years, hourly_rate) FROM stdin;
1	1	Веб-дизайн, логотипы, фирменный стиль	5	2500.00
2	2	Разработка веб-приложений, Python, JavaScript	3	3000.00
3	3	SMM, контент-маркетинг, SEO	2	2000.00
4	4	3D моделирование, анимация, видеомонтаж	4	2800.00
5	9	Веб-разработка, PHP, MySQL	6	3200.00
6	10	Графический дизайн, Adobe Illustrator, Photoshop	3	2300.00
7	11	Digital Marketing, SEO, SMM, PPC	4	2700.00
8	12	Видеомонтаж, Adobe Premiere Pro, After Effects	2	2100.00
9	13	Разработка мобильных приложений, Android, iOS	5	3500.00
10	14	Копирайтинг, контент-маркетинг	2	1900.00
11	15	Кибербезопасность, тестирование на проникновение	7	4000.00
\.


--
-- Data for Name: messages; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.messages (id, sender_id, receiver_id, content, sent_at) FROM stdin;
1	5	1	Здравствуйте, как продвигается работа над сайтом?	2025-03-03 18:23:12.271349
2	1	5	Добрый день, работа идет по плану, скоро отправлю вам промежуточный вариант.	2025-03-03 18:23:12.271349
\.


--
-- Data for Name: notifications; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.notifications (id, user_id, type, related_id, related_table, message, created_at) FROM stdin;
1	1	project_update	1	projects	Клиент запросил обновление по проекту "Разработка веб-сайта для онлайн-магазина".	2025-03-03 18:23:12.339286
2	5	message	2	messages	Новое сообщение от фрилансера Айдын.	2025-03-03 18:23:12.339286
\.


--
-- Data for Name: payments; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.payments (id, contract_id, amount, payment_date) FROM stdin;
1	1	500000.00	2025-03-03 18:23:12.238957
2	3	200000.00	2025-03-03 18:24:55.753311
3	4	700000.00	2025-03-03 18:24:55.753311
4	5	550000.00	2025-03-03 18:24:55.753311
\.


--
-- Data for Name: project_categories; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.project_categories (id, name) FROM stdin;
1	Веб-разработка
2	Графический дизайн
3	Мобильные приложения
4	Маркетинг
5	Видео и анимация
6	Поддержка и кибербезопасность
\.


--
-- Data for Name: projects; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.projects (id, client_id, title, description, budget, status, category_id, created_at) FROM stdin;
1	1	Разработка веб-сайта для онлайн-магазина	Нужен современный и удобный веб-сайт для продажи электроники.	1500000.00	open	1	2025-03-03 18:23:12.198521
2	2	Дизайн логотипа и фирменного стиля	Требуется разработка логотипа и фирменного стиля для бренда одежды.	500000.00	open	2	2025-03-03 18:23:12.198521
3	3	SMM кампания в Instagram	Необходимо провести SMM кампанию для увеличения продаж через Instagram.	300000.00	open	4	2025-03-03 18:23:12.198521
4	4	Создание анимационного ролика	Нужен короткий анимационный ролик для социальной рекламы.	700000.00	open	5	2025-03-03 18:23:12.198521
5	5	Дизайн упаковки для новой линейки чая	Нужен креативный дизайн упаковки для 5 видов чая.	400000.00	open	2	2025-03-03 18:24:55.606722
6	6	Разработка мобильного приложения для учета стройматериалов	Требуется приложение для Android и iOS для учета материалов на стройке.	2000000.00	in_progress	3	2025-03-03 18:24:55.606722
7	7	Настройка таргетированной рекламы в Instagram	Необходимо настроить и запустить таргетированную рекламу для привлечения клиентов.	250000.00	open	4	2025-03-03 18:24:55.606722
8	8	Видеообзор нового смартфона	Нужен качественный видеообзор нового смартфона для YouTube канала.	600000.00	completed	5	2025-03-03 18:24:55.606722
9	1	Разработка API для мобильного приложения	Требуется разработка backend API на Node.js.	1800000.00	in_progress	1	2025-03-03 18:24:55.606722
10	2	Создание 3D модели одежды	Необходима 3D модель новой коллекции одежды для сайта.	750000.00	open	2	2025-03-03 18:24:55.606722
11	3	SEO оптимизация сайта	Требуется полная SEO оптимизация сайта для улучшения позиций в поисковиках.	450000.00	cancelled	4	2025-03-03 18:24:55.606722
12	4	Разработка веб-платформы для онлайн-курсов	Нужна платформа для проведения онлайн-курсов с личным кабинетом и системой оплаты.	2500000.00	open	1	2025-03-03 18:24:55.606722
13	5	Дизайн упаковки для новой линейки чая	Нужен креативный дизайн упаковки для 5 видов чая.	400000.00	open	2	2025-03-03 18:29:15.22782
14	6	Разработка мобильного приложения для учета стройматериалов	Требуется приложение для Android и iOS для учета материалов на стройке.	2000000.00	in_progress	3	2025-03-03 18:29:15.22782
15	7	Настройка таргетированной рекламы в Instagram	Необходимо настроить и запустить таргетированную рекламу для привлечения клиентов.	250000.00	open	4	2025-03-03 18:29:15.22782
16	8	Видеообзор нового смартфона	Нужен качественный видеообзор нового смартфона для YouTube канала.	600000.00	completed	5	2025-03-03 18:29:15.22782
17	1	Разработка API для мобильного приложения	Требуется разработка backend API на Node.js.	1800000.00	in_progress	1	2025-03-03 18:29:15.22782
18	2	Создание 3D модели одежды	Необходима 3D модель новой коллекции одежды для сайта.	750000.00	open	2	2025-03-03 18:29:15.22782
19	3	SEO оптимизация сайта	Требуется полная SEO оптимизация сайта для улучшения позиций в поисковиках.	450000.00	cancelled	4	2025-03-03 18:29:15.22782
20	4	Разработка веб-платформы для онлайн-курсов	Нужна платформа для проведения онлайн-курсов с личным кабинетом и системой оплаты.	2500000.00	open	1	2025-03-03 18:29:15.22782
\.


--
-- Data for Name: resources; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.resources (id, user_id, project_id, contract_id, filename, uploaded_at) FROM stdin;
1	1	1	\N	дизайн_макет_главной_страницы.psd	2025-03-03 18:23:12.318304
\.


--
-- Data for Name: reviews; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.reviews (id, reviewer_id, reviewed_id, rating, comment, created_at) FROM stdin;
1	5	1	5	Отличный фрилансер, работа выполнена качественно и в срок!	2025-03-03 18:23:12.260444
2	1	5	5	Приятный заказчик, четкое ТЗ и своевременная оплата.	2025-03-03 18:23:12.260444
6	16	10	5	Дизайн упаковки получился отличным, все как и хотели!	2025-03-03 18:29:46.651945
7	10	16	5	Заказчик предоставил четкое ТЗ и был на связи, работать было комфортно.	2025-03-03 18:29:46.651945
8	19	12	4	Видеообзор качественный, но немного задержали сроки.	2025-03-03 18:29:46.651945
9	12	19	5	Хороший заказчик, оплата своевременная.	2025-03-03 18:29:46.651945
10	16	10	5	Дизайн упаковки получился отличным, все как и хотели!	2025-03-03 18:29:55.098308
11	10	16	5	Заказчик предоставил четкое ТЗ и был на связи, работать было комфортно.	2025-03-03 18:29:55.098308
12	19	12	4	Видеообзор качественный, но немного задержали сроки.	2025-03-03 18:29:55.098308
13	12	19	5	Хороший заказчик, оплата своевременная.	2025-03-03 18:29:55.098308
\.


--
-- Data for Name: service_categories; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.service_categories (id, name) FROM stdin;
1	Graphics & Design
2	Programming & Tech
3	Digital Marketing
4	Video & Animation
\.


--
-- Data for Name: sub_categories; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.sub_categories (id, category_id, name) FROM stdin;
1	1	Logo & Brand Identity
2	1	Web & App Design
3	1	Art & Illustration
4	1	Product & Gaming
5	1	Visual Design
6	1	3D Design
7	1	Marketing Design
8	2	Websites
9	2	Software Development
10	2	Mobile Apps
11	2	Support & Cybersecurity
12	2	Application Development
13	2	Website Platforms
14	3	Social
15	3	Methods & Techniques
16	3	Search
17	3	Industry & Purpose-Specific
18	3	Analytics & Strategy
19	4	Animation
20	4	Product Videos
21	4	Editing & Post-Production
22	4	Photo Editor
\.


--
-- Data for Name: transactions; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.transactions (id, user_id, contract_id, amount, transaction_date, type) FROM stdin;
1	5	\N	1000000.00	2025-03-03 18:23:12.308925	deposit
2	1	1	500000.00	2025-03-03 18:23:12.308925	payment
\.


--
-- Data for Name: user_statuses; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.user_statuses (id, user_id, status) FROM stdin;
1	1	active
2	2	active
3	3	active
4	4	active
5	5	active
6	6	active
7	7	active
8	8	active
9	9	active
10	10	active
11	11	active
12	12	active
13	13	active
14	14	active
15	15	active
16	16	active
17	17	active
18	18	active
19	19	active
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.users (id, username, email, password_hash, role, created_at) FROM stdin;
1	Айдын	aidyn@outlook.com	5f4dcc3b5aa765d61d8327deb882cf99	freelancer	2025-03-03 18:23:01.607328
2	Азамат	azamat@gmail.com	e99a18c428cb38d5f260853678922e03	freelancer	2025-03-03 18:23:01.607328
3	Мадина	madina@yandex.ru	098f6bcd4621d373cade4e832627b4f6	freelancer	2025-03-03 18:23:01.607328
4	Алия	aliya@mail.ru	25d55ad283aa400af464c76d713c07ad	freelancer	2025-03-03 18:23:01.607328
5	Ерлан	yerlan@bk.ru	81dc9bdb52d04dc20036dbd8313ed055	client	2025-03-03 18:23:01.607328
6	Гульмира	gulmira@icloud.com	202cb962ac59075b964b07152d234b70	client	2025-03-03 18:23:01.607328
7	Данияр	daniyar@inbox.ru	7c6a180b36896a0a8c02787eeafb0e4c	client	2025-03-03 18:23:01.607328
8	Сауле	saule@proton.me	6c569aabbf7775ef8fc570e228c16b98	client	2025-03-03 18:23:01.607328
9	Бауыржан	bauyrzhan@outlook.com	5f4dcc3b5aa765d61d8327deb882cf99	freelancer	2025-03-03 18:24:55.460931
10	Салтанат	saltanat@gmail.com	e99a18c428cb38d5f260853678922e03	freelancer	2025-03-03 18:24:55.460931
11	Тимур	timur@yandex.ru	098f6bcd4621d373cade4e832627b4f6	freelancer	2025-03-03 18:24:55.460931
12	Жанар	zhanar@mail.ru	25d55ad283aa400af464c76d713c07ad	freelancer	2025-03-03 18:24:55.460931
13	Руслан	ruslan@bk.ru	81dc9bdb52d04dc20036dbd8313ed055	freelancer	2025-03-03 18:24:55.460931
14	Айгуль	aigul@icloud.com	202cb962ac59075b964b07152d234b70	freelancer	2025-03-03 18:24:55.460931
15	Ержан	yerzhan@proton.me	7c6a180b36896a0a8c02787eeafb0e4c	freelancer	2025-03-03 18:24:55.460931
16	Асель	assel@outlook.com	6c569aabbf7775ef8fc570e228c16b98	client	2025-03-03 18:24:55.503942
17	Кайрат	kairat@gmail.com	c33367701511b4f6020ec61ded352059	client	2025-03-03 18:24:55.503942
18	Динара	dinara@mail.ru	8d9c307cb7f3c4a32822a51922d1ceaa	client	2025-03-03 18:24:55.503942
19	Марат	marat@bk.ru	d8578edf8458ce06fbc5bb76a58c5ca4	client	2025-03-03 18:24:55.503942
\.


--
-- Name: bids_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.bids_id_seq', 12, true);


--
-- Name: clients_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.clients_id_seq', 9, true);


--
-- Name: contract_statuses_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.contract_statuses_id_seq', 4, true);


--
-- Name: contracts_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.contracts_id_seq', 5, true);


--
-- Name: freelancer_profiles_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.freelancer_profiles_id_seq', 12, true);


--
-- Name: messages_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.messages_id_seq', 11, true);


--
-- Name: notifications_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.notifications_id_seq', 2, true);


--
-- Name: payments_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.payments_id_seq', 4, true);


--
-- Name: project_categories_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.project_categories_id_seq', 6, true);


--
-- Name: projects_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.projects_id_seq', 20, true);


--
-- Name: resources_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.resources_id_seq', 1, true);


--
-- Name: reviews_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.reviews_id_seq', 13, true);


--
-- Name: service_categories_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.service_categories_id_seq', 4, true);


--
-- Name: sub_categories_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.sub_categories_id_seq', 22, true);


--
-- Name: transactions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.transactions_id_seq', 4, true);


--
-- Name: user_statuses_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.user_statuses_id_seq', 19, true);


--
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.users_id_seq', 21, true);


--
-- Name: bids bids_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.bids
    ADD CONSTRAINT bids_pkey PRIMARY KEY (id);


--
-- Name: clients clients_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.clients
    ADD CONSTRAINT clients_pkey PRIMARY KEY (id);


--
-- Name: clients clients_user_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.clients
    ADD CONSTRAINT clients_user_id_key UNIQUE (user_id);


--
-- Name: contract_statuses contract_statuses_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.contract_statuses
    ADD CONSTRAINT contract_statuses_pkey PRIMARY KEY (id);


--
-- Name: contract_statuses contract_statuses_status_name_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.contract_statuses
    ADD CONSTRAINT contract_statuses_status_name_key UNIQUE (status_name);


--
-- Name: contracts contracts_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.contracts
    ADD CONSTRAINT contracts_pkey PRIMARY KEY (id);


--
-- Name: contracts contracts_project_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.contracts
    ADD CONSTRAINT contracts_project_id_key UNIQUE (project_id);


--
-- Name: freelancer_profiles freelancer_profiles_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.freelancer_profiles
    ADD CONSTRAINT freelancer_profiles_pkey PRIMARY KEY (id);


--
-- Name: freelancer_profiles freelancer_profiles_user_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.freelancer_profiles
    ADD CONSTRAINT freelancer_profiles_user_id_key UNIQUE (user_id);


--
-- Name: messages messages_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.messages
    ADD CONSTRAINT messages_pkey PRIMARY KEY (id);


--
-- Name: notifications notifications_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.notifications
    ADD CONSTRAINT notifications_pkey PRIMARY KEY (id);


--
-- Name: payments payments_contract_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.payments
    ADD CONSTRAINT payments_contract_id_key UNIQUE (contract_id);


--
-- Name: payments payments_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.payments
    ADD CONSTRAINT payments_pkey PRIMARY KEY (id);


--
-- Name: project_categories project_categories_name_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.project_categories
    ADD CONSTRAINT project_categories_name_key UNIQUE (name);


--
-- Name: project_categories project_categories_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.project_categories
    ADD CONSTRAINT project_categories_pkey PRIMARY KEY (id);


--
-- Name: projects projects_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.projects
    ADD CONSTRAINT projects_pkey PRIMARY KEY (id);


--
-- Name: resources resources_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resources
    ADD CONSTRAINT resources_pkey PRIMARY KEY (id);


--
-- Name: reviews reviews_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.reviews
    ADD CONSTRAINT reviews_pkey PRIMARY KEY (id);


--
-- Name: service_categories service_categories_name_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.service_categories
    ADD CONSTRAINT service_categories_name_key UNIQUE (name);


--
-- Name: service_categories service_categories_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.service_categories
    ADD CONSTRAINT service_categories_pkey PRIMARY KEY (id);


--
-- Name: sub_categories sub_categories_category_id_name_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sub_categories
    ADD CONSTRAINT sub_categories_category_id_name_key UNIQUE (category_id, name);


--
-- Name: sub_categories sub_categories_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sub_categories
    ADD CONSTRAINT sub_categories_pkey PRIMARY KEY (id);


--
-- Name: transactions transactions_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.transactions
    ADD CONSTRAINT transactions_pkey PRIMARY KEY (id);


--
-- Name: user_statuses user_statuses_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_statuses
    ADD CONSTRAINT user_statuses_pkey PRIMARY KEY (id);


--
-- Name: user_statuses user_statuses_user_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_statuses
    ADD CONSTRAINT user_statuses_user_id_key UNIQUE (user_id);


--
-- Name: users users_email_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key UNIQUE (email);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: users users_username_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_username_key UNIQUE (username);


--
-- Name: bids bids_freelancer_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.bids
    ADD CONSTRAINT bids_freelancer_id_fkey FOREIGN KEY (freelancer_id) REFERENCES public.freelancer_profiles(id) ON DELETE CASCADE;


--
-- Name: bids bids_project_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.bids
    ADD CONSTRAINT bids_project_id_fkey FOREIGN KEY (project_id) REFERENCES public.projects(id) ON DELETE CASCADE;


--
-- Name: bids bids_sub_category_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.bids
    ADD CONSTRAINT bids_sub_category_id_fkey FOREIGN KEY (sub_category_id) REFERENCES public.sub_categories(id) ON DELETE CASCADE;


--
-- Name: clients clients_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.clients
    ADD CONSTRAINT clients_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- Name: contracts contracts_freelancer_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.contracts
    ADD CONSTRAINT contracts_freelancer_id_fkey FOREIGN KEY (freelancer_id) REFERENCES public.freelancer_profiles(id) ON DELETE CASCADE;


--
-- Name: contracts contracts_project_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.contracts
    ADD CONSTRAINT contracts_project_id_fkey FOREIGN KEY (project_id) REFERENCES public.projects(id) ON DELETE CASCADE;


--
-- Name: contracts contracts_status_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.contracts
    ADD CONSTRAINT contracts_status_id_fkey FOREIGN KEY (status_id) REFERENCES public.contract_statuses(id);


--
-- Name: freelancer_profiles freelancer_profiles_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.freelancer_profiles
    ADD CONSTRAINT freelancer_profiles_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- Name: messages messages_receiver_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.messages
    ADD CONSTRAINT messages_receiver_id_fkey FOREIGN KEY (receiver_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- Name: messages messages_sender_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.messages
    ADD CONSTRAINT messages_sender_id_fkey FOREIGN KEY (sender_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- Name: notifications notifications_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.notifications
    ADD CONSTRAINT notifications_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- Name: payments payments_contract_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.payments
    ADD CONSTRAINT payments_contract_id_fkey FOREIGN KEY (contract_id) REFERENCES public.contracts(id) ON DELETE CASCADE;


--
-- Name: projects projects_category_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.projects
    ADD CONSTRAINT projects_category_id_fkey FOREIGN KEY (category_id) REFERENCES public.project_categories(id) ON DELETE CASCADE;


--
-- Name: projects projects_client_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.projects
    ADD CONSTRAINT projects_client_id_fkey FOREIGN KEY (client_id) REFERENCES public.clients(id) ON DELETE CASCADE;


--
-- Name: resources resources_contract_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resources
    ADD CONSTRAINT resources_contract_id_fkey FOREIGN KEY (contract_id) REFERENCES public.contracts(id) ON DELETE CASCADE;


--
-- Name: resources resources_project_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resources
    ADD CONSTRAINT resources_project_id_fkey FOREIGN KEY (project_id) REFERENCES public.projects(id) ON DELETE CASCADE;


--
-- Name: resources resources_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resources
    ADD CONSTRAINT resources_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- Name: reviews reviews_reviewed_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.reviews
    ADD CONSTRAINT reviews_reviewed_id_fkey FOREIGN KEY (reviewed_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- Name: reviews reviews_reviewer_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.reviews
    ADD CONSTRAINT reviews_reviewer_id_fkey FOREIGN KEY (reviewer_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- Name: sub_categories sub_categories_category_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sub_categories
    ADD CONSTRAINT sub_categories_category_id_fkey FOREIGN KEY (category_id) REFERENCES public.service_categories(id) ON DELETE CASCADE;


--
-- Name: transactions transactions_contract_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.transactions
    ADD CONSTRAINT transactions_contract_id_fkey FOREIGN KEY (contract_id) REFERENCES public.contracts(id) ON DELETE SET NULL;


--
-- Name: transactions transactions_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.transactions
    ADD CONSTRAINT transactions_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- Name: user_statuses user_statuses_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_statuses
    ADD CONSTRAINT user_statuses_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- Name: TABLE bids; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.bids TO admin_bruh;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.bids TO moderator_bruh;
GRANT SELECT,INSERT,UPDATE ON TABLE public.bids TO editor_bruh;
GRANT SELECT ON TABLE public.bids TO reader_bruh;


--
-- Name: SEQUENCE bids_id_seq; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON SEQUENCE public.bids_id_seq TO admin_bruh;


--
-- Name: TABLE clients; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.clients TO admin_bruh;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.clients TO moderator_bruh;
GRANT SELECT,INSERT,UPDATE ON TABLE public.clients TO editor_bruh;
GRANT SELECT ON TABLE public.clients TO reader_bruh;


--
-- Name: SEQUENCE clients_id_seq; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON SEQUENCE public.clients_id_seq TO admin_bruh;


--
-- Name: TABLE contract_statuses; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.contract_statuses TO admin_bruh;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.contract_statuses TO moderator_bruh;
GRANT SELECT,INSERT,UPDATE ON TABLE public.contract_statuses TO editor_bruh;
GRANT SELECT ON TABLE public.contract_statuses TO reader_bruh;


--
-- Name: SEQUENCE contract_statuses_id_seq; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON SEQUENCE public.contract_statuses_id_seq TO admin_bruh;


--
-- Name: TABLE contracts; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.contracts TO admin_bruh;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.contracts TO moderator_bruh;
GRANT SELECT,INSERT,UPDATE ON TABLE public.contracts TO editor_bruh;
GRANT SELECT ON TABLE public.contracts TO reader_bruh;


--
-- Name: SEQUENCE contracts_id_seq; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON SEQUENCE public.contracts_id_seq TO admin_bruh;


--
-- Name: TABLE freelancer_profiles; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.freelancer_profiles TO admin_bruh;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.freelancer_profiles TO moderator_bruh;
GRANT SELECT,INSERT,UPDATE ON TABLE public.freelancer_profiles TO editor_bruh;
GRANT SELECT ON TABLE public.freelancer_profiles TO reader_bruh;


--
-- Name: SEQUENCE freelancer_profiles_id_seq; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON SEQUENCE public.freelancer_profiles_id_seq TO admin_bruh;


--
-- Name: TABLE messages; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.messages TO admin_bruh;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.messages TO moderator_bruh;
GRANT SELECT,INSERT,UPDATE ON TABLE public.messages TO editor_bruh;
GRANT SELECT ON TABLE public.messages TO reader_bruh;


--
-- Name: SEQUENCE messages_id_seq; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON SEQUENCE public.messages_id_seq TO admin_bruh;


--
-- Name: TABLE notifications; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.notifications TO admin_bruh;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.notifications TO moderator_bruh;
GRANT SELECT,INSERT,UPDATE ON TABLE public.notifications TO editor_bruh;
GRANT SELECT ON TABLE public.notifications TO reader_bruh;


--
-- Name: SEQUENCE notifications_id_seq; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON SEQUENCE public.notifications_id_seq TO admin_bruh;


--
-- Name: TABLE payments; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.payments TO admin_bruh;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.payments TO moderator_bruh;
GRANT SELECT,INSERT,UPDATE ON TABLE public.payments TO editor_bruh;
GRANT SELECT ON TABLE public.payments TO reader_bruh;


--
-- Name: SEQUENCE payments_id_seq; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON SEQUENCE public.payments_id_seq TO admin_bruh;


--
-- Name: TABLE project_categories; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.project_categories TO admin_bruh;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.project_categories TO moderator_bruh;
GRANT SELECT,INSERT,UPDATE ON TABLE public.project_categories TO editor_bruh;
GRANT SELECT ON TABLE public.project_categories TO reader_bruh;


--
-- Name: SEQUENCE project_categories_id_seq; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON SEQUENCE public.project_categories_id_seq TO admin_bruh;


--
-- Name: TABLE projects; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.projects TO admin_bruh;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.projects TO moderator_bruh;
GRANT SELECT,INSERT,UPDATE ON TABLE public.projects TO editor_bruh;
GRANT SELECT ON TABLE public.projects TO reader_bruh;


--
-- Name: SEQUENCE projects_id_seq; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON SEQUENCE public.projects_id_seq TO admin_bruh;


--
-- Name: TABLE resources; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.resources TO admin_bruh;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.resources TO moderator_bruh;
GRANT SELECT,INSERT,UPDATE ON TABLE public.resources TO editor_bruh;
GRANT SELECT ON TABLE public.resources TO reader_bruh;


--
-- Name: SEQUENCE resources_id_seq; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON SEQUENCE public.resources_id_seq TO admin_bruh;


--
-- Name: TABLE reviews; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.reviews TO admin_bruh;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.reviews TO moderator_bruh;
GRANT SELECT,INSERT,UPDATE ON TABLE public.reviews TO editor_bruh;
GRANT SELECT ON TABLE public.reviews TO reader_bruh;


--
-- Name: SEQUENCE reviews_id_seq; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON SEQUENCE public.reviews_id_seq TO admin_bruh;


--
-- Name: TABLE service_categories; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.service_categories TO admin_bruh;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.service_categories TO moderator_bruh;
GRANT SELECT,INSERT,UPDATE ON TABLE public.service_categories TO editor_bruh;
GRANT SELECT ON TABLE public.service_categories TO reader_bruh;


--
-- Name: SEQUENCE service_categories_id_seq; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON SEQUENCE public.service_categories_id_seq TO admin_bruh;


--
-- Name: TABLE sub_categories; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.sub_categories TO admin_bruh;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.sub_categories TO moderator_bruh;
GRANT SELECT,INSERT,UPDATE ON TABLE public.sub_categories TO editor_bruh;
GRANT SELECT ON TABLE public.sub_categories TO reader_bruh;


--
-- Name: SEQUENCE sub_categories_id_seq; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON SEQUENCE public.sub_categories_id_seq TO admin_bruh;


--
-- Name: TABLE transactions; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.transactions TO admin_bruh;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.transactions TO moderator_bruh;
GRANT SELECT,INSERT,UPDATE ON TABLE public.transactions TO editor_bruh;
GRANT SELECT ON TABLE public.transactions TO reader_bruh;


--
-- Name: SEQUENCE transactions_id_seq; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON SEQUENCE public.transactions_id_seq TO admin_bruh;


--
-- Name: TABLE user_statuses; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.user_statuses TO admin_bruh;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.user_statuses TO moderator_bruh;
GRANT SELECT,INSERT,UPDATE ON TABLE public.user_statuses TO editor_bruh;
GRANT SELECT ON TABLE public.user_statuses TO reader_bruh;


--
-- Name: SEQUENCE user_statuses_id_seq; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON SEQUENCE public.user_statuses_id_seq TO admin_bruh;


--
-- Name: TABLE users; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.users TO admin_bruh;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.users TO moderator_bruh;
GRANT SELECT,INSERT,UPDATE ON TABLE public.users TO editor_bruh;
GRANT SELECT ON TABLE public.users TO reader_bruh;


--
-- Name: SEQUENCE users_id_seq; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON SEQUENCE public.users_id_seq TO admin_bruh;


--
-- PostgreSQL database dump complete
--

