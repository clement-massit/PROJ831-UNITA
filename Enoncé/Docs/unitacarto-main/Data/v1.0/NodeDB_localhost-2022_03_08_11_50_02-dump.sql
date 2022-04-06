--
-- PostgreSQL database dump
--

-- Dumped from database version 12.10 (Debian 12.10-1.pgdg110+1)
-- Dumped by pg_dump version 12.9 (Ubuntu 12.9-0ubuntu0.20.04.1)

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

DROP DATABASE IF EXISTS unitacarto;
--
-- Name: unitacarto; Type: DATABASE; Schema: -; Owner: application
--

CREATE DATABASE unitacarto WITH TEMPLATE = template0 ENCODING = 'UTF8' LC_COLLATE = 'en_US.utf8' LC_CTYPE = 'en_US.utf8';


ALTER DATABASE unitacarto OWNER TO application;

\connect unitacarto

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
-- Name: import; Type: SCHEMA; Schema: -; Owner: application
--

CREATE SCHEMA import;


ALTER SCHEMA import OWNER TO application;

--
-- Name: get_university(json); Type: FUNCTION; Schema: public; Owner: application
--

CREATE FUNCTION public.get_university(params json) RETURNS json
    LANGUAGE plpgsql
    AS $$
    DECLARE
        json_result                     JSON           =   NULL;
        param_university_id             INT            =   0;
        param_university_short_name     VARCHAR(10)    =   NULL;
BEGIN
    IF (SELECT params->>'university_id' IS NOT NULL) THEN
        SELECT params->>'university_id' INTO param_university_id;
    END IF;

    IF (SELECT  NULLIF(params->>'university_short_name', '') IS NOT NULL) THEN
        SELECT params->>'university_short_name' INTO param_university_short_name;
    END IF;

    SELECT INTO json_result
            json_agg(
                json_build_object(
                        'university_id', university_id
                      , 'university_number', university_number
                      , 'university_role', university_role
                      , 'university_short_name', university_short_name
                      , 'university_original_name', university_original_name
                      , 'university_english_name', university_english_name
                      , 'university_country', university_country
                      , 'university_website', university_website
                      , 'university_description', university_description
                      , 'university_latitude', university_latitude
                      , 'university_longitude', university_longitude
                      , 'university_students', university_students
                )
            )
    FROM public.university
    WHERE university.university_id = COALESCE(NULLIF(param_university_id, 0) , university.university_id )
    AND university.university_short_name = COALESCE(NULLIF(param_university_short_name, '') , university.university_short_name);
    RETURN json_result;

END;
$$;


ALTER FUNCTION public.get_university(params json) OWNER TO application;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: degrees; Type: TABLE; Schema: import; Owner: application
--

CREATE TABLE import.degrees (
    degree_faculty text,
    degree_department text,
    degree_type text,
    degree_program_name text,
    degree_program_code text,
    degree_diploma_field text,
    degree_ects text,
    degree_teaching_language text,
    degree_admission text,
    degree_contact_coordinator text,
    degree_contact_support text,
    degree_link text,
    degree_cultural_heritage text,
    degree_renewable_energy text,
    degree_circular_economy text,
    degree_university_short_name text DEFAULT 'UNITA'::text,
    degree_id integer NOT NULL
);


ALTER TABLE import.degrees OWNER TO application;

--
-- Name: degrees_degree_id_seq; Type: SEQUENCE; Schema: import; Owner: application
--

ALTER TABLE import.degrees ALTER COLUMN degree_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME import.degrees_degree_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: file_type; Type: TABLE; Schema: import; Owner: application
--

CREATE TABLE import.file_type (
    filetype_id integer NOT NULL,
    filetype_type character varying(5) NOT NULL,
    filetype_name character varying(50) NOT NULL,
    begin_date date DEFAULT CURRENT_DATE NOT NULL,
    end_date date,
    creation_date timestamp without time zone DEFAULT now() NOT NULL,
    last_modified_date timestamp without time zone DEFAULT now() NOT NULL,
    creation_user character varying(50) DEFAULT 'admin'::character varying,
    last_modified_user character varying(50) DEFAULT 'admin'::character varying
);


ALTER TABLE import.file_type OWNER TO application;

--
-- Name: subjects; Type: TABLE; Schema: import; Owner: application
--

