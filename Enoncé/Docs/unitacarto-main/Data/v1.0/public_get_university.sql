------------------------------------------------------------------------------------------------------------------------
--ROC 2022-01-18
------------------------------------------------------------------------------------------------------------------------
--Description: get role by user
------------------------------------------------------------------------------------------------------------------------
--PARAMETERS:
--
------------------------------------------------------------------------------------------------------------------------
--EXEC:
--
-- select  * from public.get_university('{"university_id" : 1, "university_short_name":null}'::json);
-- select  * from public.get_university('{"university_id" : 0, "university_short_name": "UNIZAR"}'::json);
------------------------------------------------------------------------------------------------------------------------
-- drop FUNCTION public.get_university(params JSON);
------------------------------------------------------------------------------------------------------------------------
CREATE FUNCTION public.get_university(params JSON)
RETURNS json
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
$$ LANGUAGE plpgsql;
