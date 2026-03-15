--
-- PostgreSQL database dump
--

-- Dumped from database version 16.8
-- Dumped by pg_dump version 16.8

-- Started on 2026-03-15 19:50:18

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
-- TOC entry 4953 (class 1262 OID 16636)
-- Name: Sadiullina; Type: DATABASE; Schema: -; Owner: app
--

CREATE DATABASE "Sadiullina" WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'Russian_Russia.1251';


ALTER DATABASE "Sadiullina" OWNER TO app;

\connect "Sadiullina"

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
-- TOC entry 6 (class 2615 OID 16637)
-- Name: app; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA app;


ALTER SCHEMA app OWNER TO postgres;

--
-- TOC entry 226 (class 1255 OID 16719)
-- Name: update_updated_at_column(); Type: FUNCTION; Schema: app; Owner: postgres
--

CREATE FUNCTION app.update_updated_at_column() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    NEW.updated_at = CURRENT_TIMESTAMP;
    RETURN NEW;
END;
$$;


ALTER FUNCTION app.update_updated_at_column() OWNER TO postgres;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 217 (class 1259 OID 16639)
-- Name: partner_types_sadiullina; Type: TABLE; Schema: app; Owner: postgres
--

CREATE TABLE app.partner_types_sadiullina (
    id integer NOT NULL,
    name character varying(100) NOT NULL,
    description text
);


ALTER TABLE app.partner_types_sadiullina OWNER TO postgres;

--
-- TOC entry 216 (class 1259 OID 16638)
-- Name: partner_types_sadiullina_id_seq; Type: SEQUENCE; Schema: app; Owner: postgres
--

CREATE SEQUENCE app.partner_types_sadiullina_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE app.partner_types_sadiullina_id_seq OWNER TO postgres;

--
-- TOC entry 4954 (class 0 OID 0)
-- Dependencies: 216
-- Name: partner_types_sadiullina_id_seq; Type: SEQUENCE OWNED BY; Schema: app; Owner: postgres
--

ALTER SEQUENCE app.partner_types_sadiullina_id_seq OWNED BY app.partner_types_sadiullina.id;


--
-- TOC entry 219 (class 1259 OID 16650)
-- Name: partners_sadiullina; Type: TABLE; Schema: app; Owner: postgres
--

CREATE TABLE app.partners_sadiullina (
    id integer NOT NULL,
    type_id integer NOT NULL,
    company_name character varying(255) NOT NULL,
    legal_address text,
    inn character varying(12),
    director_fullname character varying(255),
    phone character varying(20),
    email character varying(100),
    rating integer DEFAULT 0 NOT NULL,
    logo_path text,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT partners_sadiullina_rating_check CHECK ((rating >= 0))
);


ALTER TABLE app.partners_sadiullina OWNER TO postgres;

--
-- TOC entry 218 (class 1259 OID 16649)
-- Name: partners_sadiullina_id_seq; Type: SEQUENCE; Schema: app; Owner: postgres
--

CREATE SEQUENCE app.partners_sadiullina_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE app.partners_sadiullina_id_seq OWNER TO postgres;

--
-- TOC entry 4955 (class 0 OID 0)
-- Dependencies: 218
-- Name: partners_sadiullina_id_seq; Type: SEQUENCE OWNED BY; Schema: app; Owner: postgres
--

ALTER SEQUENCE app.partners_sadiullina_id_seq OWNED BY app.partners_sadiullina.id;


--
-- TOC entry 221 (class 1259 OID 16670)
-- Name: products_sadiullina; Type: TABLE; Schema: app; Owner: postgres
--

