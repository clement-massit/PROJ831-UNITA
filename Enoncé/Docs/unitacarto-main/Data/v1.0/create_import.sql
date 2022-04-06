------------------------------------------------------------------------------------------------------------------------
--ROC 2022-03-01 - IMPORT
------------------------------------------------------------------------------------------------------------------------
create table import.degrees (
      degree_faculty                TEXT
    , degree_department             TEXT
    , degree_type                   TEXT
    , degree_program_name           TEXT
    , degree_program_code           TEXT
    , degree_diploma_field          TEXT
    , degree_ects                   TEXT
    , degree_teaching_language      TEXT
    , degree_admission              TEXT
    , degree_contact_coordinator    TEXT
    , degree_contact_support        TEXT
    , degree_link                   TEXT
    , degree_cultural_heritage      TEXT
    , degree_renewable_energy       TEXT
    , degree_circular_economy       TEXT
    , degree_university_short_name  TEXT
    , degree_id                     INTEGER not null generated always as identity (increment by 1) PRIMARY KEY
    --PK
    , UNIQUE(degree_university_short_name, degree_program_code)
);

create table import.subjects (
    subject_code                        TEXT
    , subject_title                     TEXT
    , subject_program_code              TEXT
    , subject_field                     TEXT
    , subject_ects                      TEXT
    , subject_semester                  TEXT
    , subject_year                      TEXT
    , subject_teaching_language         TEXT
    , subject_english_friendly          TEXT
    , subject_virtual_mobility          TEXT
    , subject_requisites_mandatory      TEXT
    , subject_requisites_recommended    TEXT
    , subject_requisites_identified     TEXT
    , subject_description               TEXT
    , subject_contact_teacher           TEXT
    , subject_contact_support           TEXT
    , subject_link                      TEXT
    , subject_circular_economy          TEXT
    , subject_cultural_heritage         TEXT
    , subject_renewable_energies        TEXT
    , subject_university_short_name     TEXT
    , subject_id                        INTEGER not null generated always as identity (increment by 1) PRIMARY KEY
);
create table public.datareports (
      degree_faculty                TEXT
    , degree_department             TEXT
    , degree_type                   TEXT
    , degree_program_name           TEXT
    , degree_program_code           TEXT
    , degree_diploma_field          TEXT
    , degree_ects                   TEXT
    , degree_teaching_language      TEXT
    , degree_admission              TEXT
    , degree_contact_coordinator    TEXT
    , degree_contact_support        TEXT
    , degree_link                   TEXT
    , degree_cultural_heritage      TEXT
    , degree_renewable_energy       TEXT
    , degree_circular_economy       TEXT
    , degree_university_short_name  TEXT
    , degree_id                     INTEGER
    --PK
    ,  subject_code                 TEXT
    , subject_title                     TEXT
    , subject_program_code              TEXT
    , subject_field                     TEXT
    , subject_ects                      TEXT
    , subject_semester                  TEXT
    , subject_year                      TEXT
    , subject_teaching_language         TEXT
    , subject_english_friendly          TEXT
    , subject_virtual_mobility          TEXT
    , subject_requisites_mandatory      TEXT
    , subject_requisites_recommended    TEXT
    , subject_requisites_identified     TEXT
    , subject_description               TEXT
    , subject_contact_teacher           TEXT
    , subject_contact_support           TEXT
    , subject_link                      TEXT
    , subject_circular_economy          TEXT
    , subject_cultural_heritage         TEXT
    , subject_renewable_energies        TEXT
    , subject_university_short_name     TEXT
    , subject_id                        INTEGER
    , area                              TEXT
);
