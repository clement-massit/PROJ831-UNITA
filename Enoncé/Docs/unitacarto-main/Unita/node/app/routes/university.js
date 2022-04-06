const controller = require('../controllers/university');
const router = require('express').Router();

//CRUD
router
  .get('/', controller.getUniversity)
  .get('/:id', controller.getUniversity)    //university_id
  .get('/:id/:name', controller.getUniversity)  //university_short_name

module.exports = router;