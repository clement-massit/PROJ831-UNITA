SELECT *
FROM

    (SELECT *
, 'Circular Economy' as area
FROM import.degrees
INNER JOIN import.subjects
ON subjects.subject_university_short_name = degrees.degree_university_short_name
AND subjects.subject_program_code = degrees.degree_program_code
where subjects.subject_circular_economy = '1')a

UNION

(SELECT *
, 'Cultural Heritage' as area
FROM import.degrees
INNER JOIN import.subjects
ON subjects.subject_university_short_name = degrees.degree_university_short_name
AND subjects.subject_program_code = degrees.degree_program_code
where subjects.subject_cultural_heritage = '1')

union


(SELECT *
    , 'Renewable Energies' as area
FROM import.degrees
INNER JOIN import.subjects
ON subjects.subject_university_short_name = degrees.degree_university_short_name
AND subjects.subject_program_code = degrees.degree_program_code
where subjects.subject_renewable_energies = '1');

