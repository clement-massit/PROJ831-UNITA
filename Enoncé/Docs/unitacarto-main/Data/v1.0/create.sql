------------------------------------------------------------------------------------------------------------------------
--ROC 2022-01-13 - UNIVERSITY
------------------------------------------------------------------------------------------------------------------------
CREATE TABLE public.university (
    university_id            INT PRIMARY KEY
    , university_number        INT UNIQUE
    , university_role          VARCHAR(3)    NOT NULL
    , university_short_name    VARCHAR(10)   NOT NULL UNIQUE
    , university_original_name VARCHAR(50)   NOT NULL
    , university_english_name  VARCHAR(50)   NOT NULL
    , university_country       VARCHAR(50)   NOT NULL
    , university_website       VARCHAR(100) NULL
    , university_description   TEXT NULL
    --, university_img           TEXT           NULL
    , university_latitude      DECIMAL(9, 6) NOT NULL
    , university_longitude     DECIMAL(9, 6) NOT NULL
    , university_students      INT           NOT NULL
    --DATES
	, begin_date               DATE NOT NULL DEFAULT current_date
	, end_date                 DATE NULL
    , creation_date            TIMESTAMP NOT NULL DEFAULT now()
	, last_modified_date       TIMESTAMP NOT NULL DEFAULT now()
    --USERS
    , creation_user            VARCHAR(50) DEFAULT 'admin'
    , last_modified_user       VARCHAR(50) DEFAULT 'admin'
);
INSERT INTO public.university( university_id
                      , university_number
                      , university_role
                      , university_short_name
                      , university_original_name
                      , university_english_name
                      , university_country
                      , university_website
                      , university_description
                        -- , university_img
                      , university_latitude
                      , university_longitude
                      , university_students

)VALUES ( 1, 1, 'COO', 'UNITO', 'Università degli studi di Torino', 'Univerity of Turin', 'Italy', 'https://en.unito.it/'
       , 'The University of Turin is one of the most ancient and prestigious Italian Universities. Hosting over 79.000 students and with 120 buildings in different areas in Turin and in key places in Piedmont, the University of Turin can be considered as “city-within-a-city”, promoting culture and producing research, innovation, training and employment. The University of Turin is today one of the largest Italian Universities, open to international research and training. It carries out scientific research and organizes courses in all disciplines, except for Engineering and Architecture.'
    --, 'UNITO.png'
       , 45.069458, 7.689125, 81700)
     , ( 2, 2, 'BEN', 'UBI', 'Universidade Beira Interior', 'University Beira Interior', 'Portugal', 'https://www.ubi.pt/'
       , 'Nowadays, UBI is a national and international reference institution, in the spheres of education, research, innovation and entrepreneurship. More and more concerned about quality, UBI has invested in the creation of well-equipped laboratories, in the expansion of its facilities, in the involvement in research projects of national and international scope, and in a qualified teaching staff. Two of the hallmarks of this University are the provision of laboratories in all teaching areas and teacher-student proximity education.'
    -- , 'UBI.png'
       , 40.278119, -7.509017, 7000)
     , ( 3, 3, 'BEN', 'UNIZAR', 'Universidad de Zaragoza', 'University of Zaragoza', 'Spain', 'https://www.unizar.es/'
       , 'UPPA offers its students initial or continuing education, work/study programmes or apprenticeships, to obtain Bachelor’s, Master’s and vocational degrees and Doctorates through its 5 UFRs (Teaching and Research units) and two Doctoral schools. The university also includes two IUTs (University Institute of Technology), one IAE (University School of Management), two engineering schools (ENSGTI, covering industrial technology engineering and ISA BTP covering construction), a continuing education department and an apprenticeship training centre.'
    --, 'UNIZAR.png'
       , 41.642495, - 0.901448, 39664)
     , ( 4, 4, 'BEN', 'UPPA', 'Université de Pau et des Pays de l''Adour', 'Université of Pau and Pays de l''Adour', 'France', 'https://www.univ-pau.fr/fr/index.html'
       , 'UPPA offers its students initial or continuing education, work/study programmes or apprenticeships, to obtain Bachelor’s, Master’s and vocational degrees and Doctorates through its 5 UFRs (Teaching and Research units) and two Doctoral schools. The university also includes two IUTs (University Institute of Technology), one IAE (University School of Management), two engineering schools (ENSGTI, covering industrial technology engineering and ISA BTP covering construction), a continuing education department and an apprenticeship training centre.'
    --, 'UPPA.png'
       , 43.314337, -0.366594, 13500)
     , ( 5, 5, 'BEN', 'USMB', 'Université Savoie Mont Blanc', 'Université of Savoie Mont Blanc', 'France', 'https://www.univ-smb.fr/'
       , 'With 15,000 students, a rich offer of multidisciplinary academics and 19 internationally recognised laboratories at research , the University of Savoie Mont Blanc (Chambéry) is a human-sized establishment that combines proximity to its territories, membership of the PRES Université de Grenoble as a founding member and a wide opening onto Europe and the world. On its three campuses, Annecy, Bourget-du-Lac and Jacob-Bellecombette, the Université Savoie Mont Blanc offers particularly attractive study conditions in the heart of an exceptional environment.'
    --, 'USMB.png'
       , 45.566874, 5.917561, 15399)
     , ( 6, 6, 'BEN', 'UVT', 'Universitatea de Vest din Timisoara', 'West University of Timisoara', 'Romania', 'https://www.uvt.ro/ro/'
       , 'In recent years, the University has responded to changes in national education policy, demographic change, market economy requirements, local and regional needs and new technologies. All these changes have led to new expectations from students, academic and administrative staff. The West University of Timişoara offers students the necessary training to contribute to the development of society. This training takes place in 11 faculties, which offer a wide range of initial training programs and postgraduate courses.'
    --, 'UVT.png'
       , 45.748093, 21.231490, 16000);
