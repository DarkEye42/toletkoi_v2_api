const express = require('express');
const router = express.Router();
const ctrl = require('../controllers/blogController');

router.post('/create', ctrl.create);
router.get('/slug/:slug', ctrl.getBySlug);
router.post('/track-view/:id', ctrl.trackView);

module.exports = router;
