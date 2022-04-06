------------------------------------------------------------------------------------------------------------------------
--ROC 2022-01-18
------------------------------------------------------------------------------------------------------------------------
--Description: insert webservicelog
------------------------------------------------------------------------------------------------------------------------
--PARAMETERS:
--
------------------------------------------------------------------------------------------------------------------------
--EXEC:
-- select * from logger.insert_log_service('[{"log_id" : 1, "type" : "OUT", "application_name" : "application_name", "service_name" : "service_name", "service_function" : "myfunction", "message" : "hello", "content" : {"id":1,"name": "test"}}]'::json);
------------------------------------------------------------------------------------------------------------------------
-- drop FUNCTION  logger.insert_log_service(json);
------------------------------------------------------------------------------------------------------------------------
CREATE FUNCTION logger.insert_log_service(params JSON)
RETURNS integer
AS $$
    DECLARE
        result      integer = 0;
BEGIN
        INSERT INTO logger.log_service(
                   id
                   , type
                   , application_name
                   , service_name
                   , service_function
                   , content
                   , message
        )
        SELECT (SELECT COALESCE(MAX(id),0) FROM logger.log_service) + ROW_NUMBER() OVER (ORDER BY 1=1)
                 , t->>'type'
                 , t->>'application_name'
                 , t->>'service_name'
                 , t->>'service_function'
                 , logger.format_json(t->>'content')::json
                 , t->>'message'
        FROM JSON_ARRAY_ELEMENTS(params) t;

        GET DIAGNOSTICS result = ROW_COUNT;
        RETURN result;
END;
$$ LANGUAGE plpgsql;