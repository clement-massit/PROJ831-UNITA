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
-- select  * from application.get_role('{"user_mail" : "rocio.camacho-rodriguez@univ-smb.fr"}'::json);
-- select  * from application.get_role('{"user_mail" : ""}'::json);
------------------------------------------------------------------------------------------------------------------------
-- drop FUNCTION application.get_role(params JSON);
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
CREATE FUNCTION application.get_role(params JSON)
RETURNS json
AS $$
    DECLARE
        json_result          JSON           =   NULL;
        param_user_mail      VARCHAR(250)   =   NULL;
BEGIN
    IF (SELECT  NULLIF(params->>'user_mail', '') IS NOT NULL) THEN
        SELECT params->>'user_mail' INTO param_user_mail;
    END IF;

    SELECT INTO json_result
        json_build_object(
            'role_id', role.role_id
            , 'role_name', role.role_name
            , 'role_display_name', role.role_display_name
            , 'role_description', role.role_description
        )
    FROM application.role
    INNER JOIN application.user
ON application.user.role_id = role.role_id
    WHERE application.user.user_mail = param_user_mail;

    RETURN json_result;

END;
$$ LANGUAGE plpgsql;