------------------------------------------------------------------------------------------------------------------------
--ROC 2022-01-14 - AREA
------------------------------------------------------------------------------------------------------------------------
CREATE TABLE public.area (
    area_id                 INT             NOT NULL PRIMARY KEY
    , area_name             VARCHAR(50)     NOT NULL UNIQUE
    , area_display_name     VARCHAR(50)     NOT NULL
    --DATES
	, begin_date            DATE NOT NULL DEFAULT current_date
	, end_date              DATE NULL
    , creation_date         TIMESTAMP NOT NULL DEFAULT now()
	, last_modified_date    TIMESTAMP NOT NULL DEFAULT now()
    --USERS
    , creation_user         VARCHAR(50) DEFAULT 'admin'
    , last_modified_user    VARCHAR(50) DEFAULT 'admin'
);
INSERT INTO public.area(area_id
    , area_name
    , area_display_name)
VALUES ( 1, 'Cultural Heritage', 'Cultural Heritage')
    , (2, 'Renewable Energies', 'Renewable Energies')
    , (3, 'Circular Economy', 'Circular Economy');
/*
------------------------------------------------------------------------------------------------------------------------
--ROC 2022-01-18 - role
------------------------------------------------------------------------------------------------------------------------
CREATE TABLE application.role(
    role_id                 INT             NOT NULL PRIMARY KEY
    , role_name             VARCHAR(50)     NOT NULL UNIQUE
    , role_display_name     VARCHAR(50)     NOT NULL
    , role_description      VARCHAR(250)
    --DATES
	, begin_date            DATE NOT NULL DEFAULT current_date
	, end_date              DATE NULL
    , creation_date         TIMESTAMP NOT NULL DEFAULT now()
	, last_modified_date    TIMESTAMP NOT NULL DEFAULT now()
    --USERS
    , creation_user         VARCHAR(50) DEFAULT 'admin'
    , last_modified_user    VARCHAR(50) DEFAULT 'admin'
);
INSERT INTO application.role(role_id
    , role_name
    , role_display_name
    , role_description)
VALUES ( 1, 'superadmin', 'SUPER ADMIN', 'DN''s user will be able to administrate UnitaCarto: create new universities, roles.')
, (2, 'admin', 'ADMIN', 'University administrator''s user will be able to administrate all the UnitaCarto Data from his university.')
, (3, 'student', 'STUDENT', 'University student''s user will be able to see, navigate and build his own plan using "The Education Wikipedia"-UnitaCarto.')
, (4, 'default', 'DEFAULT', 'Default user will be able to see, navigate by "The Education Wikipedia"-UnitaCarto.');
------------------------------------------------------------------------------------------------------------------------
--ROC 2022-01-27 - user
------------------------------------------------------------------------------------------------------------------------
CREATE TABLE application.user(
    user_id                 INT             NOT NULL PRIMARY KEY
    , user_mail             VARCHAR(250)    NOT NULL UNIQUE
    , role_id               INT             NOT NULL
    --DATES
	, begin_date            DATE NOT NULL DEFAULT current_date
	, end_date              DATE NULL
    , creation_date         TIMESTAMP NOT NULL DEFAULT now()
	, last_modified_date    TIMESTAMP NOT NULL DEFAULT now()
    --USERS
    , creation_user         VARCHAR(50) DEFAULT 'admin'
    , last_modified_user    VARCHAR(50) DEFAULT 'admin'
    --FK
    , CONSTRAINT fk_user_role_id FOREIGN KEY(role_id) REFERENCES application.role(role_id)
);
INSERT INTO application.user(user_id, user_mail, role_id)
VALUES ( 1, 'rocio.camacho-rodriguez@univ-smb.fr', 1);
------------------------------------------------------------------------------------------------------------------------
--ROC 2022-01-18 - LOGGER - SI REACT NO NEED
------------------------------------------------------------------------------------------------------------------------
CREATE TABLE logger.log_service (
                        id               SERIAL PRIMARY KEY
                        , creation_date    TIMESTAMP DEFAULT NOW() NOT NULL
                        , type             VARCHAR(5)              NOT NULL
                        , application_name VARCHAR(50)             NOT NULL
                        , service_name     VARCHAR(50)             NOT NULL
                        , service_function VARCHAR(50)             NOT NULL
                        , content          json
                        ,  message          TEXT
);
------------------------------------------------------------------------------------------------------------------------
--ROC 2022-02-16 - IMPORT
------------------------------------------------------------------------------------------------------------------------
CREATE TABLE import.file_type(
    filetype_id             INT             NOT NULL PRIMARY KEY
    , filetype_type         VARCHAR(5)      NOT NULL /*XLS/JSON/CSV*/
    , filetype_name         VARCHAR(50)     NOT NULL
    --DATES
	, begin_date            DATE NOT NULL DEFAULT current_date
	, end_date              DATE NULL
    , creation_date         TIMESTAMP NOT NULL DEFAULT now()
	, last_modified_date    TIMESTAMP NOT NULL DEFAULT now()
    --USERS
    , creation_user         VARCHAR(50) DEFAULT 'admin'
    , last_modified_user    VARCHAR(50) DEFAULT 'admin'

);
INSERT INTO import.file_type(filetype_id
    , filetype_name
    ,filetype_type)
