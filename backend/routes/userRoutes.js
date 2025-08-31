const express = require('express');
const router = express.Router();
const ctrl = require('../controllers/userController');

router.post('/register', ctrl.register);
router.post('/login', ctrl.login);
router.get('/profile/:idOrSlug', ctrl.profile);
router.post('/switch-role', ctrl.switchRole);

module.exports = router;
