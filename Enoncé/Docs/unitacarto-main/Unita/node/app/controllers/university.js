const Pool = require('pg').Pool;
const pool = new Pool();

const getUniversity = (request, response) => {
    var id = 0;
    var name =  'null';
    if(request.params.id)
        id = request.params.id;
    if(request.params.name)
        name = `"${request.params.name}"`;  

    var query = `select  * from public.get_university('{"university_id" : ${id} , "university_short_name" : ${name} }'::json);`;
    //RETURN QUERY
    // response.status(200).json(query);
    pool.query(query, (error, results) => {
        if (error) {
            throw error;
        }
        response.status(200).json(results.rows[0]["get_university"]);
    })
}

module.exports = {    
    getUniversity
}