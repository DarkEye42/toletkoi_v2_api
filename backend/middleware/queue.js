const Queue = require('bull');
const env = require('../config/envConfig');
const redisUrl = env.REDIS_URL || 'redis://localhost:6379';

const emailQueue = new Queue('email', redisUrl);

module.exports = { emailQueue };
