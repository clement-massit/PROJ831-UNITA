CREATE FUNCTION logger.format_json(params TEXT)
RETURNS JSON
AS $$
BEGIN
    return regexp_replace(params , E'[\\n\\r\\t ]+', ' ', 'g' )::json;
END;
$$ LANGUAGE plpgsql;