CREATE TABLE app.products_sadiullina (
    id integer NOT NULL,
    article character varying(50) NOT NULL,
    name character varying(255) NOT NULL,
    description text,
    min_price numeric(15,2),
    unit character varying(20) DEFAULT 'шт'::character varying,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE app.products_sadiullina OWNER TO postgres;

--
-- TOC entry 220 (class 1259 OID 16669)
-- Name: products_sadiullina_id_seq; Type: SEQUENCE; Schema: app; Owner: postgres
--

CREATE SEQUENCE app.products_sadiullina_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE app.products_sadiullina_id_seq OWNER TO postgres;

--
-- TOC entry 4956 (class 0 OID 0)
-- Dependencies: 220
-- Name: products_sadiullina_id_seq; Type: SEQUENCE OWNED BY; Schema: app; Owner: postgres
--

ALTER SEQUENCE app.products_sadiullina_id_seq OWNED BY app.products_sadiullina.id;


--
-- TOC entry 223 (class 1259 OID 16683)
-- Name: sales_history_sadiullina; Type: TABLE; Schema: app; Owner: postgres
--

CREATE TABLE app.sales_history_sadiullina (
    id integer NOT NULL,
    partner_id integer NOT NULL,
    product_id integer NOT NULL,
    quantity integer NOT NULL,
    sale_date date NOT NULL,
    total_amount numeric(15,2) NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT sales_history_sadiullina_quantity_check CHECK ((quantity > 0))
);


ALTER TABLE app.sales_history_sadiullina OWNER TO postgres;

--
-- TOC entry 222 (class 1259 OID 16682)
-- Name: sales_history_sadiullina_id_seq; Type: SEQUENCE; Schema: app; Owner: postgres
--

CREATE SEQUENCE app.sales_history_sadiullina_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE app.sales_history_sadiullina_id_seq OWNER TO postgres;

--
-- TOC entry 4957 (class 0 OID 0)
-- Dependencies: 222
-- Name: sales_history_sadiullina_id_seq; Type: SEQUENCE OWNED BY; Schema: app; Owner: postgres
--

ALTER SEQUENCE app.sales_history_sadiullina_id_seq OWNED BY app.sales_history_sadiullina.id;


--
-- TOC entry 225 (class 1259 OID 16702)
-- Name: sales_points_sadiullina; Type: TABLE; Schema: app; Owner: postgres
--

CREATE TABLE app.sales_points_sadiullina (
    id integer NOT NULL,
    partner_id integer NOT NULL,
    address text NOT NULL,
    point_type character varying(50)
);


ALTER TABLE app.sales_points_sadiullina OWNER TO postgres;

--
-- TOC entry 224 (class 1259 OID 16701)
-- Name: sales_points_sadiullina_id_seq; Type: SEQUENCE; Schema: app; Owner: postgres
--

CREATE SEQUENCE app.sales_points_sadiullina_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE app.sales_points_sadiullina_id_seq OWNER TO postgres;

--
-- TOC entry 4958 (class 0 OID 0)
-- Dependencies: 224
-- Name: sales_points_sadiullina_id_seq; Type: SEQUENCE OWNED BY; Schema: app; Owner: postgres
--

ALTER SEQUENCE app.sales_points_sadiullina_id_seq OWNED BY app.sales_points_sadiullina.id;


--
-- TOC entry 4757 (class 2604 OID 16642)
-- Name: partner_types_sadiullina id; Type: DEFAULT; Schema: app; Owner: postgres
--

ALTER TABLE ONLY app.partner_types_sadiullina ALTER COLUMN id SET DEFAULT nextval('app.partner_types_sadiullina_id_seq'::regclass);


--
-- TOC entry 4758 (class 2604 OID 16653)
-- Name: partners_sadiullina id; Type: DEFAULT; Schema: app; Owner: postgres
--

ALTER TABLE ONLY app.partners_sadiullina ALTER COLUMN id SET DEFAULT nextval('app.partners_sadiullina_id_seq'::regclass);


--
-- TOC entry 4762 (class 2604 OID 16673)
-- Name: products_sadiullina id; Type: DEFAULT; Schema: app; Owner: postgres
--

ALTER TABLE ONLY app.products_sadiullina ALTER COLUMN id SET DEFAULT nextval('app.products_sadiullina_id_seq'::regclass);


--
-- TOC entry 4765 (class 2604 OID 16686)
-- Name: sales_history_sadiullina id; Type: DEFAULT; Schema: app; Owner: postgres
--

ALTER TABLE ONLY app.sales_history_sadiullina ALTER COLUMN id SET DEFAULT nextval('app.sales_history_sadiullina_id_seq'::regclass);


--
-- TOC entry 4767 (class 2604 OID 16705)
-- Name: sales_points_sadiullina id; Type: DEFAULT; Schema: app; Owner: postgres
--

ALTER TABLE ONLY app.sales_points_sadiullina ALTER COLUMN id SET DEFAULT nextval('app.sales_points_sadiullina_id_seq'::regclass);


--
-- TOC entry 4939 (class 0 OID 16639)
-- Dependencies: 217
-- Data for Name: partner_types_sadiullina; Type: TABLE DATA; Schema: app; Owner: postgres
--

INSERT INTO app.partner_types_sadiullina VALUES (1, 'ООО', 'Общество с ограниченной ответственностью');
INSERT INTO app.partner_types_sadiullina VALUES (2, 'ИП', 'Индивидуальный предприниматель');
INSERT INTO app.partner_types_sadiullina VALUES (3, 'ЗАО', 'Закрытое акционерное общество');
INSERT INTO app.partner_types_sadiullina VALUES (4, 'ОАО', 'Открытое акционерное общество');
INSERT INTO app.partner_types_sadiullina VALUES (5, 'ЧУП', 'Частное унитарное предприятие');


--
-- TOC entry 4941 (class 0 OID 16650)
-- Dependencies: 219
-- Data for Name: partners_sadiullina; Type: TABLE DATA; Schema: app; Owner: postgres
--

INSERT INTO app.partners_sadiullina VALUES (2, 1, 'ООО "Пол-Мастер"', 'г. Пермь, ул. Ленина, 10', '5904000012', 'Иванов Иван Иванович', '+7(342)111-22-33', 'info@polmaster.ru', 85, NULL, '2026-03-15 00:18:44.077217', '2026-03-15 00:18:44.077217');
INSERT INTO app.partners_sadiullina VALUES (3, 3, 'ЗАО "Уралстрой"', 'г. Пермь, ул. Героев Хасана, 45', '5902000056', 'Сидоров Петр Сергеевич', '+7(342)555-66-77', 'uralstroy@bk.ru', 95, NULL, '2026-03-15 00:18:44.077217', '2026-03-15 00:18:44.077217');
INSERT INTO app.partners_sadiullina VALUES (4, 4, 'ОАО "Молот"', 'г. Пермь, ул. Целинная, 47', '5908000018', 'Ябелов Дмитрий Сергеевич', '+7(342)818-18-18', 'molotstroy@mail.ru', 0, NULL, '2026-03-15 02:13:26.666448', '2026-03-15 02:14:47.110893');
INSERT INTO app.partners_sadiullina VALUES (5, 4, 'ОАО "СтройКомплекс"', 'г. Пермь, ул. Строителе, 15', '5914000052', 'Заитова Роза Рустамовна', '+7(343)525-52-52', 'stroykoplekt@mail.ru', 67, NULL, '2026-03-15 02:42:34.129575', '2026-03-15 02:42:34.129636');
INSERT INTO app.partners_sadiullina VALUES (1, 2, 'ИП Петров А.В.', 'г. Пермь, ул. Сибирская, 16', '5903000034', 'Петров Александр Владимирович', '+7(902)333-44-55', 'petrov@mail.ru', 70, NULL, '2026-03-15 05:18:44.077217', '2026-03-15 16:05:27.040867');


--
-- TOC entry 4943 (class 0 OID 16670)
-- Dependencies: 221
-- Data for Name: products_sadiullina; Type: TABLE DATA; Schema: app; Owner: postgres
--

INSERT INTO app.products_sadiullina VALUES (1, 'MP-001', 'Ламинат Дуб благородный', 'Ламинат 32 класс, толщина 8 мм', 850.00, 'м²', '2026-03-15 00:18:34.51675');
INSERT INTO app.products_sadiullina VALUES (2, 'MP-002', 'Паркетная доска Ясень', 'Паркетная доска трехслойная, 14 мм', 2100.00, 'м²', '2026-03-15 00:18:34.51675');
INSERT INTO app.products_sadiullina VALUES (3, 'MP-003', 'Виниловая плитка', 'Кварц-винил, замковое соединение', 1200.00, 'м²', '2026-03-15 00:18:34.51675');
INSERT INTO app.products_sadiullina VALUES (4, 'MP-004', 'Плинтус напольный', 'Пластиковый, цвет белый', 150.00, 'шт', '2026-03-15 00:18:34.51675');
INSERT INTO app.products_sadiullina VALUES (5, 'MP-005', 'Подложка пробковая', 'Подложка 2 мм, рулон 10 м²', 300.00, 'рулон', '2026-03-15 00:18:34.51675');


--
-- TOC entry 4945 (class 0 OID 16683)
-- Dependencies: 223
-- Data for Name: sales_history_sadiullina; Type: TABLE DATA; Schema: app; Owner: postgres
--

INSERT INTO app.sales_history_sadiullina VALUES (1, 1, 1, 150, '2025-02-10', 127500.00, '2026-03-15 00:19:33.443035');
INSERT INTO app.sales_history_sadiullina VALUES (2, 1, 3, 80, '2025-02-15', 96000.00, '2026-03-15 00:19:33.443035');
INSERT INTO app.sales_history_sadiullina VALUES (3, 2, 2, 45, '2025-02-20', 94500.00, '2026-03-15 00:19:33.443035');
INSERT INTO app.sales_history_sadiullina VALUES (4, 1, 1, 200, '2025-03-01', 170000.00, '2026-03-15 00:19:33.443035');
INSERT INTO app.sales_history_sadiullina VALUES (5, 3, 4, 300, '2025-03-05', 45000.00, '2026-03-15 00:19:33.443035');
INSERT INTO app.sales_history_sadiullina VALUES (6, 2, 5, 50, '2025-03-08', 15000.00, '2026-03-15 00:19:33.443035');
INSERT INTO app.sales_history_sadiullina VALUES (7, 3, 2, 120, '2025-03-12', 252000.00, '2026-03-15 00:19:33.443035');


--
-- TOC entry 4947 (class 0 OID 16702)
-- Dependencies: 225
-- Data for Name: sales_points_sadiullina; Type: TABLE DATA; Schema: app; Owner: postgres
--

INSERT INTO app.sales_points_sadiullina VALUES (1, 1, 'г. Пермь, ул. Ленина, 10', 'розничный');
INSERT INTO app.sales_points_sadiullina VALUES (2, 1, 'г. Пермь, ТЦ "Семья", 2 этаж', 'розничный');
INSERT INTO app.sales_points_sadiullina VALUES (3, 2, 'г. Пермь, ул. Сибирская, 15', 'розничный');
INSERT INTO app.sales_points_sadiullina VALUES (4, 2, 'г. Пермь, ул. Революции, 20', 'оптовый');
INSERT INTO app.sales_points_sadiullina VALUES (5, 3, 'г. Пермь, ш. Космонавтов, 100', 'оптовый');


--
-- TOC entry 4959 (class 0 OID 0)
-- Dependencies: 216
-- Name: partner_types_sadiullina_id_seq; Type: SEQUENCE SET; Schema: app; Owner: postgres
--

SELECT pg_catalog.setval('app.partner_types_sadiullina_id_seq', 5, true);


--
-- TOC entry 4960 (class 0 OID 0)
-- Dependencies: 218
-- Name: partners_sadiullina_id_seq; Type: SEQUENCE SET; Schema: app; Owner: postgres
--

SELECT pg_catalog.setval('app.partners_sadiullina_id_seq', 6, true);


--
-- TOC entry 4961 (class 0 OID 0)
-- Dependencies: 220
-- Name: products_sadiullina_id_seq; Type: SEQUENCE SET; Schema: app; Owner: postgres
--

SELECT pg_catalog.setval('app.products_sadiullina_id_seq', 5, true);


--
-- TOC entry 4962 (class 0 OID 0)
-- Dependencies: 222
-- Name: sales_history_sadiullina_id_seq; Type: SEQUENCE SET; Schema: app; Owner: postgres
--

SELECT pg_catalog.setval('app.sales_history_sadiullina_id_seq', 7, true);


--
-- TOC entry 4963 (class 0 OID 0)
-- Dependencies: 224
-- Name: sales_points_sadiullina_id_seq; Type: SEQUENCE SET; Schema: app; Owner: postgres
--

SELECT pg_catalog.setval('app.sales_points_sadiullina_id_seq', 5, true);


--
-- TOC entry 4771 (class 2606 OID 16648)
-- Name: partner_types_sadiullina partner_types_sadiullina_name_key; Type: CONSTRAINT; Schema: app; Owner: postgres
--

ALTER TABLE ONLY app.partner_types_sadiullina
    ADD CONSTRAINT partner_types_sadiullina_name_key UNIQUE (name);


--
-- TOC entry 4773 (class 2606 OID 16646)
-- Name: partner_types_sadiullina partner_types_sadiullina_pkey; Type: CONSTRAINT; Schema: app; Owner: postgres
--

ALTER TABLE ONLY app.partner_types_sadiullina
    ADD CONSTRAINT partner_types_sadiullina_pkey PRIMARY KEY (id);


--
-- TOC entry 4776 (class 2606 OID 16663)
-- Name: partners_sadiullina partners_sadiullina_inn_key; Type: CONSTRAINT; Schema: app; Owner: postgres
--

ALTER TABLE ONLY app.partners_sadiullina
    ADD CONSTRAINT partners_sadiullina_inn_key UNIQUE (inn);


--
-- TOC entry 4778 (class 2606 OID 16661)
-- Name: partners_sadiullina partners_sadiullina_pkey; Type: CONSTRAINT; Schema: app; Owner: postgres
--

ALTER TABLE ONLY app.partners_sadiullina
    ADD CONSTRAINT partners_sadiullina_pkey PRIMARY KEY (id);


--
-- TOC entry 4780 (class 2606 OID 16681)
-- Name: products_sadiullina products_sadiullina_article_key; Type: CONSTRAINT; Schema: app; Owner: postgres
--

ALTER TABLE ONLY app.products_sadiullina
    ADD CONSTRAINT products_sadiullina_article_key UNIQUE (article);


--
-- TOC entry 4782 (class 2606 OID 16679)
-- Name: products_sadiullina products_sadiullina_pkey; Type: CONSTRAINT; Schema: app; Owner: postgres
--

ALTER TABLE ONLY app.products_sadiullina
    ADD CONSTRAINT products_sadiullina_pkey PRIMARY KEY (id);


--
-- TOC entry 4787 (class 2606 OID 16690)
-- Name: sales_history_sadiullina sales_history_sadiullina_pkey; Type: CONSTRAINT; Schema: app; Owner: postgres
--

ALTER TABLE ONLY app.sales_history_sadiullina
    ADD CONSTRAINT sales_history_sadiullina_pkey PRIMARY KEY (id);


--
-- TOC entry 4789 (class 2606 OID 16709)
-- Name: sales_points_sadiullina sales_points_sadiullina_pkey; Type: CONSTRAINT; Schema: app; Owner: postgres
--

ALTER TABLE ONLY app.sales_points_sadiullina
    ADD CONSTRAINT sales_points_sadiullina_pkey PRIMARY KEY (id);


--
-- TOC entry 4774 (class 1259 OID 16715)
-- Name: idx_partners_type; Type: INDEX; Schema: app; Owner: postgres
--

CREATE INDEX idx_partners_type ON app.partners_sadiullina USING btree (type_id);


--
-- TOC entry 4783 (class 1259 OID 16718)
-- Name: idx_sales_date; Type: INDEX; Schema: app; Owner: postgres
--

CREATE INDEX idx_sales_date ON app.sales_history_sadiullina USING btree (sale_date);


--
-- TOC entry 4784 (class 1259 OID 16716)
-- Name: idx_sales_partner; Type: INDEX; Schema: app; Owner: postgres
--

CREATE INDEX idx_sales_partner ON app.sales_history_sadiullina USING btree (partner_id);


--
-- TOC entry 4785 (class 1259 OID 16717)
-- Name: idx_sales_product; Type: INDEX; Schema: app; Owner: postgres
--

CREATE INDEX idx_sales_product ON app.sales_history_sadiullina USING btree (product_id);


--
-- TOC entry 4794 (class 2620 OID 16720)
-- Name: partners_sadiullina update_partners_updated_at; Type: TRIGGER; Schema: app; Owner: postgres
--

CREATE TRIGGER update_partners_updated_at BEFORE UPDATE ON app.partners_sadiullina FOR EACH ROW EXECUTE FUNCTION app.update_updated_at_column();


--
-- TOC entry 4790 (class 2606 OID 16664)
-- Name: partners_sadiullina partners_sadiullina_type_id_fkey; Type: FK CONSTRAINT; Schema: app; Owner: postgres
--

ALTER TABLE ONLY app.partners_sadiullina
    ADD CONSTRAINT partners_sadiullina_type_id_fkey FOREIGN KEY (type_id) REFERENCES app.partner_types_sadiullina(id) ON DELETE RESTRICT;


--
-- TOC entry 4791 (class 2606 OID 16691)
-- Name: sales_history_sadiullina sales_history_sadiullina_partner_id_fkey; Type: FK CONSTRAINT; Schema: app; Owner: postgres
--

ALTER TABLE ONLY app.sales_history_sadiullina
    ADD CONSTRAINT sales_history_sadiullina_partner_id_fkey FOREIGN KEY (partner_id) REFERENCES app.partners_sadiullina(id) ON DELETE CASCADE;


--
-- TOC entry 4792 (class 2606 OID 16696)
-- Name: sales_history_sadiullina sales_history_sadiullina_product_id_fkey; Type: FK CONSTRAINT; Schema: app; Owner: postgres
--

ALTER TABLE ONLY app.sales_history_sadiullina
    ADD CONSTRAINT sales_history_sadiullina_product_id_fkey FOREIGN KEY (product_id) REFERENCES app.products_sadiullina(id) ON DELETE RESTRICT;


--
-- TOC entry 4793 (class 2606 OID 16710)
-- Name: sales_points_sadiullina sales_points_sadiullina_partner_id_fkey; Type: FK CONSTRAINT; Schema: app; Owner: postgres
--

ALTER TABLE ONLY app.sales_points_sadiullina
    ADD CONSTRAINT sales_points_sadiullina_partner_id_fkey FOREIGN KEY (partner_id) REFERENCES app.partners_sadiullina(id) ON DELETE CASCADE;


-- Completed on 2026-03-15 19:50:19

--
-- PostgreSQL database dump complete
--

