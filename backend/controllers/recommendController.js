const db = require('../config/db');
exports.recommendForUser = async (req,res)=>{
  try{
    const userId = req.params.userId;
    const [ads] = await db.query(`
      SELECT rp.*, IFNULL(v.vcount,0) as views, IFNULL(f.fcount,0) as favs,
      (IFNULL(v.vcount,0) + IFNULL(f.fcount,0)*3) as score
      FROM rental_posts rp
      LEFT JOIN (SELECT ad_id, COUNT(*) as vcount FROM ad_views GROUP BY ad_id) v ON v.ad_id=rp.id
      LEFT JOIN (SELECT ad_id, COUNT(*) as fcount FROM favorites GROUP BY ad_id) f ON f.ad_id=rp.id
      ORDER BY score DESC LIMIT 10
    `);
    const [products] = await db.query(`
      SELECT p.*, IFNULL(v.vcount,0) as views, (IFNULL(v.vcount,0)) as score
      FROM products p
      LEFT JOIN (SELECT product_id, COUNT(*) as vcount FROM product_views GROUP BY product_id) v ON v.product_id=p.id
      ORDER BY score DESC LIMIT 10
    `);
    res.json({ads, products});
  }catch(e){ res.status(500).json({error:e.message}); }
};
