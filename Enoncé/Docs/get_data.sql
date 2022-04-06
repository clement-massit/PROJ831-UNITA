------------------------------------------------------------------------------------------------------------------------
--ROC 2021-03-09
------------------------------------------------------------------------------------------------------------------------
--Description:get data
------------------------------------------------------------------------------------------------------------------------
--PARAMETERS:
-- limit = number of lines
------------------------------------------------------------------------------------------------------------------------
--EXEC:
-- select  * from get_data('{"limit": 10, "offset": 0}'::json);
------------------------------------------------------------------------------------------------------------------------
-- drop function get_data(json);
------------------------------------------------------------------------------------------------------------------------
create function get_data(params json) returns json
    language plpgsql
as
$$
DECLARE
        json_result             JSON            =   NULL;
        param_limit             INT             =   0;
        param_offset            INT             =   0;
BEGIN
        --#region --------------------------GET PARAMS-----------------------------------------------------------------
        IF (SELECT params->>'limit' IS NOT NULL) THEN
            SELECT params->>'limit' INTO param_limit;
        END IF;
        IF (SELECT params->>'offset' IS NOT NULL) THEN
            SELECT params->>'offset' INTO param_offset;
        END IF;
        --region --------------------------RETURN JSON----------------------------------------------------------------
        SELECT INTO json_result
                    json_agg(js)
        FROM(
            SELECT
                json_build_object(
						'degree_faculty', datareports.degree_faculty
      					, 'degree_department', datareports.degree_department
      				    , 'degree_type', datareports.degree_type
						, 'degree_program_name', datareports.degree_program_name
                        , 'degree_program_code', datareports.degree_program_code
                        , 'degree_diploma_field', datareports.degree_diploma_field
                        , 'degree_ects', datareports.degree_ects
                        , 'degree_teaching_language', datareports.degree_teaching_language
                        , 'degree_admission', datareports.degree_admission
      					, 'degree_contact_coordinator', datareports.degree_contact_coordinator
      				    , 'degree_contact_support', datareports.degree_contact_support
						, 'degree_link', datareports.degree_link
                        , 'degree_cultural_heritage', datareports.degree_cultural_heritage
                        , 'degree_renewable_energy', datareports.degree_renewable_energy
                        , 'degree_circular_economy', datareports.degree_circular_economy
                        , 'degree_university_short_name', datareports.degree_university_short_name
                        , 'degree_id', datareports.degree_id
                        , 'subject_code', datareports.subject_code
      				    , 'subject_title', datareports.subject_title
						, 'subject_program_code', datareports.subject_program_code
                        , 'subject_field', datareports.subject_field
                        , 'subject_ects', datareports.subject_ects
                        , 'subject_semester', datareports.subject_semester
                        , 'subject_year', datareports.subject_year
                        , 'subject_teaching_language', datareports.subject_teaching_language
      					, 'subject_english_friendly', datareports.subject_english_friendly
      				    , 'subject_virtual_mobility', datareports.subject_virtual_mobility
						, 'subject_requisites_mandatory', datareports.subject_requisites_mandatory
                        , 'subject_requisites_recommended', datareports.subject_requisites_recommended
                        , 'subject_requisites_identified', datareports.subject_requisites_identified
      				    , 'subject_description', datareports.subject_description
						, 'subject_contact_teacher', datareports.subject_contact_teacher
                        , 'subject_contact_support', datareports.subject_contact_support
                        , 'subject_link', datareports.subject_link
                        , 'subject_circular_economy', datareports.subject_circular_economy
                        , 'subject_cultural_heritage', datareports.subject_cultural_heritage
                        , 'subject_renewable_energies', datareports.subject_renewable_energies
      					, 'subject_university_short_name', datareports.subject_university_short_name
      				    , 'subject_id', datareports.subject_id
						, 'area', datareports.area
                    --possibility to add data university here
				)js
			from public.datareports
			limit param_limit offset param_offset
        )s;

        RETURN json_result;
END;
$$;
