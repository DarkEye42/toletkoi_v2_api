const express = require('express');
const { body } = require('express-validator');
const router = express.Router();
const ctrl = require('../controllers/userController');
const validate = require('../middleware/validate');

router.post('/register', [
  body('email').isEmail(),
  body('password').isLength({ min: 6 }),
  body('username').notEmpty()
], validate, ctrl.register);

router.post('/login', [
  body('email').isEmail(),
  body('password').notEmpty()
], validate, ctrl.login);

module.exports = router;