CREATE TABLE import.subjects (
    subject_code text,
    subject_title text,
    subject_program_code text,
    subject_field text,
    subject_ects text,
    subject_semester text,
    subject_year text,
    subject_teaching_language text,
    subject_english_friendly text,
    subject_virtual_mobility text,
    subject_requisites_mandatory text,
    subject_requisites_recommended text,
    subject_requisites_identified text,
    subject_description text,
    subject_contact_teacher text,
    subject_contact_support text,
    subject_link text,
    subject_circular_economy text,
    subject_cultural_heritage text,
    subject_renewable_energies text,
    subject_university_short_name text DEFAULT 'UBI'::text,
    subject_id integer NOT NULL
);


ALTER TABLE import.subjects OWNER TO application;

--
-- Name: subjects_subject_id_seq; Type: SEQUENCE; Schema: import; Owner: application
--

ALTER TABLE import.subjects ALTER COLUMN subject_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME import.subjects_subject_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: xls_sheet; Type: TABLE; Schema: import; Owner: application
--

CREATE TABLE import.xls_sheet (
    sheet_id integer NOT NULL,
    sheet_name character varying(50) NOT NULL,
    sheet_column_validator text,
    filetype_id integer NOT NULL,
    area_id integer NOT NULL,
    begin_date date DEFAULT CURRENT_DATE NOT NULL,
    end_date date,
    creation_date timestamp without time zone DEFAULT now() NOT NULL,
    last_modified_date timestamp without time zone DEFAULT now() NOT NULL,
    creation_user character varying(50) DEFAULT 'admin'::character varying,
    last_modified_user character varying(50) DEFAULT 'admin'::character varying
);


ALTER TABLE import.xls_sheet OWNER TO application;

--
-- Name: area; Type: TABLE; Schema: public; Owner: application
--

CREATE TABLE public.area (
    area_id integer NOT NULL,
    area_name character varying(50) NOT NULL,
    area_display_name character varying(50) NOT NULL,
    begin_date date DEFAULT CURRENT_DATE NOT NULL,
    end_date date,
    creation_date timestamp without time zone DEFAULT now() NOT NULL,
    last_modified_date timestamp without time zone DEFAULT now() NOT NULL,
    creation_user character varying(50) DEFAULT 'admin'::character varying,
    last_modified_user character varying(50) DEFAULT 'admin'::character varying
);


ALTER TABLE public.area OWNER TO application;

--
-- Name: university; Type: TABLE; Schema: public; Owner: application
--

CREATE TABLE public.university (
    university_id integer NOT NULL,
    university_number integer,
    university_role character varying(3) NOT NULL,
    university_short_name character varying(10) NOT NULL,
    university_original_name character varying(50) NOT NULL,
    university_english_name character varying(50) NOT NULL,
    university_country character varying(50) NOT NULL,
    university_website character varying(100),
    university_description text,
    university_latitude numeric(9,6) NOT NULL,
    university_longitude numeric(9,6) NOT NULL,
    university_students integer NOT NULL,
    begin_date date DEFAULT CURRENT_DATE NOT NULL,
    end_date date,
    creation_date timestamp without time zone DEFAULT now() NOT NULL,
    last_modified_date timestamp without time zone DEFAULT now() NOT NULL,
    creation_user character varying(50) DEFAULT 'admin'::character varying,
    last_modified_user character varying(50) DEFAULT 'admin'::character varying
);


ALTER TABLE public.university OWNER TO application;

--
-- Data for Name: degrees; Type: TABLE DATA; Schema: import; Owner: application
--

