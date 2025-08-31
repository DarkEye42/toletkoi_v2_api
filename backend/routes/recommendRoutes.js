const express = require('express');
const router = express.Router();
const ctrl = require('../controllers/recommendController');

router.get('/:userId', ctrl.recommendForUser);

module.exports = router;
