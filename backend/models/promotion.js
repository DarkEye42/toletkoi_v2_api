const db = require('../config/db');

const Promotion = {
  async create(promotion) {
    const keys = Object.keys(promotion);
    const values = Object.values(promotion);
    const placeholders = keys.map(() => '?').join(',');
    const [r] = await db.query(`INSERT INTO promotions (${keys.join(',')}) VALUES (${placeholders})`, values);
    return r.insertId;
  },
  async findByAdId(ad_id) {
    const [rows] = await db.query('SELECT * FROM promotions WHERE ad_id=?', [ad_id]);
    return rows;
  }
};

module.exports = Promotion;