INSERT INTO import.degrees OVERRIDING SYSTEM VALUE VALUES (NULL, 'LINGUE E LETTERATURE STRANIERE E CULTURE MODERNE', 'Bachelor', 'LINGUE E CULTURE PER IL TURISMO', '012705', '0231', '180', 'IT', NULL, 'enrico.lusso@unito.it', 'wilson.fiore@unito.it', 'https://www.lingue.unito.it/do/home.pl/View?doc=Lauree_Triennali/Lingue_e_Culture_per_il_Turismo_1.html', '3', '0', '1', 'UNITO', 1);
INSERT INTO import.degrees OVERRIDING SYSTEM VALUE VALUES (NULL, 'LINGUE E LETTERATURE STRANIERE E CULTURE MODERNE', 'Master', 'LINGUE STRANIERE PER LA COMUNICAZIONE INTERNAZIONALE ', '012503', '0231', '120', 'IT', NULL, 'ruggero.druetta@unito.it', 'wilson.fiore@unito.it', 'https://www.lingue.unito.it/do/home.pl/View?doc=Lauree_Magistrali/Lingue_straniere_comunicazione_internazionale.html', '3', '0', '1', 'UNITO', 2);
INSERT INTO import.degrees OVERRIDING SYSTEM VALUE VALUES (NULL, 'SCIENZE ECONOMICO-SOCIALI E MATEMATICO-STATISTICHE', 'Bachelor', 'ECONOMIA', '2301L31', '0311', '180', 'IT', NULL, 'enrico.colombatto@unito.it', 'didattica.economiamanagement@unito.it', 'https://www.ecocomm.unito.it/do/home.pl', '0', '0', '3', 'UNITO', 3);
INSERT INTO import.degrees OVERRIDING SYSTEM VALUE VALUES (NULL, 'MANAGEMENT', 'Master', 'AMMINISTRAZIONE E CONTROLLO AZIENDALE', '102513', '0488', '120', 'IT', NULL, 'fabrizio.bava@unito.it', 'didattica.economiamanagement@unito.it', 'https://www.aca.unito.it/do/home.pl', '0', '0', '2', 'UNITO', 4);
INSERT INTO import.degrees OVERRIDING SYSTEM VALUE VALUES (NULL, 'CULTURE, POLITICA E SOCIETA', 'Master', 'COMUNICAZIONE, ICT E MEDIA', '0304M21', '0321', '120', 'IT', NULL, 'milena.viassone@unito.it', 'dipartimento.cps@unito.it', 'https://www.didattica-cps.unito.it/do/home.pl/View?doc=/corsi_di_studio/cime/presentazione.html', '0', '2', '0', 'UNITO', 5);
INSERT INTO import.degrees OVERRIDING SYSTEM VALUE VALUES (NULL, 'SCIENZE AGRARIE, FORESTALI E ALIMENTARI', 'Bachelor', 'SCIENZE FORESTALI E AMBIENTALI', '001711', '0522', '180', 'IT', NULL, 'bruno.barberis@unito.it', 'direzione.disafa@unito.it', 'https://www.sfa.unito.it/do/home.pl', '0', '2', '0', 'UNITO', 6);
INSERT INTO import.degrees OVERRIDING SYSTEM VALUE VALUES ('Arts and Letters', 'Letters', 'Bachelor', 'Portuguese and Spanish Studies', '36', '232', '180', 'PT', 'One of the following Exams: Spanish, Portuguese Literature or Portuguese (exams similar to these, for international students) 
Entrance exams grade: 95
Candidate grade: 100 ', 'jivd@ubi.pt', 'letras@ubi.pt', 'https://www.ubi.pt/en/course/36', '3', '0', '0', 'UBI', 8);
INSERT INTO import.degrees OVERRIDING SYSTEM VALUE VALUES ('Arts and Letters', 'Arts', 'Bachelor', 'Industrial Design', '75', '212', '180', 'PT', 'One of the following Exams: Drawing, Descriptive Geometry, Mathematics  (exams similar to these, for international students) 
Entrance exams grade: 95
Candidate grade: 100 ', 'correia@ubi.pt', 'sve@ubi.pt', 'https://www.ubi.pt/en/course/75 ', '0', '0', '2', 'UBI', 9);
INSERT INTO import.degrees OVERRIDING SYSTEM VALUE VALUES ('Arts and Letters', 'Letters', 'Master', 'Lusophone Studies', '1020', '232', '120', 'PT', 'Bachelor degree in the area or related areas. Other graduates, provided that the respective curriculum demonstrates adequate basic preparation in this area.', 'jivd@ubi.pt', 'letras@ubi.pt', 'https://www.ubi.pt/en/course/1020', '3', '0', '0', 'UBI', 10);
INSERT INTO import.degrees OVERRIDING SYSTEM VALUE VALUES ('Engineering ', 'Electromechanical Engineering', 'Master', 'Electromechanical Engineering ', '889', '714', '120', 'PT', 'Bachelor degree in the area or related areas. Other graduates, provided that the respective curriculum demonstrates adequate basic preparation in this area.', 'pires@ubi.pt', 'pires@ubi.pt', 'https://www.ubi.pt/en/course/889', '0', '3', '1', 'UBI', 11);
INSERT INTO import.degrees OVERRIDING SYSTEM VALUE VALUES ('Social Sciences and Humanities', 'Management and Economics', 'Master', 'Entrepreneurship and Firm Creation', '823', '413', '120', 'PT', 'Bachelor degree in the area or related areas. Other graduates, provided that the respective curriculum demonstrates adequate basic preparation in this area.', 'lmendes@ubi.pt', 'cmag@ubi.pt', 'https://www.ubi.pt/en/course/823', '0', '0', '3', 'UBI', 12);
INSERT INTO import.degrees OVERRIDING SYSTEM VALUE VALUES ('Engineering ', 'Civil Engineering and Architecture', 'Master', 'Architecture', '72', '731', '300', 'PT', 'One of the following Exams: Drawing, Descriptive Geometry, Mathematics (exams similar to these, for international students) 
Entrance exams grade: 95
Candidate grade: 100 ', 'lpinto@ubi.pt', 'deca@ubi.pt', 'https://www.ubi.pt/en/course/72', '3', '1', '2', 'UBI', 13);
INSERT INTO import.degrees OVERRIDING SYSTEM VALUE VALUES ('Engineering', 'Electromechanical Engineering', 'Bachelor', 'Electromechanical Engineering', '8', '714', '180', 'PT', 'Exams: Physics and Chemistry and Mathematics A (exams similar to these, for international students) 
Entrance exams grade: 95
Candidate grade: 100 ', 'davide@ubi.pt', 'dem@ubi.pt', 'https://www.ubi.pt/en/course/8', '0', '3', '1', 'UBI', 7);


--
-- Data for Name: file_type; Type: TABLE DATA; Schema: import; Owner: application
--

INSERT INTO import.file_type VALUES (1, 'XLS', 'SUBJECT', '2022-03-08', NULL, '2022-03-08 10:24:24.850285', '2022-03-08 10:24:24.850285', 'admin', 'admin');
INSERT INTO import.file_type VALUES (2, 'XLS', 'DEGREE', '2022-03-08', NULL, '2022-03-08 10:24:24.850285', '2022-03-08 10:24:24.850285', 'admin', 'admin');
INSERT INTO import.file_type VALUES (3, 'CSV', 'exemple for the future', '2022-03-08', NULL, '2022-03-08 10:24:24.850285', '2022-03-08 10:24:24.850285', 'admin', 'admin');
INSERT INTO import.file_type VALUES (4, 'JSON', 'exemple for the future', '2022-03-08', NULL, '2022-03-08 10:24:24.850285', '2022-03-08 10:24:24.850285', 'admin', 'admin');


--
-- Data for Name: subjects; Type: TABLE DATA; Schema: import; Owner: application
--

INSERT INTO import.subjects OVERRIDING SYSTEM VALUE VALUES ('LIN0053', 'STORIA DELL''ARCHITETTURA E ITINERARI TURISTICI', '012705', '0222', '9', 'first', '1', 'IT', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'didattica.scienzeumanistiche@unito.it', 'https://www.lingue.unito.it/do/corsi.pl/Show?_id=0808', '0', '1', '0', 'UNITO', 1);
INSERT INTO import.subjects OVERRIDING SYSTEM VALUE VALUES ('LIN0225', 'TEORIA E PRATICA DELLA TRADUZIONE MAGISTRALE', '012503', '0231', '5', 'second', '2', 'IT', NULL, NULL, NULL, NULL, NULL, NULL, 'elisa.corino@unito.it', 'didattica.scienzeumanistiche@unito.it', 'https://www.lingue.unito.it/do/corsi.pl/Show?_id=1883', '0', '1', '0', 'UNITO', 2);
INSERT INTO import.subjects OVERRIDING SYSTEM VALUE VALUES ('SEM0124', 'ENTREPRENEURSHIP: THEORY AND HISTORY', '2301L31', '0413', '4', 'first', '3', 'EN', NULL, NULL, NULL, NULL, NULL, NULL, 'giandomenica.becchio@unito.it', NULL, 'https://www.ecocomm.unito.it/do/corsi.pl/Show?_id=ecocomm1516_43', '1', '0', '0', 'UNITO', 3);
INSERT INTO import.subjects OVERRIDING SYSTEM VALUE VALUES ('MAN0599', 'CIRCULAR ECONOMY MANAGEMENT', '102513', '0311', '3', 'first', '1', 'EN', NULL, NULL, NULL, NULL, NULL, NULL, 'paola.debernardi@unito.it', NULL, 'https://www.aca.unito.it/do/corsi.pl/Show?_id=6nqx', '1', '0', '0', 'UNITO', 4);
INSERT INTO import.subjects OVERRIDING SYSTEM VALUE VALUES ('CPS0550', 'SISTEMI SOCIOTECNICI E AMBIENTE', '0304M21', '0310', '6', 'second', '1', 'IT', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'didattica.disafa@unito.it ', 'https://www.didattica-cps.unito.it/do/corsi.pl/Show?_id=a6z2', '0', '0', '1', 'UNITO', 5);
INSERT INTO import.subjects OVERRIDING SYSTEM VALUE VALUES ('MFN1261', 'SOSTENIBILITÀ AMBIENTALE DELLA SOCIETÀ DIGITALE ', '001711', '0310', '2', 'first', '3', 'IT', NULL, NULL, NULL, NULL, NULL, NULL, 'dario.padovan@unito.it', NULL, 'https://www.didattica-cps.unito.it/do/corsi.pl/Show?_id=p96v', '0', '0', '1', 'UNITO', 6);
INSERT INTO import.subjects OVERRIDING SYSTEM VALUE VALUES ('12325', 'Contemporary Portuguese Culture', '1020', '222', '6', 'first', '1', 'PT', 'Yes', 'Yes', NULL, NULL, NULL, '1. Developing the ability of analysis of the greater collective moments, and of the most important cultural achievements of the Portuguese society in the nineteenth, twentieth and twenty-first centuries, in the most different areas, although privileging the Humanities one;
2. Preparation of a short essay showing the student’s ability of conceptualization in what concerns the development of a subject on the Portuguese Contemporary Culture, in particular about the Identity;
3. Adequacy of the previous paper work to the international conference communication format in the Portuguese culture field, providing that the core question, the conceptual support and the innovation or innovations introduced are accurately focused.', 'cxavier@ubi.pt', 'letras@ubi.pt', 'http://www.ubi.pt/en/discipline/12325', '0', '1', '0', 'UBI', 10);
INSERT INTO import.subjects OVERRIDING SYSTEM VALUE VALUES ('12341', 'Classic Portuguese Literature', '36', '232', '6', 'second', '1', 'PT', 'Yes', 'No', NULL, NULL, 'None, but Literature knowledge is an asset', 'Analyze Portuguese literature from classical period.
By the end of the Semester, the student must be able to:
- recognize the literary trends of the XVI century;
- identify the major works and authors of the Portuguese Renaissance literature;
- read, analyze and comment on different literary Renaissance texts.', 'hrmanso@ubi.pt', 'letras@ubi.pt', 'https://www.ubi.pt/en/discipline/12341', '0', '1', '0', 'UBI', 9);
INSERT INTO import.subjects OVERRIDING SYSTEM VALUE VALUES ('12284', 'National and European Public Policies', '920', '312', '7.5', 'first', '1', 'PT', 'Yes', 'Yes', NULL, NULL, 'French or English B1 level, at least', '1) Get acquainted with actors, institutions and policy instruments;
2) Comprehend the decision making process, the objective setting mechanisms and the nature of the actors relationships;
3) Recognize the cooperative or competitive nature of different public policies;
4) Distinguish the problems arising from the implementation of the public policies;
5) Understanding the issues related to the evaluation of policies;
6) Decode budgetary implications of government action.', 'lfsm@ubi.pt', 'dca@ubi.pt', 'https://www.ubi.pt/en/discipline/12284', '1', '0', '0', 'UBI', 12);
INSERT INTO import.subjects OVERRIDING SYSTEM VALUE VALUES ('15215', 'Sustainable Construction', '72', '732', '5', 'first', '5', 'PT', 'Yes', 'No', NULL, NULL, 'Knowledge of building physics.', 'In terms of curricular objectives, the syllabus intends to enable students to design building construction projects taking into account all actions and design decisions that privilege sustainability criteria and develop the following competencies:
a) Understand the impact of the construction sector and buildings on the sustained environment.
b) Understand the methodologies of evaluation of the sustainability of buildings;
c) Understand bio climatic concepts for the project and energy saving strategies, reduction of consumption and minimization of waste (through rationalization, reuse or recycling)
d) Being able to intervene in the design and choice of sustainable building systems.
e) Being able to intervene in the evaluation and change proposals of building project with application of sustainability guidelines', 'jcgl@ubi.pt', 'deca@ubi.pt', 'https://www.ubi.pt/en/discipline/15215', '1', '1', '1', 'UBI', 13);
INSERT INTO import.subjects OVERRIDING SYSTEM VALUE VALUES ('7154', 'Renewable Energies', '889', '713', '6', 'first', '2', 'PT', 'Yes', 'No', NULL, NULL, 'General knowledge of the base sciences of engineering.', 'The aim of this curricular unit is to make a general overview of the possible uses of renewable energy resources. The main technologies for the use of renewable energy sources are studied and, in each case, the corresponding primary energy resource. There is also a general analysis of the economic and environmental gains from the use of different renewable energy sources.', 'pires@ubi.pt', 'dem@ubi.pt', 'https://www.ubi.pt/en/discipline/7154', '0', '0', '1', 'UBI', 8);
INSERT INTO import.subjects OVERRIDING SYSTEM VALUE VALUES ('12737', 'Sustainable Design', '75', '212', '5', 'second', '3', 'PT', 'Yes', 'No', NULL, NULL, NULL, 'Develop awareness to environmental and social issues. Understand the present development paradigm.
Know the types of environmental and social impacts and relate these impacts to the design decisions.
Know the role of design in sustainable development and in the production and consumption system.
To be able to develop design projects that integrate environmental and social criteria, from a perspective of life cycle and circularity, through the use of a life cycle approach and sustainable design strategies and tools for the circular economy.
To know alternative design approaches that redirect the focus towards a positive change in the behavior of consumers / users.', 'julio.londrim.baptista@ubi.pt', 'sve@ubi.pt', 'https://www.ubi.pt/en/discipline/12737', '1', '0', '0', 'UBI', 11);
INSERT INTO import.subjects OVERRIDING SYSTEM VALUE VALUES ('8502', 'Electrical Energy Systems', '8', '713', '6', 'second', '3', 'PT', 'Yes', 'Yes', NULL, NULL, NULL, 'To acquire knowledge regarding the organization and operation of electric power systems - electricity production, transport and distribution in a current perspective of sustainable development.', 'jose.pombo@ubi.pt', 'dem@ubi.pt', 'http://www.ubi.pt/en/discipline/8502', '0', '0', '1', 'UBI', 7);


--
-- Data for Name: xls_sheet; Type: TABLE DATA; Schema: import; Owner: application
--

INSERT INTO import.xls_sheet VALUES (1, 'Renewable Energy - Bachelor', NULL, 1, 2, '2022-03-08', NULL, '2022-03-08 10:24:58.964495', '2022-03-08 10:24:58.964495', 'admin', 'admin');
INSERT INTO import.xls_sheet VALUES (2, 'Renewable Energy - Master', NULL, 1, 2, '2022-03-08', NULL, '2022-03-08 10:24:58.964495', '2022-03-08 10:24:58.964495', 'admin', 'admin');
INSERT INTO import.xls_sheet VALUES (3, 'Cultural Heritage - Bachelor', NULL, 1, 1, '2022-03-08', NULL, '2022-03-08 10:24:58.964495', '2022-03-08 10:24:58.964495', 'admin', 'admin');
INSERT INTO import.xls_sheet VALUES (4, 'Cultural Heritage - Master', NULL, 1, 1, '2022-03-08', NULL, '2022-03-08 10:24:58.964495', '2022-03-08 10:24:58.964495', 'admin', 'admin');
INSERT INTO import.xls_sheet VALUES (5, 'Circular Economy - Bachelor', NULL, 1, 3, '2022-03-08', NULL, '2022-03-08 10:24:58.964495', '2022-03-08 10:24:58.964495', 'admin', 'admin');
INSERT INTO import.xls_sheet VALUES (6, 'Circular Economy - Master', NULL, 1, 3, '2022-03-08', NULL, '2022-03-08 10:24:58.964495', '2022-03-08 10:24:58.964495', 'admin', 'admin');
INSERT INTO import.xls_sheet VALUES (7, 'a', NULL, 2, 1, '2022-03-08', NULL, '2022-03-08 10:27:05.826432', '2022-03-08 10:27:05.826432', 'admin', 'admin');


--
-- Data for Name: area; Type: TABLE DATA; Schema: public; Owner: application
--

INSERT INTO public.area VALUES (1, 'Cultural Heritage', 'Cultural Heritage', '2022-03-08', NULL, '2022-03-08 10:21:10.238128', '2022-03-08 10:21:10.238128', 'admin', 'admin');
INSERT INTO public.area VALUES (2, 'Renewable Energies', 'Renewable Energies', '2022-03-08', NULL, '2022-03-08 10:21:10.238128', '2022-03-08 10:21:10.238128', 'admin', 'admin');
INSERT INTO public.area VALUES (3, 'Circular Economy', 'Circular Economy', '2022-03-08', NULL, '2022-03-08 10:21:10.238128', '2022-03-08 10:21:10.238128', 'admin', 'admin');


--
-- Data for Name: university; Type: TABLE DATA; Schema: public; Owner: application
--

INSERT INTO public.university VALUES (1, 1, 'COO', 'UNITO', 'Università degli studi di Torino', 'Univerity of Turin', 'Italy', 'https://en.unito.it/', 'The University of Turin is one of the most ancient and prestigious Italian Universities. Hosting over 79.000 students and with 120 buildings in different areas in Turin and in key places in Piedmont, the University of Turin can be considered as “city-within-a-city”, promoting culture and producing research, innovation, training and employment. The University of Turin is today one of the largest Italian Universities, open to international research and training. It carries out scientific research and organizes courses in all disciplines, except for Engineering and Architecture.', 45.069458, 7.689125, 81700, '2022-02-16', NULL, '2022-02-16 11:29:48.844014', '2022-02-16 11:29:48.844014', 'admin', 'admin');
INSERT INTO public.university VALUES (2, 2, 'BEN', 'UBI', 'Universidade Beira Interior', 'University Beira Interior', 'Portugal', 'https://www.ubi.pt/', 'Nowadays, UBI is a national and international reference institution, in the spheres of education, research, innovation and entrepreneurship. More and more concerned about quality, UBI has invested in the creation of well-equipped laboratories, in the expansion of its facilities, in the involvement in research projects of national and international scope, and in a qualified teaching staff. Two of the hallmarks of this University are the provision of laboratories in all teaching areas and teacher-student proximity education.', 40.278119, -7.509017, 7000, '2022-02-16', NULL, '2022-02-16 11:29:48.844014', '2022-02-16 11:29:48.844014', 'admin', 'admin');
INSERT INTO public.university VALUES (3, 3, 'BEN', 'UNIZAR', 'Universidad de Zaragoza', 'University of Zaragoza', 'Spain', 'https://www.unizar.es/', 'UPPA offers its students initial or continuing education, work/study programmes or apprenticeships, to obtain Bachelor’s, Master’s and vocational degrees and Doctorates through its 5 UFRs (Teaching and Research units) and two Doctoral schools. The university also includes two IUTs (University Institute of Technology), one IAE (University School of Management), two engineering schools (ENSGTI, covering industrial technology engineering and ISA BTP covering construction), a continuing education department and an apprenticeship training centre.', 41.642495, -0.901448, 39664, '2022-02-16', NULL, '2022-02-16 11:29:48.844014', '2022-02-16 11:29:48.844014', 'admin', 'admin');
INSERT INTO public.university VALUES (4, 4, 'BEN', 'UPPA', 'Université de Pau et des Pays de l''Adour', 'Université of Pau and Pays de l''Adour', 'France', 'https://www.univ-pau.fr/fr/index.html', 'UPPA offers its students initial or continuing education, work/study programmes or apprenticeships, to obtain Bachelor’s, Master’s and vocational degrees and Doctorates through its 5 UFRs (Teaching and Research units) and two Doctoral schools. The university also includes two IUTs (University Institute of Technology), one IAE (University School of Management), two engineering schools (ENSGTI, covering industrial technology engineering and ISA BTP covering construction), a continuing education department and an apprenticeship training centre.', 43.314337, -0.366594, 13500, '2022-02-16', NULL, '2022-02-16 11:29:48.844014', '2022-02-16 11:29:48.844014', 'admin', 'admin');
INSERT INTO public.university VALUES (5, 5, 'BEN', 'USMB', 'Université Savoie Mont Blanc', 'Université of Savoie Mont Blanc', 'France', 'https://www.univ-smb.fr/', 'With 15,000 students, a rich offer of multidisciplinary academics and 19 internationally recognised laboratories at research , the University of Savoie Mont Blanc (Chambéry) is a human-sized establishment that combines proximity to its territories, membership of the PRES Université de Grenoble as a founding member and a wide opening onto Europe and the world. On its three campuses, Annecy, Bourget-du-Lac and Jacob-Bellecombette, the Université Savoie Mont Blanc offers particularly attractive study conditions in the heart of an exceptional environment.', 45.566874, 5.917561, 15399, '2022-02-16', NULL, '2022-02-16 11:29:48.844014', '2022-02-16 11:29:48.844014', 'admin', 'admin');
INSERT INTO public.university VALUES (6, 6, 'BEN', 'UVT', 'Universitatea de Vest din Timisoara', 'West University of Timisoara', 'Romania', 'https://www.uvt.ro/ro/', 'In recent years, the University has responded to changes in national education policy, demographic change, market economy requirements, local and regional needs and new technologies. All these changes have led to new expectations from students, academic and administrative staff. The West University of Timişoara offers students the necessary training to contribute to the development of society. This training takes place in 11 faculties, which offer a wide range of initial training programs and postgraduate courses.', 45.748093, 21.231490, 16000, '2022-02-16', NULL, '2022-02-16 11:29:48.844014', '2022-02-16 11:29:48.844014', 'admin', 'admin');


--
-- Name: degrees_degree_id_seq; Type: SEQUENCE SET; Schema: import; Owner: application
--

SELECT pg_catalog.setval('import.degrees_degree_id_seq', 13, true);


--
-- Name: subjects_subject_id_seq; Type: SEQUENCE SET; Schema: import; Owner: application
--

SELECT pg_catalog.setval('import.subjects_subject_id_seq', 13, true);


--
-- Name: degrees degrees_degree_university_short_name_degree_program_code_key; Type: CONSTRAINT; Schema: import; Owner: application
--

ALTER TABLE ONLY import.degrees
    ADD CONSTRAINT degrees_degree_university_short_name_degree_program_code_key UNIQUE (degree_university_short_name, degree_program_code);


--
-- Name: degrees degrees_pkey; Type: CONSTRAINT; Schema: import; Owner: application
--

ALTER TABLE ONLY import.degrees
    ADD CONSTRAINT degrees_pkey PRIMARY KEY (degree_id);


--
-- Name: file_type file_type_pkey; Type: CONSTRAINT; Schema: import; Owner: application
--

ALTER TABLE ONLY import.file_type
    ADD CONSTRAINT file_type_pkey PRIMARY KEY (filetype_id);


--
-- Name: subjects subjects_pkey; Type: CONSTRAINT; Schema: import; Owner: application
--

ALTER TABLE ONLY import.subjects
    ADD CONSTRAINT subjects_pkey PRIMARY KEY (subject_id);


--
-- Name: xls_sheet xls_sheet_pkey; Type: CONSTRAINT; Schema: import; Owner: application
--

ALTER TABLE ONLY import.xls_sheet
    ADD CONSTRAINT xls_sheet_pkey PRIMARY KEY (sheet_id);


--
-- Name: area area_area_name_key; Type: CONSTRAINT; Schema: public; Owner: application
--

ALTER TABLE ONLY public.area
    ADD CONSTRAINT area_area_name_key UNIQUE (area_name);


--
-- Name: area area_pkey; Type: CONSTRAINT; Schema: public; Owner: application
--

ALTER TABLE ONLY public.area
    ADD CONSTRAINT area_pkey PRIMARY KEY (area_id);


--
-- Name: university university_pkey; Type: CONSTRAINT; Schema: public; Owner: application
--

ALTER TABLE ONLY public.university
    ADD CONSTRAINT university_pkey PRIMARY KEY (university_id);


--
-- Name: university university_university_number_key; Type: CONSTRAINT; Schema: public; Owner: application
--

ALTER TABLE ONLY public.university
    ADD CONSTRAINT university_university_number_key UNIQUE (university_number);


--
-- Name: university university_university_short_name_key; Type: CONSTRAINT; Schema: public; Owner: application
--

ALTER TABLE ONLY public.university
    ADD CONSTRAINT university_university_short_name_key UNIQUE (university_short_name);


--
-- Name: xls_sheet fk_sheet_filetype_id; Type: FK CONSTRAINT; Schema: import; Owner: application
--

ALTER TABLE ONLY import.xls_sheet
    ADD CONSTRAINT fk_sheet_filetype_id FOREIGN KEY (filetype_id) REFERENCES import.file_type(filetype_id);


--
-- PostgreSQL database dump complete
--