VALUES ( 1, 'SUBJECT', 'XLS')
, (2, 'DEGREE', 'XLS')
, (3, 'exemple for the future', 'CSV')
, (4, 'exemple for the future', 'JSON');
CREATE TABLE import.xls_sheet(
    sheet_id                    INT             NOT NULL PRIMARY KEY
    , sheet_name                VARCHAR(50)     NOT NULL
    , sheet_column_validator    TEXT           NULL
    , filetype_id               INT             NOT NULL
    , area_id                   INT             NOT NULL
    --DATES
	, begin_date            DATE NOT NULL DEFAULT current_date
	, end_date              DATE NULL
    , creation_date         TIMESTAMP NOT NULL DEFAULT now()
	, last_modified_date    TIMESTAMP NOT NULL DEFAULT now()
    --USERS
    , creation_user         VARCHAR(50) DEFAULT 'admin'
    , last_modified_user    VARCHAR(50) DEFAULT 'admin'
 --FK
   -- , CONSTRAINT fk_sheet_area_id FOREIGN KEY(area_id) REFERENCES public.area(area_id) --NEW FORMAT NOT ALLOW TO DO THAT
    , CONSTRAINT fk_sheet_filetype_id FOREIGN KEY(filetype_id) REFERENCES import.file_type(filetype_id)
);
INSERT INTO import.xls_sheet(sheet_id
    , sheet_name, area_id, filetype_id)
VALUES ( 1, 'Renewable Energy - Bachelor', 2, 1)
, (2, 'Renewable Energy - Master', 2, 1)
, (3, 'Cultural Heritage - Bachelor', 1, 1)
, (4, 'Cultural Heritage - Master', 1, 1)
, (5, 'Circular Economy - Bachelor', 3, 1)
, (6, 'Circular Economy - Master', 3, 1);

CREATE TABLE import.file(
    file_id                INT             NOT NULL PRIMARY KEY
    , file_path              VARCHAR(50)
)

CREATE TABLE import.xls(
      xls_id                INT             NOT NULL PRIMARY KEY
    , xls_path              VARCHAR(50)
    , xls_name              VARCHAR(250)
    , xls_overwrite_data    BOOLEAN             DEFAULT FALSE
    , xls_processed         BOOLEAN             DEFAULT FALSE
    , filetype_id           INT             NOT NULL
    , university_id         INT             NOT NULL
    , user_id               INT             NOT NULL DEFAULT 1
    --DATES
	, begin_date            DATE NOT NULL DEFAULT current_date
	, end_date              DATE NULL
    , creation_date         TIMESTAMP NOT NULL DEFAULT now()
	, last_modified_date    TIMESTAMP NOT NULL DEFAULT now()
    --USERS
    , creation_user         VARCHAR(50) DEFAULT 'admin'
    , last_modified_user    VARCHAR(50) DEFAULT 'admin'
    --FK
    , CONSTRAINT fk_filetype_id FOREIGN KEY(filetype_id) REFERENCES import.file_type(filetype_id)
    , CONSTRAINT fk_university_id FOREIGN KEY(university_id) REFERENCES public.university(university_id)
    , CONSTRAINT fk_user_id FOREIGN KEY(user_id) REFERENCES application.user(user_id)
);
*/