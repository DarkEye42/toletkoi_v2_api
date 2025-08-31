const mysql = require('mysql2');
const env = require('./envConfig');
const pool = mysql.createPool({
  host: env.DB_HOST || '127.0.0.1',
  user: env.DB_USER || 'root',
  password: env.DB_PASS || '',
  database: env.DB_NAME || 'toletkoi',
  waitForConnections: true,
  connectionLimit: 10,
  queueLimit: 0
});
module.exports = pool.promise();
