------------------------------------------------------------------------------------------------------------------------
--ROC 2022-01-18
------------------------------------------------------------------------------------------------------------------------
--Description: get roles
------------------------------------------------------------------------------------------------------------------------
--PARAMETERS:
--
------------------------------------------------------------------------------------------------------------------------
--EXEC:
--
-- select  * from application.get_roles('[{"id" : 0}]'::json);
-- select  * from application.get_roles('{"id" : 2}'::json);
------------------------------------------------------------------------------------------------------------------------
-- drop FUNCTION application.get_roles(params JSON);
------------------------------------------------------------------------------------------------------------------------
--one object
/*SELECT
                json_build_object('id',id,
                                'first_name',first_name,
                                'last_name',last_name
)  from test_table;*/

--list of objects
/*SELECT json_agg(
                json_build_object('id',id,
                                'first_name',first_name,
                                'last_name',last_name
))  from test_table;*/
--default
-- SELECT json_agg(test_table) FROM test_table;
------------------------------------------------------------------------------------------------------------------------
CREATE FUNCTION application.get_roles(params JSON)
RETURNS json
AS $$
    DECLARE
        json_result          JSON       =   NULL;
        param_id             INT        =   0;
BEGIN
    IF (SELECT params->>'id' IS NOT NULL) THEN
        SELECT params->>'id' INTO param_id;
    END IF;

    SELECT INTO json_result
                json_agg(
                    json_build_object(
                        'role_id', role_id
                        , 'role_name', role_name
                        , 'role_display_name', role_display_name
                        , 'role_description', role_description
                    )
                )
    FROM application.role
    WHERE role.role_id = COALESCE(NULLIF(param_id, 0) , role.role_id);

    RETURN json_result;

END;
$$ LANGUAGE plpgsql;
