const db = require('../config/db');

const Payment = {
  async create(payment) {
    const keys = Object.keys(payment);
    const values = Object.values(payment);
    const placeholders = keys.map(() => '?').join(',');
    const [r] = await db.query(`INSERT INTO payments (${keys.join(',')}) VALUES (${placeholders})`, values);
    return r.insertId;
  },
  async findById(id) {
    const [rows] = await db.query('SELECT * FROM payments WHERE id=?', [id]);
    return rows[0];
  }
};

module.exports = Payment;
